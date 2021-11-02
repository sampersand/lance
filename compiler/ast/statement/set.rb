require_relative '../expression'

class Statement
  class Set
    def initialize(prelude, value)
      @prelude = prelude
      @value = value
    end

    def self.parse(parser)
      parser.guard 'set' or return
      prelude = Expression::Primary.parse(parser) or parser.error 'missing value to `set` to.'
      # todo: make sure `prelude` is the correct types

      # note: no type, because type should already be known.
      parser.expect '=', err: 'expecting `=` in `set` statement'
      value = Expression.parse(parser) or parser.error 'missing rhs of `set` statement'
      parser.endline err: 'missing endline for `set`'

      new prelude, value
    end

    def compile
      # todo: set for non-variables
      var = $fn.lookup(@prelude.instance_variable_get(:@value).to_s)
      rhs = @value.compile type: var.llvm_type
      $fn.write "store #{var.llvm_type} #{rhs}, #{var.llvm_type}* #{var.local}, align 8"
    end
  end
end
