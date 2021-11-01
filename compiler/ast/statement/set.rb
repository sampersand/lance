require_relative '../expression'

class Statement
  class Set
    def initialize(name, type, value)
      @name = name
      @type = type
      @value = value
    end

    def self.parse(parser)
      parser.guard 'set' or return

      raise 'todo: set (eg `.`)'
      # name = parser.identifier err: 'missing variable for `set` statement'
      # if parser.guard
      # type = TypeDecl.parse parser # can be nil for implicit type

      # parser.expect '=', err: 'missing `=` in `set` statement'
      # value = Expression.parse parser # can be nil for predeclaring values.

      parser.endline err: 'missing endline for `set`'

      new name, type, value
    end
  end
end
