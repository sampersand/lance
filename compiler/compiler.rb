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

    def ==(rhs)
      llvm_type == rhs.llvm_type
    end
  end

  PREDCLARED_EXTERNS = {
    'print' => PredeclaredExternFunction.new('print', [Type::Primitive::Str], Type::Primitive::Void),
    # 'str.member.print' => PredeclaredExternFunction.new('print', [Type::Primitive::Str], Type::Primitive::Void),
    'random' => PredeclaredExternFunction.new('random_', [], Type::Primitive::Num),
    'prompt' => PredeclaredExternFunction.new('prompt', [], Type::Primitive::Str),
    'num.member.to_str' => PredeclaredExternFunction.new('num_to_str', [Type::Primitive::Num], Type::Primitive::Str),
    'str.member.to_num' => PredeclaredExternFunction.new('str_to_num', [Type::Primitive::Str], Type::Primitive::Num),
    'str.member.to_ascii' => PredeclaredExternFunction.new('str_to_ascii', [Type::Primitive::Str], Type::Primitive::Num),
    'num.member.to_ascii' => PredeclaredExternFunction.new('ascii_to_str', [Type::Primitive::Num], Type::Primitive::Str),
    'str.member.substr' => PredeclaredExternFunction.new('substr', [Type::Primitive::Str, Type::Primitive::Num, Type::Primitive::Num], Type::Primitive::Str),
    'quit' => PredeclaredExternFunction.new('quit', [Type::Primitive::Num], Type::Never),
    'abort' => PredeclaredExternFunction.new('abort_msg', [Type::Primitive::Str], Type::Never),
    'list.member.insert' => PredeclaredExternFunction.new('insert', [Type::List, Type::Primitive::Num, :any], Type::Primitive::Bool),
    'list.member.delete' => PredeclaredExternFunction.new('delete', [Type::List, Type::Primitive::Num], Type::Primitive::Bool),
    'str.member.length' => PredeclaredExternFunction.new('length', [:any], Type::Primitive::Num),
    'list.member.length' => PredeclaredExternFunction.new('length', [:any], Type::Primitive::Num),
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
    @externs.delete fn.name
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
      if extern != [type, externf]
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

  def alias_type(newname, type)
    @types[newname.to_s] = type
  end

  def declare_type(type)
    if (old = @types[type.name])
      if old.is_a?(Compiler::Type::Struct) && old.fields.nil?
        old.fields = type.fields
      elsif old.is_a?(Compiler::Type::Enum) && !old.variants?
        old.variants = type.variants_
      elsif type == old
        warn "warning: type '#{type.name}' declared twice" unless type.equal? old
      elsif !(old.is_a?(Compiler::Type::Enum) && !type.variants?) && !(
        old.is_a?(Compiler::Type::Struct) && type.fields.nil?)
        raise "type '#{type.name}' is already declared: #{old.inspect}"
      end
    else
      @types[type.name.to_s] = type
    end

    true
  end

  def lookup_type(name, error: true)
    return Type::Never if name == 'never'
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
