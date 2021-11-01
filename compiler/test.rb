require_relative 'parser'
require_relative 'compiler'

ps = Parser.new Lexer.new <<~EOS
/*struct person {
  name: str,
  age: num
}
struct person{name: str, age: num}
global me: person;
global me: person;
extern you: person;
extern you: person;
extern them: fn([person]): fn(person): bool;*/

fn foo(a: num): num {
  /*let x: num = a;*/
  return;
}

EOS

compiler = Compiler.new

ps.parse_program.each do |decl|
  decl.compile compiler
end

pp compiler
__END__


c.declare_type Compiler::Type::Struct.new 'bar', []
fn = Compiler::Function.new 'foo', [
  ['foo', c.lookup_type('num')],
  ['foo1', c.lookup_type('bar')]
], nil, globals: {}
pp fn

__END__
