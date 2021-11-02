require_relative 'parser'
require_relative 'compiler'

ps = Parser.new Lexer.new <<~EOS
fn main(argv: [str]): num {
  let x: num = 3;
  /*do [1-4, 2, 3]; /* blank statement */
  /*do [true, false, true, true];*/
  return 4;
}
EOS
=begin
extern anum: num;
struct Person { name: str, age: num }
global sam: Person;
global somethin: any;
global func: fn([Person]): fn(str, num, [any]);

struct people {
  list: [[Person]],
  other: any
}

fn lol(p: Person, o: people, n: num): str {
  return "foo";
}
/*
fn yup(): [[str]] {
  return [[],[]];
}*/
=end

# /*struct person {
#   name: str,
#   age: num
# }
# struct person{name: str, age: num}
# global me: person;
# global me: person;
# extern you: person;
# extern you: person;
# extern them: fn([person]): fn(person): bool;*/

# struct person {
#   name: [[str]],
#   age: [num]
# }

# fn foo(a: num): void {
#   /*let x: num = a;*/
#   return;
# }


compiler = Compiler.new target_triple: 'arm64-apple-macosx12.0.0'

ps.parse_program.each do |decl|
  decl.compile compiler
end

puts compiler.to_llvm
__END__


c.declare_type Compiler::Type::Struct.new 'bar', []
fn = Compiler::Function.new 'foo', [
  ['foo', c.lookup_type('num')],
  ['foo1', c.lookup_type('bar')]
], nil, globals: {}
# pp fn

__END__
