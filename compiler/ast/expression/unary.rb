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

    def llvm_type
      case @op
      when '!' then Compiler::Type::Primitive::Bool
      when '+', '-' then Compiler::Type::Primitive::Num
      else raise "undefined unary operator '#@op'"
      end
    end

    def compile(type:)
      rhs = @expr.compile type: type

      $fn.validate_types expected: llvm_type, given: type
      case @op
      when '!'
        cmp = $fn.write :new, "icmp eq %num #{rhs}, 0"
        $fn.write :new, "zext i1 #{cmp} to %bool"

      when '-' then $fn.write :new, "sub nsw %num 0, #{rhs}"
      when '+' then # we don't actually do anything for `+`
      else raise "unknown unary operator '#@op'"
      end
    end
  end
end
