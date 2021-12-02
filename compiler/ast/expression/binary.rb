class Expression
  class Binary
    OPERATORS = %w(+ - * / % < > <= >= == != && || ? :)

    attr_reader :lhs, :rhs

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
      when Compiler::Type::Primitive::List
        $fn.write :new, "call %struct.builtin.list* @fn.builtin.concat_lists(%struct.builtin.list* #{lhs}, %struct.builtin.list* #{rhs})"
      else 
        raise "type error: cannot add #{type}s."
      end
    end

    def compile_mul(type)
      lhs = @lhs.compile type: type
      rhs = @rhs.compile type: Compiler::Type::Primitive::Num # all operands are a number, interestingly enough

      case type
      when Compiler::Type::Primitive::Num then $fn.write :new, "mul nsw %num #{lhs}, #{rhs}"
      when Compiler::Type::Primitive::Str
        $fn.write :new, "call %struct.builtin.str* @fn.builtin.repeat_str(%struct.builtin.str* #{lhs}, %num #{rhs})"
      when Compiler::Type::Primitive::List
        $fn.write :new, "call %struct.builtin.list* @fn.builtin.repeat_list(%struct.builtin.list* #{lhs}, %num #{rhs}, i64 #{@lhs.llvm_type.byte_length})"
      else 
        raise "type error: cannot add #{type}s."
      end
    end

    def compile_div(type)
      $fn.validate_types expected: Compiler::Type::Primitive::Num, given: type
      lhs = @lhs.compile type: Compiler::Type::Primitive::Num
      rhs = @rhs.compile type: Compiler::Type::Primitive::Num

      $fn.write :new, "sdiv %num #{lhs}, #{rhs}"
    end

    def compile_mod(type)
      $fn.validate_types expected: Compiler::Type::Primitive::Num, given: type
      lhs = @lhs.compile type: Compiler::Type::Primitive::Num
      rhs = @rhs.compile type: Compiler::Type::Primitive::Num

      $fn.write :new, "srem %num #{lhs}, #{rhs}"
    end

    def compile_cmp_op(type, math_op)
      $fn.validate_types given: type, expected: Compiler::Type::Primitive::Bool

      lhs = @lhs.compile type: @lhs.llvm_type 
      rhs = @rhs.compile type: @rhs.llvm_type 

      case @lhs.llvm_type
      when Compiler::Type::Primitive::Num then
        tmp = $fn.write :new, "icmp #{math_op} %num #{lhs}, #{rhs}"
        $fn.write :new, "zext i1 #{tmp} to %bool"
      when Compiler::Type::Primitive::Bool then
        tmp = $fn.write :new, "icmp #{math_op} %bool #{lhs}, #{rhs}"
        $fn.write :new, "zext i1 #{tmp} to %bool"
      when Compiler::Type::Primitive::Str then
        tmp = $fn.write :new, "call i32 @fn.builtin.compare_strs(%struct.builtin.str* #{lhs}, %struct.builtin.str* #{rhs})"
        tmp2 = $fn.write :new, "icmp #{math_op} i32 #{tmp}, 0"
        $fn.write :new, "zext i1 #{tmp2} to %bool"
      else
        raise "type error: cannot compare #{@lhs.llvm_type}s."
      end
    end

    def compile_and(type)
      Binary.new(
        @lhs,
        Binary.new(@rhs, Expression::Literal.new(:false), ?:),
        ??
      ).compile type: type
    end

    def compile_or(type)
      Binary.new(
        @lhs,
        Binary.new(Expression::Literal.new(:true), @rhs, ?:),
        ??
      ).compile type: type
    end

    def compile_ternary(type)
      res = $fn.write :new, "alloca #{type}, align #{type.align}"
      cond = @lhs.compile type: Compiler::Type::Primitive::Bool
      cmp = $fn.write :new, "icmp ne %bool #{cond}, 0"
      jmp1 = $fn.write_nop

      ift = $fn.declare_label
      lhs = @rhs.lhs.compile type: type

      $fn.write "store #{type} #{lhs}, #{type}* #{res}, align #{type.align}"
      jmp2 = $fn.write_nop

      iff= $fn.declare_label
      rhs = @rhs.rhs.compile type: type
      $fn.write "store #{type} #{rhs}, #{type}* #{res}, align #{type.align}"
      jmp3 = $fn.write_nop

      ending = $fn.declare_label
      jmp1.write "br i1 #{cmp}, label #{ift}, label #{iff}"
      jmp2.write "br label #{ending}"
      jmp3.write "br label #{ending}"

      $fn.write :new, "load #{type}, #{type}* #{res}"
    end
# =begin
#   %6 = icmp ne i32 %5, 0
#   br i1 %6, label %7, label %9

# =end

#       warn "Todo"
#       return @rhs.lhs.compile type: type
#       return
#       raise
#       p @lhs
#       p @rhs
#       exit 0
#       #       Statement::If.new(@lhs, Statements.new())
#       # class Statement
#       #   class If
#       #     def initialize(cond, body, else_)
#       #       @cond = cond
#       #       @body = body
#       #       @else_ = else_
#       #     end

#       #       $fn.validate_types given: type, expected: Compiler::Type::Primitive::Bool

#       #       lhs = @lhs.compile type: Compiler::Type::Primitive::Bool
#       #       cond = $fn.write :new, "icmp #{op} %bool #{lhs}, 0"
#       #       jmp_to_and = $fn.write_nop
#       #       rhs = @rhs.copmile type: Com

#       #       when '&&' then compile_and type
#       #       when '||' then compile_or type
#       #       when '?' then compile_ternary type
#     end

    def compile(type:)
      case @op
      when '+' then compile_add type
      when '-' then compile_sub type
      when '*' then compile_mul type
      when '/' then compile_div type
      when '%' then compile_mod type
      when '==' then compile_cmp_op type, 'eq'
      when '!=' then compile_cmp_op type, 'ne'
      when '<' then compile_cmp_op type, 'slt'
      when '<=' then compile_cmp_op type, 'sle'
      when '>' then compile_cmp_op type, 'sgt'
      when '>=' then compile_cmp_op type, 'sge'
      when '&&' then compile_and type
      when '||' then compile_or type
      when '?' then compile_ternary type
      else raise "unknown op '#@op'??"
      end
    end

    def llvm_type
      case @op
      when ?+, ?-, ?*, ?/, ?% then @lhs.llvm_type
      when ?? then @rhs.lhs.llvm_type
      when '==', '!=', ?!, ?<, ?>, '<=', '>=', '&&', '||' then Compiler::Type::Primitive::Bool
      else raise "unknown operator llvm type '#@op'"
      end
    end
  end
end
