class Expression
  class Unary
    def initialize(op, expr)
      @op = op
      @expr = expr
    end

    def self.parse(parser)
      op = parser.guard('+', '-', '!') or return
      expr = Primary.parse(parser) or parser.error "expected primary after `#{op}`"
      new op, expr
    end

    def compile(type:)
      rhs = @expr.compile type: type

      case @op
      when '!'
        $fn.validate_types expected: Compiler::Type::Primitive::Bool, given: type
        cmp = $fn.write :new, "icmp eq %num #{rhs}, 0"
        $fn.write :new, "zext i1 #{cmp} to %bool"

      when '-'
        $fn.validate_types expected: Compiler::Type::Primitive::Num, given: type
        $fn.write :new, "sub nsw %num 0, #{rhs}"

      when '+'
        $fn.validate_types expected: Compiler::Type::Primitive::Num, given: type
        # we don't actually do anything for `+`

      else
        raise "unknown unary operator '#@op'"
      end
    end
  end
end
