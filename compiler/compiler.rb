require_relative 'compiler/function'
require 'set'
class Compiler
  def initialize
    @functions = Hash.new {|h,k| h[k] = Function.new k}
    @globals = {}
    @externs = {}
    @types = {}
  end

  def function(name)
    @functions[name]
  end

  def declare_global(name, type)
    if (global = @globals[name])
      if global == type
        warn "global '#{name}' is already declared"
      else
        raise "global '#{name}' already declared with type '#{global.inspect}'"
      end

      global
    else
      @globals[name] = type
    end
  end

  def declare_extern(name, type)
    if (extern = @externs[name])
      if extern != type
        raise "extern '#{name}' already declared with type '#{extern.inspect}'"
      end

      extern
    else
      @externs[name] = type
    end
  end

  def declare_type(type)
    if (old = @types[type.name])
      if type == old
        warn "warning: type '#{type.name}' declared twice"
      else
        raise "type '#{type.name} is already declared: #{old.inspect}"
      end
    else
      @types[type.name] = type
    end
  end

  def lookup_type(name)
    Type::Primitive.lookup(name) || @types[name] or raise "unknown type name #{name.inspect}"
  end
end


return unless $0 == __FILE__
require_relative 'parser'

ps = Parser.new Lexer.new <<~EOS
struct person {
  name: str,
  age: num
}
struct person{name: str, age: num}
global me: person;
global me: person;
extern you: person;
extern you: person;
extern them: fn([person]): fn(person): bool;


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
