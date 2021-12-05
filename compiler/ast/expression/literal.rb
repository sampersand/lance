class Expression
  class Literal
    StructDecl = Struct.new :name, :args, :enum do
      def llvm_type
        @llvm_type ||=
          if name.to_s =~ /-/
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
        return new ident unless ($compiler.lookup_type(ident, error: false) || ident.to_s.include?('-')) && parser.guard('{')
        return new StructDecl.new ident, {} if parser.guard '}'
        return new StructDecl.new ident, parser.delineated(delim: ',', end: '}'){
          name = parser.expect :identifier, err: "missing identifier for struct decl of type '#{ident}'"
          value = 
            if parser.guard ':'
              x=Expression.parse(parser) or parser.error "missing expression for field '#{name}'"
            else
              Literal.new name.to_sym
            end
          [name, value]
        }.to_h
      end

      parser.surround '[', ']' do
        first = Expression.parse(parser) or next new []
        new [first] + parser.repeat { parser.guard ',' and Expression.parse(parser) }
      end

      parser.surround '{', '}' do
        dict = {}
        ele1 = Expression.parse(parser) or next new dict
        parser.error "expected `:` in ele decl"  unless ele1.is_a?(Expression::Binary) && ele1.op == ':'
        dict[ele1.lhs] = ele1.rhs

        parser.repeat {
          parser.guard ',' and begin
            ele = Expression.parse(parser) or next
            parser.error "expected `:` in ele decl"  unless ele.is_a?(Expression::Binary) && ele.op == ':'
            dict[ele.lhs] = ele.rhs
            true
          end
        }.to_h
        new dict
      end
    end

    def compile_literal(type, value, align)
      $fn.section "Compile literal of #{type}: #{value}" do
        local = $fn.write :new, "alloca #{type}, align #{align}"
        $fn.write "store #{type} #{value}, #{type}* #{local}, align #{align}"
        $fn.write :new, "load #{type}, #{type}* #{local}, align #{align}"
      end
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
        when Hash
          return Compiler::Type::Dict.new :any, :any if @value.empty?
          key = @value.keys.first.llvm_type
          val = @value.values.first.llvm_type

          if @value.all? { |k,v| k.llvm_type == key && v.llvm_type == val }
            Compiler::Type::Dict.new key, val
          else
            raise "dict isn't exclusively #{key.inspect}: #{val.inspect}"
          end

        when :null then raise "todo"
        when Symbol then $fn.lookup(@value).llvm_type
        when StructDecl then @value.llvm_type
        end
    end

    def compile_array(type:)
      $fn.section "compiling array of type #{type}: #@value" do
        # we pass `any` as the check's already been done earlier.
        eles = @value.map {|ele| ele.compile type: type }
        align = type.align
        type = type.to_s
        # align = type.byte_length

        # note that we use `8` as the size for all types
        list = $fn.write :new, "call %struct.builtin.list* @fn.builtin.allocate_list(i64 #{eles.length})"
        if eles.first
          bitcast = $fn.write :new, "bitcast %struct.builtin.list* #{list} to #{type}**"
          ptr  = $fn.write :new, "load #{type}*, #{type}** #{bitcast}, align #{align}"
          $fn.write "store #{type} #{eles.first}, #{type}* #{ptr}, align 8"

          eles[1..-1].each_with_index do |ele, idx|
            # +1 for index as we alreadyd id the first one
            tmp = $fn.write :new, "getelementptr inbounds #{type}, #{type}* #{ptr}, i64 #{idx + 1}"
            $fn.write "store #{type} #{ele}, #{type}* #{tmp}, align 8"
          end
        end

        len = $fn.write :new, "getelementptr inbounds %struct.builtin.list, %struct.builtin.list* #{list}, i64 0, i32 1"
        $fn.write "store %num #{eles.length}, %num* #{len}, align 8"
        list
      end
    end

    def compile_symbol(type)
      val = $fn.lookup @value

      $fn.section "compiling symbol of type #{type}: #{val}" do
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
    end

    def compile_variant(type)
      # /(?<enum_name>\w+)-(?<variant_name>\w+)/ =~ @value.name or raise "oops, bad name?: #{@value.name}"
      kind = @value.llvm_type

      Literal.new(StructDecl.new("enum."+kind.enum.name, {
        '0' => Literal.new(kind.idx),
        '1' => Literal.new(StructDecl.new(kind.name, @value.args).tap { |x| x.llvm_type.instance_variable_set :@not_a_variant, 1})
      })).compile type: type
    end

    def compile_struct_decl(type)
      $fn.section "compiling struct declaration of type #{type}: #{@value}" do
        struct_ty = @value.llvm_type # $compiler.lookup_type(@value.llvm_type.name).llvm_type
        #p [struct_ty, @value.llvm_type, @value.llvm_type.name, type.name]
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

          $fn.write "store #{type} #{local}, #{type}* #{tmp}, align 8"
        end

        cast
      end
    end

    def compile_dict type:
      $fn.section "compiling dict of type #{type}: #@value" do
        eles = @value.map {|key,val| [key.compile(type: type.key), val.compile(type: type.val)] }

        # we pass `any` as the check's already been done earlier.
        align = type.align

        # note that we use `8` as the size for all types
        # eql = $fn.write :new, "%1"
        eql = self.class.new(
          case type.key
          when Compiler::Type::Primitive::Str  then :'fn.builtin.compare_str'
          when Compiler::Type::Primitive::List then :'fn.builtin.compare_list'
          when Compiler::Type::Primitive::Dict then :'fn.builtin.compare_dict'
          else                                      :'fn.builtin.compare_val'
          end
        ).compile type: :any

        dict = $fn.write :new, "call %struct.builtin.dict* @fn.builtin.allocate_dict(i64 #{eles.length}, i1 (i64,i64)* #{eql})"
        if eles.first
          eles.each do |key, val|
            local_key = $fn.write :new, "alloca #{type.key}, align #{align}"
            $fn.write "store #{type.key} #{key}, #{type.key}* #{local_key}, align #{align}"

            local_val = $fn.write :new, "alloca #{type.val}, align #{align}"
            $fn.write "store #{type.val} #{val}, #{type.val}* #{local_val}, align #{align}"

            ptr_key = $fn.write :new, "bitcast #{type.key}* #{local_key} to i8*"
            ptr_val = $fn.write :new, "bitcast #{type.val}* #{local_val} to i8*"
            $fn.write "call void @fn.builtin.insert_into_dict(%struct.builtin.dict* #{dict}, i8* #{ptr_key}, i8* #{ptr_val})"
          end
        end

        dict
      end
    end


    def compile(type:)
      # $fn.validate_types given: llvm_type, expected: type, allow_any: true

      case @value
      when :true, :false then compile_literal '%bool', (@value == :true ? 1 : 0), 1
      when Integer then compile_literal '%num', @value, 8
      when String then compile_literal '%struct.builtin.str*', $llvm.string_literal(@value), 8
      when Array then compile_array type: type.inner
      when Hash then compile_dict type: type
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
