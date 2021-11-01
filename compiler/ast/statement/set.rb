require_relative '../expression'

class Statement
  class Set
    def initialize(prelude, value)
      @prelude = prelude
      @value = value
    end

    def self.parse(parser)
      parser.guard 'set' or return
      prelude = Primary.parse(parser) or parser.error 'missing value to `set` to.'
      # todo: make sure `prelude` is the correct types

      # note: no type, because type should already be known.
      parser.expect '=', err: 'expecting `=` in `set` statement'
      value = Expression.parse(parser) or parser.error 'missing rhs of `set` statement'
      parser.endline err: 'missing endline for `set`'

      new prelude, value
    end
  end
end
