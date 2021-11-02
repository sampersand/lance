class Expression
  class Binary
    OPERATORS = %w(+ - * / % < > <= >= == != & |)

    def initialize(lhs, rhs, op)
      @lhs = lhs
      @rhs = rhs
      @op = op
    end

    def self.parse(lhs, parser)
      op = parser.guard(*OPERATORS) or return
      rhs = Expression.parse(parser) or parser.error "missing rhs of '#{op}' operator"
      new lhs, rhs, op
    end

    def compile_sub(type)
      $fn.validate_types expected: Compiler::Type::Primitive::Num, given: type
      lhs = @lhs.compile type: Compiler::Type::Primitive::Num
      rhs = @rhs.compile type: Compiler::Type::Primitive::Num

      $fn.write :new, "sub nsw %num #{lhs}, #{rhs}"
    end

    def compile(type:)
      case @op
      #when '-' then compile_sub fn, llvm, type
      when '-' then compile_sub type
      else raise "unknown op '#@op'??"
      end
    end

    def llvm_type
      # todo
      Compiler::Type::Primitive::Num
    end
  end
end
