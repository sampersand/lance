require_relative '../expression'

class Statement
  class Do
    attr_reader :expr

    def initialize(expr)
      @expr = expr
    end

    def self.parse(parser)
      parser.guard 'do' or return
      value = Expression.parse(parser) or parser.error 'missing expr for `do`'
      parser.endline err: 'missing endline for `do`'
      new value
    end

    def compile
      @expr.compile type: :any
    end
  end
end
