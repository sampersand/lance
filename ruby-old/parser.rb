require_relative 'ast'

class Object
  def then
    yield self
  end
end

class Parser
  def initialize(tokenizer)
    @tokenizer = tokenizer
  end

  def peek
    @peeked ||= @tokenizer.next
  end

  def take
    peek.tap { @peeked = nil }
  end

  def parse_error(msg='Parser Error occurred')
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

  def expect(korv, msg=nil)
    guard korv or parse_error(msg || "expected: #{korv}, got: #{peek}")
  end

  def surround(lhs, rhs)
    guard(lhs)&.then { yield.tap { expect rhs } }
  end

  def repeat
    x = []
    while t = yield
      x << t
    end
    x
  end


  # program := { <declaration> }
  def program
    repeat { declaration }
  end

  # declaration := <global> | <import> | <function>
  def declaration
    global || import || function
  end

  def identifier
    expect :identifier
  end

  # 'global' <identifier> ';'
  def global
    surround 'global', ';' do
      Ast::Global.new identifier
    end
  end

  # 'import' <string> ';'
  def import
    surround 'import', ';' do
      Ast::Import.new expect :string
    end
  end

  def function
    guard 'function' or return
    name = identifier
    args =
      surround '(', ')' do
        first = guard(:identifier) or next []
        [first] + repeat { guard ',' and identifier }
      end

    body = brace_statements or parse_error 'missing function body'

    Ast::Function.new name, args, body
  end

  def brace_statements
    surround '{', '}' do
      repeat { statement }
    end
  end

  def statement
    self.if || self.while || self.return || self.do || assignment
  end

  def paren_expression
    surround('(', ')') { expression }
  end

  def if
    guard 'if' or return
    cond = paren_expression or parse_error 'missing if condition'
    body = brace_statements or parse_error 'missing if body'
    else_ =
      if guard 'else'
        if peek[1] == 'if'
          [self.if]
        else
          brace_statements or parse_error 'missing else body'
        end
      end || []

    Ast::If.new cond, body, else_
  end

  def while
    guard 'while' or return
    cond = paren_expression or parse_error 'missing while condition'
    body = brace_statements or parse_error 'missing while body'
    Ast::While.new cond, body
  end

  def do
    surround 'do', ';' do
      expr = expression or parse_error 'missing do body'
      Ast::Do.new expr
    end
  end

  def return
    surround 'return', ';' do
      Ast::Return.new expression
    end
  end

  def assignment
    set = (guard('let', 'set') || return) == 'set'

    name = identifier

    indices = if set
      repeat { surround('[', ']') { expression or parse_error 'missing array index' } }
    end

    expect '='
    value = expression or parse_error 'missing rhs of assignment'
    expect ';'

    if set
      Ast::Set.new name, indices, value
    else
      Ast::Let.new name, value
    end
  end

  def expression
    lhs = primary

    op = guard(*%w(+ - * / % < > <= >= != == & |)) or return lhs
    rhs = expression or parse_error "missing rhs of '#{op}' operator"
    Ast::BinaryOperator.new lhs, op, rhs
  end

  def primary
    prim = literal || paren_expression || unary or return

    loop do
      if guard '('
        if (first = expression)
          args = [first] + repeat { guard ',' and expression }
        else
          args = []
        end
        expect ')'

        prim = Ast::FunctionCall.new prim, args
      elsif guard '['
        index = expression or parse_error 'missing expr for index'
        expect ']'
        prim = Ast::ArrayIndex.new prim, index
      else
        return prim
      end
    end
  end

  def unary
    op = guard('-', '!') or return
    value = expression or parse_error "missing rhs of unary '#{op}' operator"
    Ast::Unary.new (op == ?! ? op : :-@), value
  end

  def literal
    guard 'true' and return Ast::Literal.new :true
    guard 'false' and return Ast::Literal.new :false
    guard 'null' and return Ast::Literal.new :null
    num = guard(:number) and return Ast::Literal.new num
    str = guard(:string) and return Ast::Literal.new str
    ident = guard(:identifier) and return Ast::Literal.new ident.to_sym

    surround '[', ']' do
      first = expression or next []
      Ast::Literal.new [first] + repeat { guard ',' and expression }
    end
  end
end
