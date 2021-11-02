require_relative '../expression'

class Statement
  class Let
    def initialize(name, type, value)
      @name = name
      @type = type
      @value = value
    end

    def self.parse(parser)
      parser.guard 'let' or return

      name = parser.identifier err: 'missing variable for `let` statement'
      type = TypeDecl.parse parser # can be nil for implicit type

      if parser.guard '='
        value = Expression.parse parser # can be nil for predeclaring values.
      end

      parser.endline err: 'missing endline for `let`'

      new name, type, value
    end

    def compile
      var = $fn.define_variable @name, @type.llvm_type

      $fn.write "#{var.local} = alloca #{var.llvm_type}, align #{var.llvm_type.align}"

      if @value
        val = @value.compile(type: @type.llvm_type)
      else
        val = @type.llvm_type.default
      end

      $fn.write "store #{var.llvm_type} #{val}, #{var.llvm_type}* #{var.local}, align 8"
      var
    end
  end
end
