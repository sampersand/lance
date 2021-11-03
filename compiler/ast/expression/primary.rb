require_relative 'literal'
require_relative 'unary'

class Expression
  class Primary
    class FunctionCall
      def initialize(fn, args)
        @fn = fn
        @args = args
      end

      def self.parse(primary, parser)
        parser.guard '(' or return

        new primary, parser.delineated(delim: ',', end: ')'){ Expression.parse parser }
      end

      def compile(type:)
        fn_llvm = @fn.llvm_type

        if fn_llvm.return_type != type && type != :any
          raise "return type mismatch (expected #{fn_llvm.return_type.inspect}, got #{type.inspect})"
        else
          fn_llvm.args.zip(@args) do |type, arg|
            if type != arg.llvm_type
              raise "invalid argument type found in function call"
            end
          end
        end

        fn = @fn.compile type: @fn.llvm_type
        args = @args.map { |a| "#{a.llvm_type} #{a.compile(type: a.llvm_type)}" } # we already verified it with `fn`
        return_type = @fn.llvm_type.return_type

        $fn.write( (return_type == Compiler::Type::Primitive::Void ? nil : :new), "call #{return_type} #{fn}(#{args.join ', '})")
      end

      def llvm_type
        @llvm_type ||= @fn.llvm_type.return_type
      end
    end

    class ArrayIndex
      def initialize(ary, index)
        @ary = ary
        @index = index
      end

      def self.parse(primary, parser)
        parser.guard '[' or return
        index = Expression.parse(parser) or parser.error 'expecting index for array access'
        parser.expect ']', err: 'expecting `]` to close array indexing'
        new primary, index
      end
    end

    class FieldAccess
      def initialize(primary, field)
        @primary = primary
        @field = field
      end

      def self.parse(primary, parser)
        parser.guard '.' or return
        field = parser.guard(:identifier) or parser.error 'expected identifier after `.`'
        new primary, field
      end
    end

    def initialize(value)
      @op = value
    end

    def self.parse(parser)
      primary = parse_first(parser) or return

      loop do
        case
        when (tmp = FunctionCall.parse(primary, parser)) then primary = tmp
        when (tmp = ArrayIndex.parse(primary, parser)) then primary = tmp
        when (tmp = FieldAccess.parse(primary, parser)) then primary = tmp
        else return primary
        end
      end
    end

    def self.parse_first(parser)
      Literal.parse(parser) || Unary.parse(parser) || parser.surround('(', ')') { Expression.parse parser }
    end
  end
end
