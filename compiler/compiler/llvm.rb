class LLVM
  def initialize(target_triple:)
    @target_triple = target_triple

    @functions = {}
    @structs = {}
    @globals = {}
    @externs = {}
    @strings = {}
  end

  def struct_type(name, fields)
    (@structs[name.to_s] ||= {
      name: "%struct.user.#{name.to_s.tr '%', ''}", fields: fields.transform_values(&:llvm_type)
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

  def declare_function(name, args, return_type)
    fn = @functions[name] and return fn[:name]

    @functions[name] = {
      name: fn_name_for(name),
      args: args,
      return_type: return_type,
      body: []
    }
    @functions[name][:body] = yield
    @functions[name][:name]
  end

  def final_string(is_main:)
    struct_declarations = @structs.values.map { |name:, fields:|
      "#{name} = type { #{fields.values.join ', '} }"
    }

    global_declarations = @globals.values.map {|name:, type:|
      "#{name} = global #{type} #{type.default}, align 8"
    }

    extern_declarations = @externs.values.map {|name:, type:, externf:|
      if externf
        "declare #{type.return_type} #{name}(#{type.args.join(', ')})"
      else
        "#{name} = external global #{type}, align 8"
      end
    }

    string_declarations = @strings.map {|string, name|
      # lol this is a mess, it hink `string_len`  is irrelevant
      string = string.bytes.map { |x| x.chr =~ /[[:print:]]/ && x.chr != ?"?  x.chr : '\%02X' % x }.join
      string_len = string.gsub(/\\../,'.').length
      strtype = "[#{string_len} x i8]"
      <<~LLVM
        #{name}.str = private unnamed_addr constant #{strtype} c"#{string}", align 1
        #{name} = local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds (#{strtype}, #{strtype}* #{name}.str, i32 0, i32 0), i64 #{string_len} }, align 8
      LLVM
    }

    functions = @functions.values.map { |name:, args:, return_type:, body:|
      <<~EOS
        define #{return_type} #{name}(#{
            args.map { |a, i| "#{a.type} #{a.local}" }.join ', '
        }) {
          #{body.join "\n  "}
        }
      EOS
    }

    <<~LLVM.gsub('fn.builtin.','')#.tap { |x| puts x }
      ; Prelude
      target triple = "#@target_triple"
      %bool = type i8
      %num = type i64
      %struct.builtin.str = type { i8*, i64 } ; (ptr, len)
      %struct.builtin.any = type { i8*, i64 } ; (ptr, type)
      %struct.builtin.list = type { i8*, i64, i64 } ; (ptr, len, cap)

      ; List builtins builtins
      declare %struct.builtin.list* @fn.builtin.allocate_list(i64 %0, i64 %1) 
      declare %struct.builtin.list* @fn.builtin.concat_lists(%struct.builtin.list* %0, %struct.builtin.list* %1, i64 %2)
      declare %struct.builtin.list* @fn.builtin.repeat_list(%struct.builtin.list* %0, %num %1, i64 %2)
      declare %bool @fn.builtin.insert_into_list(%struct.builtin.list* %0, i8* %1, i64 %2, i64 %3)
      declare %bool @fn.builtin.delete_from_list(%struct.builtin.list* %0, i8* %1, i64 %2, i64 %3)

      ; String builtins
      declare %struct.builtin.str* @fn.builtin.allocate_str(i64 %0) 
      declare %struct.builtin.str* @fn.builtin.num_to_str(%num %0) 
      declare %num @fn.builtin.str_to_num(%struct.builtin.str* %0) 
      declare %struct.builtin.str* @fn.builtin.concat_strs(%struct.builtin.str* %0, %struct.builtin.str* %1) 
      declare %struct.builtin.str* @fn.builtin.repeat_str(%struct.builtin.str* %0, %num %1) 
      declare i32 @fn.builtin.compare_strs(%struct.builtin.str* %0, %struct.builtin.str* %1) 
      declare %struct.builtin.str* @substr(%struct.builtin.str* %0, i64 %1, i64 %2)

      ; Misc builtins
      declare i8* @fn.builtin.xmalloc(i64 %0)
      declare void @fn.builtin.print(%struct.builtin.str* %0) 
      declare void @fn.builtin.quit(%num %0) 

      ; Struct declarations
      #{struct_declarations.join "\n"}

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

