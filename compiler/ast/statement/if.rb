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
      body = Statements.parse(parser) or parser.error 'missing body for `if`'

      if parser.guard 'else'
        if parser.peek? 'if'
          else_ = parse(parser) or parser.error 'invalid if for `else if`'
        else
          else_ = Statements.parse(parser) or parser.error 'missing body for `else`'
        end
      end

      new cond, body, else_
    end

    def compile
      cond1 = @cond.compile type: Compiler::Type::Primitive::Bool
      cond2 = $fn.write :new, "icmp ne %bool #{cond1}, 0"
      jmp_to_else = $fn.write_nop

      body_lbl = $fn.declare_label
      @body.compile
      jmp_to_end = $fn.write_nop

      if @else_
        else_lbl = $fn.declare_label
        @else_.compile
        jmp_to_end2 = $fn.write_nop
      end

      end_lbl = $fn.declare_label

      if @else_
        jmp_to_else.write "br i1 #{cond2}, label #{body_lbl}, label #{else_lbl}"
      else
        jmp_to_else.write "br i1 #{cond2}, label #{body_lbl}, label #{end_lbl}"
      end

      jmp_to_end.write "br label #{end_lbl}"
      jmp_to_end2&.write "br label #{end_lbl}" # can be nil if no else is present
    end
  end
end
