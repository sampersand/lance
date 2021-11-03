require_relative 'compiler/function'
require_relative 'compiler/llvm'

class Compiler
  attr_reader :llvm

  class PredeclaredExternFunction
    def initialize(name, args, return_type)
      @name = "@fn.builtin.#{name}"
      @return_type = return_type
      @args = args
    end

    def to_s
      @name
    end

    def llvm_type
      @llvm_type ||= Type::Function.new @args, @return_type
    end
  end

  PREDCLARED_EXTERNS = {
    'print' => PredeclaredExternFunction.new('print', [Type::Primitive::Str], Type::Primitive::Void),
    'itoa' => PredeclaredExternFunction.new('num_to_str', [Type::Primitive::Num], Type::Primitive::Str),
    'atoi' => PredeclaredExternFunction.new('str_to_num', [Type::Primitive::Str], Type::Primitive::Num),
    # 'atoi' => PredeclaredExternFunction.new('print', [Type::Primitive::Str], Type::Primitive::Void)
  }

  def initialize(**opts)
    @functions = {}
    @globals = {}
    @externs = {}
    @types = {}
    @llvm = LLVM.new(**opts)
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

  def declare_function(fn)
    raise "function '#{fn.name}' already declared" if @functions.key? fn.name
    @functions[fn.name] = fn
  end

  def lookup(name)
    case
    when (extern = @externs[name]) then extern
    when (func = @functions[name]) then func
    when (glob = @globals[name]) then global
    when (predecl = PREDCLARED_EXTERNS[name]) then predecl
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

  def to_llvm
    $compiler = self
    $llvm = @llvm

    @types.each do |_name, type|
      type.to_s
    end

    @globals.each do |name, type|
      @llvm.declare_global name, type
    end

    @externs.each do |name, type|
      @llvm.declare_extern name, type
    end

    @functions.each do |_name, fn|
      fn.compile
    end

    @llvm.final_string
  end
end








