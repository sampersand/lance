class Expression
  class Unary
    def initialize(op, rhs)
      @op = op
      @rhs = rhs
    end

    def self.parse(parser)
      op = parser.guard('+', '-', '!') or return
      rhs = Primary.parse(parser) or parser.error "expected primary after `#{op}`"
      new op, rhs
    end
  end
end
