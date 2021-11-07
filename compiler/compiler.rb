require_relative 'compiler/function'
require_relative 'compiler/llvm'

class Compiler
  attr_reader :llvm

  class PredeclaredExternFunction
    attr_reader :name, :args, :return_type
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
    'itos' => PredeclaredExternFunction.new('num_to_str', [Type::Primitive::Num], Type::Primitive::Str),
    'stoi' => PredeclaredExternFunction.new('str_to_num', [Type::Primitive::Str], Type::Primitive::Num),
    'stoa' => PredeclaredExternFunction.new('str_to_ascii', [Type::Primitive::Str], Type::Primitive::Num),
    'atos' => PredeclaredExternFunction.new('str_to_ascii', [Type::Primitive::Num], Type::Primitive::Str),
    'substr' => PredeclaredExternFunction.new('substr', [Type::Primitive::Str, Type::Primitive::Num, Type::Primitive::Num], Type::Primitive::Str),
    'quit' => PredeclaredExternFunction.new('quit', [Type::Primitive::Num], Type::Primitive::Void),
    'insert' => PredeclaredExternFunction.new('insert', [Type::List, :any, Type::Primitive::Num], Type::Primitive::Bool),
    'delete' => PredeclaredExternFunction.new('delete', [Type::List, Type::Primitive::Num], Type::Primitive::Bool),
    'length' => PredeclaredExternFunction.new('length', [:any], Type::Primitive::Num),
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

  class Global
    def initialize(name, type, is_extern, is_private=false)
      @name = name
      @type = type
      @is_extern = is_extern
      @is_private = is_private
    end

    def to_s
      @type.to_s
    end

    def name
      "@globals.#@name"
    end

    def llvm_type
      @type.llvm_type
    end

    def private?
      @is_private
    end

    def local
      $fn.write :new, "load #@type, #@type* #{name}, align #{@type.align}"
  # %4 = load %struct.builtin.str*, %struct.builtin.str** @globals.stream, align 8
  # %5 = getelementptr inbounds %struct.builtin.str, %struct.builtin.str* %4, i64 0, i32 0

      # else
        # "@globals.#@name"
      # end
      # @local ||= begin
      # end
###  #     # if @is_extern
###  #       pos = $fn.write :new, "alloca #@type, align #{@type.align} ;"
###  #       $fn.write :new, "load #@type, #@type* @globals.#@name, align #{@type.align}"
###  # # %4 = load %struct.builtin.str*, %struct.builtin.str** @globals.stream, align 8
###  # # %5 = getelementptr inbounds %struct.builtin.str, %struct.builtin.str* %4, i64 0, i32 0
###
###  #     # else
###  #       # "@globals.#@name"
###  #     # end
###  #     # @local ||= begin
###  #     # end
    end

    def default
      @type.default
    end
  end

  def declare_global(name, type, is_private)
    if (global = @globals[name])
      if global == type
        warn "global '#{name}' is already declared"
      else
        raise "global '#{name}' already declared with type '#{global.inspect}'"
      end

      global
    else
      @globals[name] = Global.new name, type, false, is_private
    end
  end

  def declare_function(fn)
    raise "function '#{fn.name}' already declared" if @functions.key? fn.name
    @functions[fn.name] = fn
  end

  def lookup(name)
    case
    when (extern = @externs[name]) then extern[0]
    when (func = @functions[name]) then func
    when (global = @globals[name]) then global
    when (predecl = PREDCLARED_EXTERNS[name]) then predecl
    end
  end

  def declare_extern(name, type, externf)
    if (extern = @externs[name])
      if extern != type
        raise "extern '#{name}' already declared with type '#{extern.inspect}'"
      end

      extern
    else
      if externf
        type = PredeclaredExternFunction.new "fn.user.#{name}", type.args, type.return_type
      else
        type = Global.new name, type, true
      end

      @externs[name] = [type, externf]
    end
  end

  def declare_type(type)
    if (old = @types[type.name])
      if type == old
        warn "warning: type '#{type.name}' declared twice"
      else
        raise "type '#{type.name}' is already declared: #{old.inspect}"
      end
    else
      @types[type.name.to_s] = type
    end
  end

  def lookup_type(name, error: true)
    Type::Primitive.lookup(name) || @types[name.to_s] or (error && raise("unknown type name #{name.inspect}"))
  end

  def to_llvm(is_main:)
    $compiler = self
    $llvm = @llvm

    @types.each do |_name, type|
      type.to_s
    end

    @globals.each do |name, type|
      @llvm.declare_global name, type
    end

    @externs.each do |name, (type, externf)|
      @llvm.declare_extern name, type, externf
    end

    @functions.each do |_name, fn|
      fn.compile
    end

    @llvm.final_string is_main: is_main
  end
end
