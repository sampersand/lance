require_relative 'type'
class Compiler
  class Function
    class Local
      attr_reader :num

      def initialize(num)
        @num = num
      end

      def to_s
        "%#{num}"
      end
    end

    class Variable
      attr_reader :name, :type, :local

      def initialize(name, type, local, is_arg)
        @name = name
        @type = type
        @local = local
        @is_arg = is_arg
      end

      def arg?
        @is_arg
      end

      def to_s
        local.to_s
      end

      def llvm_type
        @type
      end
    end

    attr_reader :name, :args, :return_type

    Label = Struct.new :name, :idx, :jmps

    def initialize(name, args, return_type, body, is_private)
      @name = name
      @return_type = return_type || Type::Primitive::Void
      @locals = 0
      @local_variables = {}
      @body = body
      @is_private = is_private
      @lines = []
      @whiles = []
      @debug_counter = 0
      @labels = Hash.new { |h,k| h[k] = Label.new(k, nil, []) }

      @args = args.map { |name, type|  define_variable name, type, arg: true }
      next_local # ignore it for some reason, idk why llvm does it
    end

    attr_accessor :whiles

    def llvm_type
      @llvm_type ||= Compiler::Type::Function.new args.map(&:type), return_type
    end

    def next_local
      Local.new((@locals += 1) - 1)
    end

    alias next_label next_local

    def define_variable(name, type, arg: false, local: nil)
      name = name.to_s

      if name == '_' && (t = @local_variables[name])
        return t
      end

      raise "variable '#{name}' already exists for fn '#@name'" if @local_variables.key? name

      @local_variables[name] = Variable.new name, type, (local || next_local), arg
    end

    def lookup(name, error: true)
      name = name.to_s
      @local_variables[name] || $compiler.lookup(name) or (error && raise("unknown variable '#{name}' for '#{@name}'"))
    end

    def to_s
      $llvm.fn_name_for name
    end

    def llvm_name
      "@_lc_user_#@name"
    end

    def validate_types(expected:, given:, allow_any: true)
      return if allow_any && (expected == :any || given == :any)

      if expected != given
        raise "invalid type: expected #{expected.inspect}, got a #{given.inspect}"
      end
    end

    def section(msg)
      return yield unless $DEBUG
      debug_counter = (@debug_counter += 1)
      write "; [#{debug_counter}] Begin #{msg}"
      yield.tap { write "; [#{debug_counter}] End #{msg}" }
    end

    def write(local=nil, line, at: nil)
      if local == :new
        local = next_local
      end

      if local
        line = "#{local} = #{line}"
      end

      if at
        @lines[at] = line
      else
        @lines.push line
      end

      local
    end

    JmpTarget = Struct.new :index, :fn do
      def write(*x)
        fn.write(*x, at: index)
      end
    end

    def write_nop
      write nil

      JmpTarget.new @lines.length - 1, self
    end

    def declare_user_label(name)
      lbl = @labels[name]

      if lbl.idx
        raise "label #{name.inspect} already declared"
      end

      lbl.idx = declare_label

      lbl.jmps.each do |jmp|
        jmp.write "br label #{lbl.idx}"
      end

      lbl.jmps.clear
      lbl.idx
    end

    def declare_user_jump(name)
      lbl = @labels[name]
      jmp = write_nop
      @locals += 1 # b/c `write_nop` doesnt set it

      if lbl.idx
        jmp.write "br label #{lbl.idx}"
      else
        lbl.jmps.push jmp
      end
    end

    def declare_label(label=next_label)
      if $OLD_VERSION
        write "; <label>:#{label}:"
      else
        write "#{label.num}:"
      end
      label
    end

    def compile
      $fn = self
      ret = $llvm.declare_function @name, @args, @return_type, @is_private do
        @body.compile

        if @return_type == Compiler::Type::Primitive::Void
          write 'ret void'
        elsif @name == 'main'
          write 'ret i64 0'
        end

        @lines
      end

      $__compare_functions ||= {}
      if @name =~ /\.compare$/ && !$__compare_functions[@name]
        $__compare_functions[@name] = 1
        raise "only 2 args allowed for 'compare'" unless @args.length == 2
        raise "args must be equal for 'compare'" unless @args[0].llvm_type == args[1].llvm_type
        ty = @args[0].llvm_type

        $llvm.write_inline <<~LLVM
          define i1 @fn.user.#{@name.sub /\.compare$/, '.__compare' }(i64 %0, i64 %1) {
              %3 = inttoptr i64 %0 to #{ty}
              %4 = inttoptr i64 %1 to #{ty}
              %5 = tail call i64 @fn.user.#@name(#{ty} %3, #{ty} %4)
              %6 = icmp ne i64 %0, 0
              ret i1 %6
          }
        LLVM
      end

      @labels.each do |_, lbl|
        raise "undeclared label '#{lbl.name}'" unless lbl.jmps.empty?
      end

      ret
    end
  end
end
