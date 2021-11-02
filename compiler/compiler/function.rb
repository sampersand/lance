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

      def initialize(name, type, local)
        @name = name
        @type = type
        @local = local
      end

      def to_s
        local.to_s
      end

      def llvm_type
        @type
      end
    end

    attr_reader :name, :args, :return_type

    def initialize(name, args, return_type, body)
      @name = name
      @return_type = return_type || Type::Primitive::Void
      @locals = 0
      @local_variables = {}
      @args = args.map { |name, type| define_variable name, type }
      next_local # ignore it for some reason, idk why llvm does it
      @body = body
      @lines = []
    end

    def llvm_type
      @llvm_type ||= Compiler::Type::Function.new @args.map(&:type), @return_type
    end

    def next_local
      Local.new((@locals += 1) - 1)
    end
    alias next_label next_local

    def define_variable(name, type)
      raise "variable '#{name}' already exists for fn '#@name'" if @local_variables.key? name
      name = name.to_s

      @local_variables[name] = Variable.new name, type, next_local
    end

    def lookup(name)
      name = name.to_s
      @local_variables[name] || $compiler.lookup_global(name) or raise "unknown variable '#{name}' for '#{function}'"
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

    def declare_label(label=next_label)
      write "#{label.num}:"
      label
    end

    def compile
      $function = self
      $llvm.declare_function @name, @args, @return_type do
        @body.compile

        if @return_type == Compiler::Type::Primitive::Void
          write 'ret void'
        end

        @lines
      end
    end

    alias $function $fn
  end
end
__END__

#   def to_s
#     <<~LLVM
#       define #{return_type} #{internal_name}(#{args.join ', '}) {
#         #{@lines.join("\n  ")}
#       }
#     LLVM
#   end
# end
end
#   attr_reader :user_defined_name, :args, :return_type

#   def initialize(name, args, return_type)
#     @user_defined_name = name
#     @args = args
#     @return_type = return_type

#     @lines = []
#     @labels = Hash.new { |h,k| h[k] = next_local }
#     @local_variables = Hash.new { |h,k| h[k] = next_local }
#     @local = 0
#   end

#   def 


#   def internal_name
#     "@_lc_user_#{user_defined_name}"
#   end

#   def next_local
#     (@local += 1).to_s
#   end

#   def label(name)
#     @labels[name]
#   end

#   def write(return_line=false, line)
#     if return_line
#       "%#{next_local}".tap { |lcl| write "#{lcl} = #{line}" }
#     else
#       @lines.push line
#     end
#   end

#   def to_s
#     <<~LLVM
#       define #{return_type} #{internal_name}(#{args.join ', '}) {
#         #{@lines.join("\n  ")}
#       }
#     LLVM
#   end
# end

# f = Function.new 'foo', [], 'void'
# puts f
