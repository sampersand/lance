require_relative '../expression'

class Statement
  class Return
    def initialize(value)
      @value = value
    end

    def self.parse(parser)
      parser.guard 'return' or return
      value = Expression.parse parser # can be nil
      parser.endline err: 'missing endline for `return`'

      new value
    end
  end
end
