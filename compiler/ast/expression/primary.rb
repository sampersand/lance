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

        if (first = Expression.parse(parser))
          new primary, [first] + parser.delineated(delim: ',', end: ')'){ Expression.parse parser }
        else
          parser.expect ')', err: 'missing `)` to close function call'
          new primary, []
        end
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
