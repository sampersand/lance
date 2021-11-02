class LLVM
  def initialize(target_triple:)
    @target_triple = target_triple

    @functions = {}
    @arrays = {}
    @structs = {}
    @globals = {}
    @externs = {}
    @strings = {}
  end

  def struct_type(name, fields)
    (@structs[name] ||= {
      name: "%struct.user.#{name.tr '%', ''}", fields: fields.map {|f| f.llvm_type self}
    })[:name] + '*'
  end

  def array_type(inner)
    inner_llvm = inner.llvm_type self

    (@arrays[inner] ||= {name: "%struct.array.#{inner_llvm.tr '%', ''}", inner: inner_llvm})[:name] + '*'
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
      name: "@functions.user.#{name}",
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

    array_declarations = @arrays.values.map { |name:, inner:|
      "#{name} = type { #{inner}*, i64, i64 } "
    }

    global_declarations = @globals.values.map {|name:, type:|
      "#{name} = global #{type.llvm_type self} #{type.default self}, align 8"
    }

    extern_declarations = @externs.values.map {|name:, type:|
      "#{name} = external global #{type.llvm_type self}, align 8"
    }

    string_declarations = @strings.map {|string, name|
      strtype = "[#{string.length} x i8]"
      <<~LLVM
        #{name}.str = private unnamed_addr constant #{strtype} c#{string.inspect}, align 1
        #{name} = local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds (#{strtype}, #{strtype}* @.str, i32 0, i32 0), i64 #{string.length} }, align 8
      LLVM
    }

    functions = @functions.values.map{|name:, args:, return_type:, body:|
      <<~EOS
        define #{return_type.llvm_type self} #{name}(#{
            args.map { |a, i| "#{a.type.llvm_type self} #{a.local}" }.join ', '
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

      ; Struct declarations
      #{struct_declarations.join "\n"}

      ; Array declarations
      #{array_declarations.join "\n"}

      ; Global declarations
      #{global_declarations.join "\n"}

      ; External declarations
      #{extern_declarations.join "\n"}

      ; Functions
      #{functions.join "\n"}
    LLVM
  end
end

