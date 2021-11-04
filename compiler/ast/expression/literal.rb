class Expression
  class Literal
    StructDecl = Struct.new :name, :args do
      def llvm_type
        @llvm_type ||= Compiler::Type::Struct.new name, args.transform_values(&:llvm_type)
      end
    end

    attr_reader :value
    def initialize(value)
      @value = value
    end

    def self.parse(parser)
      parser.guard 'true' and return new :true
      parser.guard 'false' and return new :false
      parser.guard 'null' and return new :null

      num = parser.guard(:number) and return new num
      str = parser.guard(:string) and return new str
      if (ident = parser.guard(:identifier)&.to_sym)
        if parser.guard '{'
          return new StructDecl.new ident, {} if parser.guard '}'
          return new StructDecl.new ident, parser.delineated(delim: ',', end: '}'){
            name = parser.guard(:identifier) or parser.error "missing identifier"
            parser.expect ':', err: "missing `:` for struct field decl"
            value = Expression.parse(parser) or parser.error "missing expression for field '#{name}'"
            [name, value]
          }.to_h
        else
          return new ident
        end
      end

      parser.surround '[', ']' do
        first = Expression.parse(parser) or next new []
        new [first] + parser.repeat { parser.guard ',' and Expression.parse(parser) }
      end
    end

    def compile_literal(type, value, align)
      local = $fn.write :new, "alloca #{type}, align #{align}"
      $fn.write "store #{type} #{value}, #{type}* #{local}, align #{align}"
      $fn.write :new, "load #{type}, #{type}* #{local}, align #{align}"
    end

    def llvm_type
      @llvm_type ||= 
        case @value
        when Integer then Compiler::Type::Primitive::Num
        when :true, :false then Compiler::Type::Primitive::Bool
        when String then Compiler::Type::Primitive::Str
        when Array
          return Compiler::Type::List.new :empty if @value.empty?
          inner = @value.first.llvm_type

          if @value.all? {|e| e.llvm_type == inner }
            Compiler::Type::List.new inner
          else
            raise "array isn't an array of exclusively #{inner.inspect}"
          end
        when :null then raise "todo"
        when Symbol then $fn.lookup(@value).llvm_type
        when StructDecl then @value.llvm_type
        end
    end

    def compile_non_empty_array
      # we pass `any` as the check's already been done earlier.
      eles = @value.map {|ele| ele.compile type: :any }
      align = nil
      kind = @value.first.llvm_type.tap { |x| align = x.byte_length }.to_s
      # align = kind.byte_length

      # note that we use `8` as the size for all types
      list = $fn.write :new, "call %struct.builtin.list* @fn.builtin.allocate_list(i64 #{eles.length}, i64 #{align})"
      bitcast = $fn.write :new, "bitcast %struct.builtin.list* #{list} to #{kind}**"
      ptr  = $fn.write :new, "load #{kind}*, #{kind}** #{bitcast}, align #{align}"
      $fn.write "store #{kind} #{eles.first}, #{kind}* #{ptr}, align 8"

      eles[1..].each_with_index do |ele, idx|
        # +1 for index as we alreadyd id the first one
        tmp = $fn.write :new, "getelementptr inbounds #{kind}, #{kind}* #{ptr}, i64 #{idx + 1}"
        $fn.write "store #{kind} #{ele}, #{kind}* #{tmp}, align 8"
      end

      len = $fn.write :new, "getelementptr inbounds %struct.builtin.list, %struct.builtin.list* #{list}, i64 0, i32 2"
      $fn.write "store %num #{eles.length}, %num* #{len}, align 8"
      list
    end

    def compile(type:)
      # $fn.validate_types given: llvm_type, expected: type, allow_any: true

      case @value
      when :true, :false then compile_literal '%bool', (@value == :true ? 1 : 0), 1
      when Integer then compile_literal '%num', @value, 8
      when String then compile_literal '%struct.builtin.str*', $llvm.string_literal(@value), 8
      when Array
        if @value.empty?
          compile_literal '%struct.builtin.list*', 'null', 8
          return
        end

        compile_non_empty_array
      when Symbol
        val = $fn.lookup @value

        if val.is_a?(Compiler::Function) || val.is_a?(Compiler::PredeclaredExternFunction)
          fn = $fn.write :new, "alloca #{val.llvm_type}, align 8"
          $fn.write "store #{val.llvm_type} #{val}, #{val.llvm_type}* #{fn}, align 8"
          $fn.write :new, "load #{llvm_type}, #{llvm_type}* #{fn}, align 8"
        elsif val.is_a?(Compiler::Function::Variable) && val.arg? || val.is_a?(Compiler::Global)
          val.local
        else
          $fn.write :new, "load #{val.llvm_type}, #{val.llvm_type}* #{val}, align #{val.llvm_type.align}"
        end
      when StructDecl
        struct_ty = @value.llvm_type
        args = @value.args.values.map { |a| [a.llvm_type, a.compile(type: a.llvm_type)] }
        struct_local = $fn.write :new, "alloca #{struct_ty}, align 8"
        mallc = $fn.write :new, "call i8* @xmalloc(i64 #{struct_ty.byte_length})"
        cast = $fn.write :new, "bitcast i8* #{mallc} to #{struct_ty}"
        $fn.write "store #{struct_ty} #{cast}, #{struct_ty}* #{struct_local}, align 8"

        args.each_with_index do |(type, local), offset|
          tmp = $fn.write :new, "getelementptr inbounds #{struct_ty.to_s.chop}, #{struct_ty} #{cast}, i32 0, i32 #{offset}"
          $fn.write "store #{type} #{local}, #{type}* #{tmp}, align 8"
        end
        cast


  #       exit
  # # %5 = alloca %struct.foo*, align 8
  # # %6 = call i8* @xmalloc(i64 16)
  # # %7 = bitcast i8* %6 to %struct.foo*
  # # store %struct.foo* %7, %struct.foo** %5, align 8
  # # %10 = getelementptr inbounds %struct.foo, %struct.foo* %9, i32 0, i32 0
  # # store %struct.list* %8, %struct.list** %10, align 8

      else
        fail "unknown internal type? (#{@value.inspect})"
      end
    end
  end
end
