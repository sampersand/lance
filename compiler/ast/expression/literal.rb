class Expression
  class Literal
    StructDecl = Struct.new :name, :args, :enum do
      def llvm_type
        @llvm_type ||=
          if name.to_s =~ /\$/
            enum = $compiler.lookup_type $`
            Compiler::Type::Enum::Variant.new(
              enum,
              enum.position($').tap { |x| x.nil? and raise "unknown variant '#$'' for enum #$`" },
              Compiler::Type::Struct.new(name, args.transform_values(&:llvm_type))
            )
          else
            Compiler::Type::Struct.new name, args.transform_values(&:llvm_type)
          end
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
        return new ident unless $compiler.lookup_type(ident, error: false) && parser.guard('{')
        return new StructDecl.new ident, {} if parser.guard '}'
        return new StructDecl.new ident, parser.delineated(delim: ',', end: '}'){
          name = parser.expect :identifier, err: "missing identifier for struct decl of type '#{ident}'"
          parser.expect ':', err: "missing `:` for struct field decl"
          value = Expression.parse(parser) or parser.error "missing expression for field '#{name}'"
          [name, value]
        }.to_h
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

    def compile_symbol(type)
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
    end

    def compile_variant(type)
      # /(?<enum_name>\w+)\$(?<variant_name>\w+)/ =~ @value.name or raise "oops, bad name?: #{@value.name}"
      kind = @value.llvm_type

      Literal.new(StructDecl.new("enum."+kind.enum.name, {
        '0' => Literal.new(kind.idx),
        '1' => Literal.new(StructDecl.new(kind.name, @value.args).tap { |x| x.llvm_type.instance_variable_set :@not_a_variant, 1})
      })).compile type: type
    end

    def compile_struct_decl(type)
      struct_ty = @value.llvm_type
      args = @value.args.values.map { |a| [a.llvm_type, a.compile(type: a.llvm_type)] }
      struct_local = $fn.write :new, "alloca #{struct_ty}, align 8"
      mallc = $fn.write :new, "call i8* @xmalloc(i64 #{struct_ty.byte_length})"
      cast = $fn.write :new, "bitcast i8* #{mallc} to #{struct_ty}"
      $fn.write "store #{struct_ty} #{cast}, #{struct_ty}* #{struct_local}, align 8"

      args.each_with_index do |(type, local), offset|
        tmp = $fn.write :new, "getelementptr inbounds #{struct_ty.to_s.chop}, #{struct_ty} #{cast}, i32 0, i32 #{offset}"

        if struct_ty.name =~ /\Aenum\./ && offset == 1
          newty = "[#{$compiler.lookup_type($').variants_length} x i8]"
          tmp = $fn.write :new, "bitcast #{newty}* #{tmp} to #{type}*" # this is probably unsound
        end

        # if type.is_a? Compiler::Type::Enum::Variant
          # type = type.enum
        # end

        # p st

        $fn.write "store #{type} #{local}, #{type}* #{tmp}, align 8;  !"
      end

      cast
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
      when Symbol then compile_symbol type
      when StructDecl
        # p @value.llvm_type
        # p @value.llvm_type.instance_variable_defined? :@not_a_variant
        # puts caller
        # puts
        # puts
        if @value.llvm_type.is_a?(Compiler::Type::Enum::Variant) && !@value.llvm_type.instance_variable_defined?(:@not_a_variant)
          compile_variant type
        else
          compile_struct_decl type
        end
      else
        fail "unknown internal type? (#{@value.inspect})"
      end
    end
  end
end
