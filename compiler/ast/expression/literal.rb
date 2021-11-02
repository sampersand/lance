class Expression
  class Literal
    def initialize(value)
      @value = value
    end

    def self.parse(parser)
      parser.guard 'true' and return new :true
      parser.guard 'false' and return new :false
      parser.guard 'null' and return new :null

      num = parser.guard(:number) and return new num
      str = parser.guard(:string) and return new str
      ident = parser.guard(:identifier) and return new ident.to_sym

      parser.surround '[', ']' do
        first = Expression.parse(parser) or next []
        new [first] + parser.repeat { parser.guard ',' and Expression.parse(parser) }
      end
    end

    def compile_literal(fn, value, type, align)
      local = fn.write :new, "alloca #{type}, align #{align}"
      fn.write "store #{type} #{value}, #{type}* #{local}, align #{align}"
      fn.write :new, "load #{type}, #{type}* #{local}, align #{align}"
    end

    def compile(fn, llvm, type:)
      case
      when (type == Compiler::Type::Primitive::Bool || type == :any) && (@value == :true || @value == :false)
        compile_literal fn, (@value == :true ? 1 : 0), '%bool', 1
      when (type == Compiler::Type::Primitive::Num || type == :any) && @value.is_a?(Number)
        compile_literal fn, @value, '%num', 8
      when (type == Compiler::Type::Primitive::Str || type == :any) && @value.is_a?(String)
        name = llvm.string_literal @value
        
# @s = global %struct.stringy { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i64 3 }, align 8

      else
        p type
      # case @value
      fail
      end
      # when 
    end
  end
end
