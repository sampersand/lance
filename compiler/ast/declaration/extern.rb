require_relative '../typedecl'

class Declaration
  class Extern < Declaration
    attr_reader :name, :type, :externf

    def initialize(name, type, externf)
      @name = name
      @type = type
      @externf = externf
    end

    # extern := 'extern' <ident> <typedecl> ';'
    def self.parse(parser)
      externf = (parser.guard('extern', 'externf') || return) == 'externf'
      name = parser.identifier err: 'missing name for extern'
      if parser.guard '.'
        name = "#{name}.member.#{parser.identifier err: "missing `.` for fn name"}"
      end

      type = TypeDecl.parse(parser) or parser.error "missing kind for extern '#{name}'"
      parser.endline 
#      if name =~ /\.member\./
#        type.args.unshift TypeDecl::IdentDecl.new($`)
#      end

      new name, type, externf
    end

    def compile
      $compiler.declare_extern name, type.llvm_type, externf
    end
  end
end
