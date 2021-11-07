require_relative 'literal'
require_relative 'unary'

class Expression
  class Primary
    class FunctionCall
      def initialize(fn, args)
        @fn = fn
        @args = args
      end

      def self.parse(primary, parser)
        parser.guard '(' or return

        args = parser.delineated(delim: ',', end: ')'){ Expression.parse parser }

        if primary.is_a?(Expression::Primary::FieldAccess)
          name = primary.primary.llvm_type.name.to_s + '.member.' + primary.field.to_s
          args.prepend primary.primary
          primary = Expression::Literal.new name.to_sym
        end

        new primary, args
      end

      def compile(type:)
        if @fn.is_a?(Expression::Literal) && %i(delete insert length unreachable).include?(@fn.value)
          return compile_special type
        end

        fn_llvm = @fn.llvm_type

        if fn_llvm.return_type != type && type != :any
          raise "return type mismatch (expected #{fn_llvm.return_type.inspect}, got #{type.inspect})"
        else
          fn_llvm.args.zip(@args) do |type, arg|
            $fn.validate_types expected: type, given: arg.llvm_type
          end
        end

        fn = @fn.compile type: @fn.llvm_type
        args = @args.map { |a| "#{a.llvm_type} #{a.compile(type: a.llvm_type)}" } # we already verified it with `fn`
        return_type = @fn.llvm_type.return_type

        $fn.write( (return_type == Compiler::Type::Primitive::Void ? nil : :new), "call #{return_type} #{fn}(#{args.join ', '})")
      end

      def llvm_type
        @llvm_type ||= @fn.llvm_type.return_type || Compiler::Type::Primitive::Void
      end

      private def compile_special(type)
        case @fn.value
        when :insert
          raise "invalid argc for insert: needed 3, got #{@args.length}" unless @args.length == 3

          list_type = @args[0].llvm_type

          if !list_type.is_a?(Compiler::Type::List)
            raise "can only insert into lists, not #{list_type.inspect}"
          end

          list = @args[0].compile type: list_type
          value = @args[1].compile type: list_type.inner
          index = @args[2].compile type: Compiler::Type::Primitive::Num

          ele_ptr = $fn.write :new, "alloca #{list_type.inner}, align #{list_type.inner.align}"
          $fn.write "store #{list_type.inner} #{value}, #{list_type.inner}* #{ele_ptr}, align #{list_type.inner.align}"

          void_ptr = $fn.write :new, "bitcast #{list_type.inner}* #{ele_ptr} to i8*"
          $fn.write :new, "call zeroext %bool @fn.builtin.insert_into_list(%struct.builtin.list* #{list}, i8* #{void_ptr}, i64 #{index}, i64 #{list_type.inner.byte_length})"
        when :delete
          raise "invalid argc for delete: needed 2, got #{@args.length}" unless @args.length == 2

          list_type = @args[0].llvm_type
          if !list_type.is_a?(Compiler::Type::List)
            raise "can only insert into lists, not #{list_type.inspect}"
          end

          list = @args[0].compile type: list_type
          index = @args[1].compile type: Compiler::Type::Primitive::Num

          ele_ptr = $fn.write :new, "alloca #{list_type.inner}, align #{list_type.inner.align}"
          void_ptr = $fn.write :new, "bitcast #{list_type.inner}* #{ele_ptr} to i8*"
          $fn.write :new, "call zeroext %bool @fn.builtin.delete_from_list(%struct.builtin.list* #{list}, i8* #{void_ptr}, i64 #{index}, i64 #{list_type.inner.byte_length})"
        when :length
          raise "invalid argc for length: needed 1, got #{@args.length}" unless @args.length == 1

          ty = @args[0].llvm_type

          if ty != Compiler::Type::Primitive::Str && !ty.is_a?(Compiler::Type::List)
            raise "invalid type for length, given #{ty}, expected string or list"
          end

          val = @args[0].compile type: :any

          tmp = $fn.write :new, "getelementptr inbounds #{ty.to_s.chop}, #{ty} #{val}, i64 0, i32 1"
          $fn.write :new, "load i64, i64* #{tmp}, align 8"
        when :unreachable then $fn.write 'unreachable'
        else
          raise "unknown special function '#{@fn.value}'"
        end
      end
    end

    class ArrayIndex
      attr_reader :ary, :index
      def initialize(ary, index)
        @ary = ary
        @index = index
      end

      def self.parse(primary, parser)
        parser.guard '[' or return
        index = Expression.parse(parser) or parser.error 'expecting index for array access'
        parser.expect ']', err: 'expecting `]` to close array indexing'
        new primary, index
      end

      def compile(type:)
        if @ary.llvm_type == Compiler::Type::Primitive::Str
          return compile_string type
        end

        inner_type = @ary.llvm_type.inner 
        $fn.validate_types expected: type, given: inner_type

        ary = @ary.compile type: :any
        idx = @index.compile type: Compiler::Type::Primitive::Num

        tmp1 = $fn.write :new, "bitcast %struct.builtin.list* #{ary} to #{inner_type}**"
        tmp2 = $fn.write :new, "load #{inner_type}*, #{inner_type}** #{tmp1}, align 8"
        tmp3 = $fn.write :new, "getelementptr inbounds #{inner_type}, #{inner_type}* #{tmp2}, %num #{idx}"
        $fn.write :new, "load #{inner_type}, #{inner_type}* #{tmp3}, align 8"
      end

      def compile_string(type)
        $fn.validate_types expected: type, given: Compiler::Type::Primitive::Str

        src = @ary.compile type: Compiler::Type::Primitive::Str
        idx = @index.compile type: Compiler::Type::Primitive::Num

        tmp3 = $fn.write :new, "call %struct.builtin.str* @fn.builtin.allocate_str(i64 1)"
        tmp4 = $fn.write :new, "getelementptr inbounds %struct.builtin.str, %struct.builtin.str* #{src}, i64 0, i32 0"
        tmp5 = $fn.write :new, "load i8*, i8** #{tmp4}, align 8"
        tmp6 = $fn.write :new, "getelementptr inbounds i8, i8* #{tmp5}, i64 #{idx}"
        tmp7 = $fn.write :new, "load i8, i8* #{tmp6}, align 1"
        tmp8 = $fn.write :new, "getelementptr inbounds %struct.builtin.str, %struct.builtin.str* #{tmp3}, i64 0, i32 0"
        tmp9 = $fn.write :new, "load i8*, i8** #{tmp8}, align 8"
        tmp10 = $fn.write :new, "getelementptr inbounds i8, i8* #{tmp9}, i64 0"
        $fn.write "store i8 #{tmp7}, i8* #{tmp10}, align 1"
        tmp3
      end


      def llvm_type
       @llvm_type ||= (@ary.llvm_type == Compiler::Type::Primitive::Str ? Compiler::Type::Primitive::Str : @ary.llvm_type.inner)
      end
    end

    class FieldAccess
      attr_reader :primary, :field
      def initialize(primary, field)
        @primary = primary
        @field = field
      end

      def self.parse(primary, parser)
        parser.guard '.' or return
        field = parser.guard(:identifier) or parser.error 'expected identifier after `.`'
        if primary.is_a?(Expression::Literal) && (type= $compiler.lookup_type(primary.value.to_s, error: false))
          Expression::Literal.new :"#{primary.value}.member.#{field}"
        else
          new primary, field
        end
      end

      def llvm_type
        @llvm_type ||= struct_type.fields[@field.to_s]
      end

      def struct_type
        @struct_type ||= @primary.llvm_type
      end

      def compile type:
        $fn.validate_types expected: type, given: llvm_type
        primary = @primary.compile type: struct_type
        offset = struct_type.fields.each_with_index.find { |(k, v), _idx| k == @field }.last

        idx = $fn.write :new, "getelementptr inbounds #{struct_type.to_s.chop}, #{struct_type} #{primary}, i32 0, i32 #{offset}"
        $fn.write :new, "load #{llvm_type}, #{llvm_type}* #{idx}, align 8"
      end
    end

    def initialize(value)
      @op = value
    end

    def self.parse(parser)
      primary = parse_first(parser) or return

      loop do
        case
        when (tmp = FunctionCall.parse(primary, parser)) then primary = tmp
        when (tmp = ArrayIndex.parse(primary, parser)) then primary = tmp
        when (tmp = FieldAccess.parse(primary, parser)) then primary = tmp
        else return primary
        end
      end
    end

    def self.parse_first(parser)
      Literal.parse(parser) || Unary.parse(parser) || parser.surround('(', ')') { Expression.parse parser }
    end
  end
end
