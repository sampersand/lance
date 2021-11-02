require_relative '../expression'
require_relative '../../compiler/type'

class Statement
  class Return
    def initialize(expr)
      @expr = expr
    end

    def self.parse(parser)
      parser.guard 'return' or return
      expr = Expression.parse parser # can be nil
      parser.endline err: 'missing endline for `return`'

      new expr
    end

    def compile(fn, llvm)
      return_type = fn.return_type

      if @expr
        index = @expr.compile fn, llvm, type: return_type
        fn.write "ret #{return_type.llvm_type llvm} #{index}"
      elsif return_type != Compiler::Type::Primitive::Void
        raise "nothing returned, but return type for '#{fn.name}' is #{return_type.inspect}"
      end
    end
  end
end
