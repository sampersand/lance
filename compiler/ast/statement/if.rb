require_relative '../expression'

class Statement
  class If
    def initialize(cond, body, else_)
      @cond = cond
      @body = body
      @else_ = else_
    end

    def self.parse(parser)
      parser.guard 'if' or return
      cond = Expression.parse(parser) or parser.error 'missing condition for `if`'
      body = Statement.parse_statements(parser) or parser.error 'missing body for `if`'

      if parser.guard 'else'
        if parser.peek? 'if'
          else_ = parse(parser) or parser.error 'invalid if for `else if`'
        else
          else_ = Statement.parse_statements(parser) or parser.error 'missing body for `else`'
        end
      end

      new cond, body, else_
    end
  end
end
