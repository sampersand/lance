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

    def compile_add(type)
      lhs = @lhs.compile type: @lhs.llvm_type
      rhs = @rhs.compile type: @lhs.llvm_type

      $fn.validate_types expected: type, given: @lhs.llvm_type

      case @lhs.llvm_type
      when Compiler::Type::Primitive::Num then $fn.write :new, "add nsw %num #{lhs}, #{rhs}"
      when Compiler::Type::Primitive::Str
        $fn.write :new, "call %struct.builtin.str* @fn.builtin.concat_strs(%struct.builtin.str* #{lhs}, %struct.builtin.str* #{rhs})"
      when Compiler::Type::Primitive::List then raise "todo"
      else 
        raise "type error: cannot add #{type}s."
      end
    end

    def compile_mul(type)
      lhs = @lhs.compile type: type
      rhs = @rhs.compile type: Compiler::Type::Primitive::Num # all operands are a number, interestingly enough

      case type
      when Compiler::Type::Primitive::Num then $fn.write :new, "add nsw %num #{lhs}, #{rhs}"
      when Compiler::Type::Primitive::Str
        $fn.write :new, "call %struct.builtin.str* @fn.builtin.repeat_str(%struct.builtin.str* #{lhs}, %num #{rhs})"
      when Compiler::Type::Primitive::List then raise "todo"
      else 
        raise "type error: cannot add #{type}s."
      end
    end

    def compile_eql(type)
      raise "`==` returns a boolean" unless type == Compiler::Type::Primitive::Bool

      lhs = @lhs.compile type: @lhs.llvm_type 
      rhs = @rhs.compile type: @rhs.llvm_type 

      case @lhs.llvm_type
      when Compiler::Type::Primitive::Num then
        tmp = $fn.write :new, "icmp eq %num #{lhs}, #{rhs}"
        $fn.write :new, "zext i1 #{tmp} to %bool"
      else
        raise "type error: cannot comapre #{type}s."
      end
    end

    def compile_eql(type)
      raise "`==` returns a boolean" unless type == Compiler::Type::Primitive::Bool

      lhs = @lhs.compile type: @lhs.llvm_type 
      rhs = @rhs.compile type: @rhs.llvm_type 

      case @lhs.llvm_type
      when Compiler::Type::Primitive::Num then
        tmp = $fn.write :new, "icmp ne %num #{lhs}, #{rhs}"
        $fn.write :new, "zext i1 #{tmp} to %bool"
      else
        raise "type error: cannot comapre #{type}s."
      end
    end

    def compile(type:)
      case @op
      when '+' then compile_add type
      when '-' then compile_sub type
      when '*' then compile_mul type
      when '==' then compile_eql type
      when '!=' then compile_eql type
      else raise "unknown op '#@op'??"
      end
    end

    def llvm_type
      case @op
      when ?+, ?-, ?*, ?/, ?% then @lhs.llvm_type
      when '==', '!=', ?!, ?<, ?>, '<=', '>=' then Compiler::Type::Primitive::Bool
      else raise "unknown type '#@op'"
      end
    end
  end
end
