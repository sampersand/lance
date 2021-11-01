require_relative '../expression'

class Statement
  class Do
    def initialize(expr)
      @expr = expr
    end

    def self.parse(parser)
      parser.guard 'do' or return
      value = Expression.parse(parser) or parser.error 'missing expr for `do`'
      parser.endline err: 'missing endline for `do`'
      new value
    end

    def compile(fn)
      @expr.compile fn
    end
  end
end
