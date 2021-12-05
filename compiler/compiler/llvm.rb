class LLVM
  def initialize(target_triple:)
    @target_triple = target_triple

    @functions = {}
    @structs = {}
    @enums = {}
    @globals = {}
    @externs = {}
    @strings = {}
  end

  def struct_type(name, fields)
    name =~ /^enum\./ and return (@enums.fetch $')[:name]+'*'
    (@structs[name.to_s] ||= {
      name: "%struct.user.#{name.to_s.tr '%', ''}", fields: fields&.transform_values(&:llvm_type)
    })[:name] + '*'
  end

  def enum_type(name, variants)
    (@enums[name.to_s] ||= {
      name: "%struct.user.enum.#{name.to_s.tr '%', ''}",
      variants: variants.each {|f| struct_type f.name, f.fields }
    })[:name] + '*'
  end

  def declare_global(name, type)
    (@globals[name] ||= {name: "@globals.#{name}", type: type})[:name]
  end

  def string_literal(string)
    @strings[string] ||= "@string.#{string.hash}"
  end

  def declare_extern(name, type, externf)
    (@externs[name] ||= {name: "@#{externf ? 'fn.user' : 'globals'}.#{name}", type: type, externf: externf})[:name]
  end

  def fn_name_for(name)
    "@fn.user.#{name}"
  end

  def declare_function(name, args, return_type, is_private)
    fn = @functions[name] and return fn[:name]

    @functions[name] = {
      name: fn_name_for(name),
      args: args,
      return_type: return_type,
      body: [],
      is_private: is_private
    }
    @functions[name][:body] = yield
    @functions[name][:name]
  end

  def final_string(is_main:)
    struct_declarations = @structs.values.map { |a|
      name, fields = a.values_at(:name, :fields)
      raise "unfinished struct declaration for '#{name}'" unless fields
      "#{name} = type { #{fields.values.join ', '} }"
    }

    enum_declarations = @enums.values.map { |a|
      name, variants = a.values_at(:name, :variants)
      len = (variants.map { |x| x.fields.length }.max || 0) * 8
      "#{name} = type { i64, [#{len} x i8] }"
    }

    global_declarations = @globals.values.map { |a|
      name, type = a.values_at(:name, :type)
      "#{name} = #{type.private? ? 'internal ' : '' }global #{type} #{type.default}, align 8"
    }

    extern_declarations = @externs.values.map { |a|
      name, type, externf = a.values_at(:name, :type, :externf)
      if externf
        "declare #{type.return_type} #{name}(#{type.args.join(', ')})"
      else
        "#{name} = external global #{type}, align 8"
      end
    }

    string_declarations = @strings.map {|string, name|
      # lol this is a mess, it hink `string_len`  is irrelevant
      string = string.bytes.map { |x| x.chr =~ /[[:print:]]/ && x.chr != ?" && x.chr != ?\\ ?  x.chr : '\%02X' % x }.join
      string_len = string.gsub(/\\../,'.').length
      strtype = "[#{string_len} x i8]"
      <<~LLVM
        #{name}.str = private unnamed_addr constant #{strtype} c"#{string}", align 1
        #{name} = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds (#{strtype}, #{strtype}* #{name}.str, i32 0, i32 0), i64 #{string_len} }, align 8
      LLVM
    }

    functions = @functions.values.map { |a|
      name, args, return_type, body, is_private = a.values_at(:name, :args, :return_type, :body, :is_private)
      <<~EOS
        define #{is_private ? "internal " : ""}#{return_type} #{name}(#{
            args.map { |a, i| "#{a.type} #{a.local}" }.join ', '
        }) {
          #{body.join "\n  "}
        }
      EOS
    }

    x=(<<~LLVM.gsub('fn.builtin.','')); !$OLD_VERSION ? x : x.gsub(/(declare|define).*/){ |x| x.gsub(/%\d/,'') }
      ; Prelude
      target triple = "#@target_triple"
      %bool = type i64 ; used to be i8, this is just to simplify interfaces
      %num = type i64
      %struct.builtin.str = type { i8*, i64 } ; (ptr, len)
      %struct.builtin.any = type { i8*, i64 } ; (ptr, type)
      %struct.builtin.list = type { i8*, i64, i64 } ; (ptr, len, cap)
      %struct.builtin.dict = type { %struct.builtin.dict_eles*, i64, i64, i1 (i64, i64)* }
      %struct.builtin.dict_eles = type { i64, i64 }
      %struct.builtin.io = type { %struct.builtin.str*, %struct.builtin.str*, i8* } ; (name, mode, file)

      ; Number builtins
      declare %struct.builtin.str* @fn.builtin.num_to_str(%num %0) 
      declare %num @fn.builtin.powll(%num %0, %num %1)

      ; List builtins builtins
      declare %struct.builtin.list* @fn.builtin.allocate_list(i64 %0) 
      declare %struct.builtin.list* @fn.builtin.concat_lists(%struct.builtin.list* %0, %struct.builtin.list* %1)
      declare %struct.builtin.list* @fn.builtin.repeat_list(%struct.builtin.list* %0, %num %1)
      declare %bool @fn.builtin.insert_into_list(%struct.builtin.list* %0, i64 %1, i8* %2)
      declare %bool @fn.builtin.delete_from_list(%struct.builtin.list* %0, i8* %1, i64 %2)
      declare void @fn.builtin.push_into_list(%struct.builtin.list* %0, i8* %1)
      declare void @fn.builtin.pop_from_list(%struct.builtin.list* %0, i8* %1)

      ; Dict builtins builtins
      declare %struct.builtin.dict* @fn.builtin.allocate_dict(i64 %0) 
      declare %bool @fn.builtin.fetch_from_dict(%struct.builtin.dict* %0, i8* %1, i8* %2)
      declare void @fn.builtin.insert_into_dict(%struct.builtin.list* %0, i8* %1, i64 %2)
      declare %bool @fn.builtin.has_key(%struct.builtin.list* %0, i8* %1)

      ; String builtins
      declare %struct.builtin.str* @fn.builtin.allocate_str(i64 %0) 
      declare %num @fn.builtin.str_to_num(%struct.builtin.str* %0) 
      declare %struct.builtin.str* @fn.builtin.concat_strs(%struct.builtin.str* %0, %struct.builtin.str* %1) 
      declare %struct.builtin.str* @fn.builtin.repeat_str(%struct.builtin.str* %0, %num %1) 
      declare i32 @fn.builtin.compare_strs(%struct.builtin.str* %0, %struct.builtin.str* %1) 
      declare %struct.builtin.str* @fn.builtin.substr(%struct.builtin.str* %0, i64 %1, i64 %2)
      declare %struct.builtin.str* @fn.builtin.ascii_to_str(%num %0)
      declare %num @fn.builtin.str_to_ascii(%struct.builtin.str* %0)

      ; IO Builtins
      declare %struct.builtin.io* @fn.builtin.open_io(%struct.builtin.str* %0, %struct.builtin.str* %1)
      declare %struct.builtin.str* @fn.builtin.readline_io(%struct.builtin.io* %0)
      declare %struct.builtin.str* @fn.builtin.readall_io(%struct.builtin.io* %0)
      declare void @fn.builtin.write_io(%struct.builtin.io* %0, %struct.builtin.str* %1)

      ; Misc builtins
      declare i8* @fn.builtin.xmalloc(i64 %0)
      declare void @fn.builtin.print_str(%struct.builtin.str* %0) 
      declare void @fn.builtin.println_str(%struct.builtin.str* %0) 
      declare void @fn.builtin.quit(%num %0) noreturn 
      declare void @fn.builtin.abort_msg(%struct.builtin.str* %0) noreturn 
      declare %struct.builtin.str* @fn.builtin.prompt() 
      declare %num @fn.builtin.random_()

      ; Struct declarations
      #{struct_declarations.join "\n"}

      ; Enum declarations
      #{enum_declarations.join "\n"}

      ; Global declarations
      #{global_declarations.join "\n"}

      ; External declarations
      #{extern_declarations.join "\n"}

      ; String declarations
      #{string_declarations.join "\n"}

      ; Functions
      #{functions.join "\n"}

      #{is_main ? <<~LLVM : ""}
      declare %num @fn.user.main(%struct.builtin.list* %0)

      define %num @main() {
        %1 = call %num @fn.user.main(%struct.builtin.list* null);
        ret %num %1;
      }
      LLVM
    LLVM
  end
end

