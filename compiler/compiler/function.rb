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
        "#{type} #{local}"
      end
    end

    attr_reader :name, :args, :return_type

    def initialize(name, args, return_type, compiler:)
      @name = name
      @return_type = return_type || Type::Primitive::Void
      @locals = 0
      @local_variables = {}
      @args = args.map { |name, type| define_variable name, type }
      @compiler = compiler

      @lines = []
    end

    def next_local
      Local.new((@locals += 1) - 1)
    end

    def define_variable(name, type)
      raise "variable '#{name}' already exists for fn '#@name'" if @local_variables.key? name

      @local_variables[name] = Variable.new name, type, next_local
    end

    def lookup(name)
      @local_variables[name] || compiler.lookup_global(name) or raise "unknown variable '#{name}' for '#{function}'"
    end

    def llvm_name
      "@_lc_user_#@name"
    end

    def write(line, local: nil)
      if local == :new
        local = next_local
      end

      if local
        line = "#{local} = #{line}"
      end

      @lines.push line
      local
    end

    def to_llvm
      <<~LLVM
        define #{return_type.to_llvm} #{llvm_name}(#{args.map(&:to_llvm).join ', '}) {
          #{@lines.map(&:to_llvm).join "\n "}
        }
      LLVM
    end
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
