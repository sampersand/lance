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
    (@structs[name] ||= {
      name: "%struct.user.#{name.tr '%', ''}", fields: fields.map {|f| f.to_llvm_s self}
    })[:name] + '*'
  end

  def declare_global(name, type)
    (@globals[name] ||= {name: "@globals.#{name}", type: type})[:name]
  end

  def string_literal(string)
    @strings[string] ||= "@string.#{string.hash}"
  end

  def declare_extern(name, type)
    (@externs[name] ||= {name: "@globals.#{name}", type: type})[:name]
  end

  def declare_function(name, args, return_type)
    fn = @functions[name] and return fn[:name]

    @functions[name] = {
      name: "@fn.user.#{name}",
      args: args,
      return_type: return_type,
      body: []
    }
    @functions[name][:body] = yield
    @functions[name][:name]
  end

  def final_string
    struct_declarations = @structs.values.map { |name:, fields:|
      "#{name} = type { #{fields.join ', '} }"
    }

    global_declarations = @globals.values.map {|name:, type:|
      "#{name} = global #{type.to_llvm_s self} #{type.default self}, align 8"
    }

    extern_declarations = @externs.values.map {|name:, type:|
      "#{name} = external global #{type.to_llvm_s self}, align 8"
    }

    string_declarations = @strings.map {|string, name|
      strtype = "[#{string.length} x i8]"
      <<~LLVM
        #{name}.str = private unnamed_addr constant #{strtype} c#{string.inspect}, align 1
        #{name} = local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds (#{strtype}, #{strtype}* #{name}.str, i32 0, i32 0), i64 #{string.length} }, align 8
      LLVM
    }

    functions = @functions.values.map { |name:, args:, return_type:, body:|
      <<~EOS
        define #{return_type.to_llvm_s self} #{name}(#{
            args.map { |a, i| "#{a.type.to_llvm_s self} #{a.local}" }.join ', '
        }) {
          #{body.join "\n  "}
        }
      EOS
    }

    <<~LLVM
      ; Prelude
      target triple = "#@target_triple"
      %bool = type i8
      %num = type i64
      %struct.builtin.str = type { i8*, i64 } ; (ptr, len)
      %struct.builtin.any = type { i8*, i64 } ; (ptr, type)
      %struct.builtin.list = type { i8*, i64, i64 } ; (ptr, len, cap)

      ; Extern builtins
      declare %struct.builtin.list* @fn.builtin.init_list(i64 %0, i64 %1) 

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

      define %num @main() {
        %1 = call %num @fn.user.main(%struct.builtin.list* null);
        ret %num %1;
      }
    LLVM
  end
end

