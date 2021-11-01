require_relative '../expression'

class Statement
  class While
    def initialize(cond, body)
      @cond = cond
      @body = body
    end

    def self.parse(parser)
      parser.guard 'while' or return

      cond = Expression.parse(parser) or parser.error 'missing condition for `while`'
      body = Statements.parse(parser) or parser.error 'missing body for `while`'

      new cond, body
    end

    def compile(parser)
  end
end
