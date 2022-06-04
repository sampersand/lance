require_relative '../expression'

class Statement
  class While
    def initialize(cond, body)
      @cond = cond
      @body = body
    end

    def self.parse(parser)
      if parser.guard 'loop'
        cond = Expression::Literal.new :true # `loop { ... }` is literally just `while true { ... }`
      elsif parser.guard 'while'
        cond = Expression.parse(parser) or parser.error 'missing condition for `while`'
      else
        return
      end

      body = Statements.parse(parser) or parser.error 'missing body for `while`'

      new cond, body
    end

    def compile
      jmp = $fn.write_nop
      top = $fn.declare_label
      jmp.write "br label #{top}"
      $fn.whiles.push [top, []]

      cond1 = @cond.compile type: Compiler::Type::Primitive::Bool
      cond2 = $fn.write :new, "icmp ne %bool #{cond1}, 0"
      jmp_statement = $fn.write_nop

      top_of_body = $fn.declare_label
      if @body.compile
        $fn.write "br label #{top}"
      end

      bottom = $fn.declare_label

      jmp_statement.write "br i1 #{cond2}, label #{top_of_body}, label #{bottom}"

      $fn.whiles.pop.last.each do |whilst|
        whilst.write "br label #{bottom}"
      end
    end
  end
end
