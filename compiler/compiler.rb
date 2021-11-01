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

  def lookup_global(name)
    raise "todo: lookup global (and just usingthen in general idk)"
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
