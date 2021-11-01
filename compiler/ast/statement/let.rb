require_relative '../expression'

class Statement
  class Let
    def initialize(name, type, value)
      @name = name
      @type = type
      @value = value
    end

    def self.parse(parser)
      parser.guard 'let' or return

      name = parser.identifier err: 'missing variable for `let` statement'
      type = TypeDecl.parse parser # can be nil for implicit type

      parser.expect '=', err: 'missing `=` in `let` statement'
      value = Expression.parse parser # can be nil for predeclaring values.
      parser.endline err: 'missing endline for `let`'

      new name, type, value
    end
  end
end
