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

      parser.expect '=', err: 'missing `=` in `let` statement'
      value = Expression.parse parser # can be nil for predeclaring values.
      parser.endline err: 'missing endline for `let`'

      new name, type, value
    end

    def compile(fn, llvm)
      var = fn.define_variable @name, @type

      if @value
        fn.write @value.compile(fn, llvm, type: var.llvm_type(llvm)), local: var.local
      else
        # todo, remove align 8 for booleans
        fn.write var, "#{var.llvm_type(llvm).to_llvm_s(llvm)} #{var.llvm_type(llvm).default(llvm)}, align 8"
      # "#{name} = global #{type.to_llvm_s self} #{type.default self}, align 8"
        # do we want to have an initial value?
      end
    end
  end
end
