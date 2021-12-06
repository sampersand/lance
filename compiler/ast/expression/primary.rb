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

        new primary, args
      end

      def validate!
        if @fn.is_a?(Expression::Primary::FieldAccess)
          name = @fn.primary.llvm_type.name.to_s + '.member.' + @fn.field.to_s
          @args.unshift @fn.primary
          @fn = Expression::Literal.new name.to_sym
        end
      end

      def compile(type:)
        validate!

        if @fn.is_a?(Expression::Literal) && %i(
          list.member.delete
          list.member.insert
          str.member.len
          list.member.len
          list.member.push
          list.member.pop
          dict.member.len
          dict.member.has_key
        ).include?(@fn.value)
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

        $fn.section "compiling function with return type #{type}: #@fn #@args" do
          fn = @fn.compile type: @fn.llvm_type
          args = @args.map { |a| "#{a.llvm_type} #{a.compile(type: a.llvm_type)}" } # we already verified it with `fn`
          return_type = @fn.llvm_type.return_type

          str = "call #{return_type} #{fn}(#{args.join ', '})"
          if return_type == Compiler::Type::Primitive::Void  || return_type == Compiler::Type::Never
            $fn.write str
            $fn.write 'unreachable' if return_type == Compiler::Type::Never
          else
            $fn.write :new, str
          end
        end
      end

      def llvm_type
        validate!
        @llvm_type ||= begin
          if @fn.value == :'list.member.pop'
            @args.first.llvm_type.inner
          else
            @fn.llvm_type.return_type || Compiler::Type::Primitive::Void
          end
        end
      end

      private def compile_special(type)
        $fn.section "compiling symbol of type #{type}: #{@fn.value}" do
          case @fn.value
          when :'list.member.pop'
            raise "invalid argc for pop: needed 1, got #{@args.length}" unless @args.length == 1

            list_type = @args[0].llvm_type
            if !list_type.is_a?(Compiler::Type::List)
              raise "can only pop into lists, not #{list_type.inspect}"
            end

            list = @args[0].compile type: list_type

            ele_ptr = $fn.write :new, "alloca #{list_type.inner}, align #{list_type.inner.align}"
            void_ptr = $fn.write :new, "bitcast #{list_type.inner}* #{ele_ptr} to i8*"
            $fn.write "call void @fn.builtin.pop_from_list(%struct.builtin.list* #{list}, i8* #{void_ptr})"
            $fn.write :new, "load #{list_type.inner}, #{list_type.inner}* #{ele_ptr}, align #{list_type.inner.align}"

          when :'list.member.push'
            raise "invalid argc for push: needed 2, got #{@args.length}" unless @args.length == 2

            list_type = @args[0].llvm_type

            if !list_type.is_a?(Compiler::Type::List)
              raise "can only push into lists, not #{list_type.inspect}"
            end

            list = @args[0].compile type: list_type
            value = @args[1].compile type: list_type.inner

            ele_ptr = $fn.write :new, "alloca #{list_type.inner}, align #{list_type.inner.align}"
            $fn.write "store #{list_type.inner} #{value}, #{list_type.inner}* #{ele_ptr}, align #{list_type.inner.align}"

            void_ptr = $fn.write :new, "bitcast #{list_type.inner}* #{ele_ptr} to i8*"
            $fn.write "call void @fn.builtin.push_into_list(%struct.builtin.list* #{list}, i8* #{void_ptr})"

          when :'list.member.insert'
            raise "invalid argc for insert: needed 3, got #{@args.length}" unless @args.length == 3

            list_type = @args[0].llvm_type

            if !list_type.is_a?(Compiler::Type::List)
              raise "can only insert into lists, not #{list_type.inspect}"
            end

            list = @args[0].compile type: list_type
            index = @args[1].compile type: Compiler::Type::Primitive::Num
            value = @args[2].compile type: list_type.inner

            ele_ptr = $fn.write :new, "alloca #{list_type.inner}, align #{list_type.inner.align}"
            $fn.write "store #{list_type.inner} #{value}, #{list_type.inner}* #{ele_ptr}, align #{list_type.inner.align}"

            void_ptr = $fn.write :new, "bitcast #{list_type.inner}* #{ele_ptr} to i8*"
            $fn.write :new, "call zeroext %bool @fn.builtin.insert_into_list(%struct.builtin.list* #{list}, i64 #{index}, i8* #{void_ptr})"

          when :'dict.member.delete'
            raise "todo"

          when :'list.member.delete'
            raise "invalid argc for delete: needed 2, got #{@args.length}" unless @args.length == 2

            list_type = @args[0].llvm_type
            if !list_type.is_a?(Compiler::Type::List)
              raise "can only delete into lists, not #{list_type.inspect}"
            end

            list = @args[0].compile type: list_type
            index = @args[1].compile type: Compiler::Type::Primitive::Num

            ele_ptr = $fn.write :new, "alloca #{list_type.inner}, align #{list_type.inner.align}"
            void_ptr = $fn.write :new, "bitcast #{list_type.inner}* #{ele_ptr} to i8*"
            $fn.write :new, "call zeroext %bool @fn.builtin.delete_from_list(%struct.builtin.list* #{list}, i8* #{void_ptr}, i64 #{index})"
          when :'str.member.len', :'list.member.len', :'dict.member.len'
            raise "invalid argc for length: needed 1, got #{@args.length}" unless @args.length == 1

            ty = @args[0].llvm_type

            if ty != Compiler::Type::Primitive::Str && !ty.is_a?(Compiler::Type::List) && !ty.is_a?(Compiler::Type::Dict)
              raise "invalid type for len, given #{ty}, expected string or list"
            end

            val = @args[0].compile type: :any

            tmp = $fn.write :new, "getelementptr inbounds #{ty.to_s.chop}, #{ty} #{val}, i64 0, i32 1"
            $fn.write :new, "load i64, i64* #{tmp}, align 8"
          when :'dict.member.has_key'
            raise "invalid argc for push: needed 2, got #{@args.length}" unless @args.length == 2

            dict_type = @args[0].llvm_type

            if !dict_type.is_a?(Compiler::Type::Dict)
              raise "can only has_key for dicts, not #{dict_type.inspect}"
            end

            list = @args[0].compile type: dict_type
            value = @args[1].compile type: dict_type.key

            ele_ptr = $fn.write :new, "alloca #{dict_type.key}, align #{dict_type.key.align}"
            $fn.write "store #{dict_type.key} #{value}, #{dict_type.key}* #{ele_ptr}, align #{dict_type.key.align}"

            void_ptr = $fn.write :new, "bitcast #{dict_type.key}* #{ele_ptr} to i8*"
            $fn.write :new, "call zeroext i1 @fn.builtin.has_key(%struct.builtin.dict* #{list}, i8* #{void_ptr})"

          else
            raise "unknown special function '#{@fn.value}'"
          end
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
        elsif @ary.llvm_type.is_a? Compiler::Type::Primitive::Dict
          return compile_dict type
        end

        inner_type = @ary.llvm_type.inner 
        $fn.validate_types expected: type, given: inner_type

        $fn.section "compiling array index (ary=#@ary, index=#@index) with return type #{type}:" do
          ary = @ary.compile type: :any
          idx = @index.compile type: Compiler::Type::Primitive::Num

          tmp1 = $fn.write :new, "bitcast %struct.builtin.list* #{ary} to #{inner_type}**"
          tmp2 = $fn.write :new, "load #{inner_type}*, #{inner_type}** #{tmp1}, align 8"
          tmp3 = $fn.write :new, "getelementptr inbounds #{inner_type}, #{inner_type}* #{tmp2}, %num #{idx}"
          $fn.write :new, "load #{inner_type}, #{inner_type}* #{tmp3}, align 8"
        end
      end

      def compile_dict(type)
        $fn.validate_types expected: type, given: @ary.llvm_type.val
        type = @ary.llvm_type.val

        $fn.section "compiling dict index (ary=#@ary, index=#@index)" do
          dict = @ary.compile type: :any
          key = @index.compile type: @ary.llvm_type.key

          return_val = $fn.write :new, "alloca #{type}, align #{type.align}"
          key_ptr1 = $fn.write :new, "alloca #{@ary.llvm_type.key}, align 8"
          $fn.write "store #{@ary.llvm_type.key} #{key}, #{@ary.llvm_type.key}* #{key_ptr1}, align 8"
          key_ptr = $fn.write :new, "bitcast #{@ary.llvm_type.key}* #{key_ptr1} to i8*"
          return_ptr = $fn.write :new, "bitcast #{type}* #{return_val} to i8*"

          $fn.write :new, "call i1 @fn.builtin.fetch_from_dict(%struct.builtin.dict* #{dict}, i8* #{key_ptr}, i8* #{return_ptr})"
          $fn.write :new, "load #{type}, #{type}* #{return_val}, align 8"
        end
      end

      def compile_string(type)
        $fn.validate_types expected: type, given: Compiler::Type::Primitive::Str

        src = @ary.compile type: Compiler::Type::Primitive::Str
        idx = @index.compile type: Compiler::Type::Primitive::Num

        $fn.section "compiling string index (string=#@ary, index=#@index)" do
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
      end


      def llvm_type
        @llvm_type ||= 
          if @ary.llvm_type == Compiler::Type::Primitive::Str
            Compiler::Type::Primitive::Str
          elsif @ary.llvm_type.is_a? Compiler::Type::Primitive::Dict
            @ary.llvm_type.val
          else
            @ary.llvm_type.inner
          end
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
        if primary.is_a?(Expression::Literal) && $compiler.lookup_type(primary.value.to_s, error: false)
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
        $fn.section "compiling field access on #@primary . #@field with return type #{type}" do
          $fn.validate_types expected: type, given: llvm_type
          primary = @primary.compile type: struct_type
          offset = (
            struct_type.fields.each_with_index.find { |(k, v), _idx| k == @field } ||
            raise("unknown struct field '#@field' for type '#{struct_type.name}'")
          ).last

          idx = $fn.write :new, "getelementptr inbounds #{struct_type.to_s.chop}, #{struct_type} #{primary}, i32 0, i32 #{offset}"
          $fn.write :new, "load #{llvm_type}, #{llvm_type}* #{idx}, align 8"
        end
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
