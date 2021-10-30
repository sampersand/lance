# require_relative 'ast'
require_relative 'lexer'

class Parser
  def initialize(lexer)
    @lexer = lexer
  end

  def peek
    @peeked ||= @lexer.next
  end

  def take
    peek.tap { @peeked = nil }
  end

  def eof?
    peek.nil?
  end

  def error(msg='Parser Error occurred')
    raise msg
  end

  def guard(*korvs)
    k, v = peek

    korvs.each do |korv|
      if korv.is_a?(Symbol) && k == korv || k == :symbol && v == korv
        return take.last
      end
    end

    nil
  end

  def expect(korv, err: nil)
    guard korv or error(err || "expected: #{korv}, got: #{peek}")
  end

  def surround(lhs, rhs)
    guard(lhs)&.then { yield.tap { expect rhs } }
  end

  def delineated(delim:, end:)
    end_ = binding.local_variable_get(:end)
    all = []

    until guard end_
      error "missing closing `#{end_}`" if eof?
      all.push yield
      next if guard delim
      # if we don't have the delim, we must have the end_
      expect end_, err: "missing #{end_.inspect} in delineated list"
      break
    end

    all
  end

  def repeat
    x = []
    while t = yield
      x << t
    end
    x
  end

  def endline(err: nil)
    expect ';', err: err
  end

  def identifier(err: nil)
    expect :identifier, err: err
  end
end
ps = Parser.new Lexer.new <<-EOS
struct a {
  f: str,
  b: [any],
  c: fn([fn([fn():str]): [str]])
}
EOS
require_relative 'ast/struct'
pp Ast::Struct.parse ps rescue (puts "#$!"; exit)
pp ps.peek
__END__
  # # program := { <declaration> }
  # def program
  #   repeat { declaration }
  # end

  # # declaration := <global> | <import> | <function> | <struct>
  # def declaration
  #   global || import || function
  # end

  # # 'global' <identifier> ';'
  # def global
  #   guard 'global' or return
  #   name = expect :identifier
  #   kind = type or error
  #   surround 'global', ';' do
  #     Ast::Global.new identifier
  #   end
  # end

  # alias error error

  # def type
  #   guard ':' or return
  # end

  # # 'import' <string> ';'
  # def import
  #   surround 'import', ';' do
  #     Ast::Import.new expect :string
  #   end
  # end

  # def function
  #   guard 'function' or return
  #   name = identifier
  #   args =
  #     surround '(', ')' do
  #       first = guard(:identifier) or next []
  #       [first] + repeat { guard ',' and identifier }
  #     end

  #   body = brace_statements or error 'missing function body'

  #   Ast::Function.new name, args, body
  # end

  # def brace_statements
  #   surround '{', '}' do
  #     repeat { statement }
  #   end
  # end

  # def statement
  #   self.if || self.while || self.return || self.do || assignment
  # end

  # def paren_expression
  #   surround('(', ')') { expression }
  # end

  # def if
  #   guard 'if' or return
  #   cond = paren_expression or error 'missing if condition'
  #   body = brace_statements or error 'missing if body'
  #   else_ =
  #     if guard 'else'
  #       if peek[1] == 'if'
  #         [self.if]
  #       else
  #         brace_statements or error 'missing else body'
  #       end
  #     end || []

  #   Ast::If.new cond, body, else_
  # end

  # def while
  #   guard 'while' or return
  #   cond = paren_expression or error 'missing while condition'
  #   body = brace_statements or error 'missing while body'
  #   Ast::While.new cond, body
  # end

  # def do
  #   surround 'do', ';' do
  #     expr = expression or error 'missing do body'
  #     Ast::Do.new expr
  #   end
  # end

  # def return
  #   surround 'return', ';' do
  #     Ast::Return.new expression
  #   end
  # end

  # def assignment
  #   set = (guard('let', 'set') || return) == 'set'

  #   name = identifier

  #   indices = if set
  #     repeat { surround('[', ']') { expression or error 'missing array index' } }
  #   end

  #   expect '='
  #   value = expression or error 'missing rhs of assignment'
  #   expect ';'

  #   if set
  #     Ast::Set.new name, indices, value
  #   else
  #     Ast::Let.new name, value
  #   end
  # end

  # def expression
  #   lhs = primary

  #   op = guard(*%w(+ - * / % < > <= >= != == & |)) or return lhs
  #   rhs = expression or error "missing rhs of '#{op}' operator"
  #   Ast::BinaryOperator.new lhs, op, rhs
  # end

  # def primary
  #   prim = literal || paren_expression || unary or return

  #   loop do
  #     if guard '('
  #       if (first = expression)
  #         args = [first] + repeat { guard ',' and expression }
  #       else
  #         args = []
  #       end
  #       expect ')'

  #       prim = Ast::FunctionCall.new prim, args
  #     elsif guard '['
  #       index = expression or error 'missing expr for index'
  #       expect ']'
  #       prim = Ast::ArrayIndex.new prim, index
  #     else
  #       return prim
  #     end
  #   end
  # end

  # def unary
  #   op = guard('-', '!') or return
  #   value = expression or error "missing rhs of unary '#{op}' operator"
  #   Ast::Unary.new (op == ?! ? op : :-@), value
  # end

  # def literal
  #   guard 'true' and return Ast::Literal.new :true
  #   guard 'false' and return Ast::Literal.new :false
  #   guard 'null' and return Ast::Literal.new :null
  #   num = guard(:number) and return Ast::Literal.new num
  #   str = guard(:string) and return Ast::Literal.new str
  #   ident = guard(:identifier) and return Ast::Literal.new ident.to_sym

  #   surround '[', ']' do
  #     first = expression or next []
  #     Ast::Literal.new [first] + repeat { guard ',' and expression }
  #   end
  # end
end
