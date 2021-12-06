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
      # note: no type, because type should already be known.

      parser.expect '=', err: 'expecting `=` in `set` statement'
      value = Expression.parse(parser) or parser.error 'missing rhs of `set` statement'
      parser.endline err: 'missing endline for `set`'

      new prelude, value
    end

    def compile
      case @prelude
      when Expression::Primary::FieldAccess
        primary = @prelude.primary.compile type: :any
        value = @value.compile type: @prelude.llvm_type

        offset = @prelude.struct_type.fields.each_with_index.find { |(k, v), _idx| k == @prelude.field }.last

        idx = $fn.write :new, "getelementptr inbounds #{@prelude.struct_type.to_s.chop}, #{@prelude.struct_type} #{primary}, i32 0, i32 #{offset}"
        $fn.write "store #{@prelude.llvm_type} #{value}, #{@prelude.llvm_type}* #{idx}, align 8"

      when Expression::Primary::ArrayIndex
        ary = @prelude.ary.compile type: :any

        if @prelude.ary.llvm_type.is_a? Compiler::Type::Dict
          key = @prelude.index.compile type: (keyty = @prelude.ary.llvm_type.key)
          val = @value.compile type: (valty = @prelude.ary.llvm_type.val)

          key1 = $fn.write :new, "alloca #{keyty}, align 8"
          val1 = $fn.write :new, "alloca #{valty}, align 8"
          $fn.write "store #{keyty} #{key}, #{keyty}* #{key1}, align 8"
          $fn.write "store #{valty} #{val}, #{valty}* #{val1}, align 8"
          key_ptr = $fn.write :new, "bitcast #{keyty}* #{key1} to i8*"
          value_ptr = $fn.write :new, "bitcast #{valty}* #{val1} to i8*"

          $fn.write "call void @fn.builtin.insert_into_dict(%struct.builtin.dict* #{ary}, i8* #{key_ptr}, i8* #{value_ptr})"
        else
          idx = @prelude.index.compile type: Compiler::Type::Primitive::Num
          value = @value.compile type: (inner_type = @prelude.ary.llvm_type.inner)


          tmp1 = $fn.write :new, "bitcast %struct.builtin.list* #{ary} to #{inner_type}**"
          tmp2 = $fn.write :new, "load #{inner_type}*, #{inner_type}** #{tmp1}, align 8"
          tmp3 = $fn.write :new, "getelementptr inbounds #{inner_type}, #{inner_type}* #{tmp2}, %num #{idx}"
          $fn.write "store #{inner_type} #{value}, #{inner_type}* #{tmp3}, align 8"
        end

      when Expression::Literal
        var = $fn.lookup @prelude.value.to_s
        rhs = @value.compile type: var.llvm_type

        if var.is_a? Compiler::Global
          into = var.name
        else
          into = var.local
        end
        $fn.write "store #{var.llvm_type} #{rhs}, #{var.llvm_type}* #{into}, align 8"
      else
        raise "cannot assign to #{@prelude.inspect}s"
      end
    end
  end
end



