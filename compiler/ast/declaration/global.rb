require_relative '../typedecl'

class Declaration
  class Global < Declaration
    attr_reader :name, :type

    def initialize(name, type)
      @name = name
      @type = type
    end

    # global := 'global' <ident> <typedecl> ';'
    def self.parse(parser)
      parser.guard 'global' or return
      name = parser.identifier err: 'missing name for global'
      type = TypeDecl.parse(parser) or parser.error "missing kind for global '#{name}'"
      parser.endline 

      new name, type
    end

    def compile(compiler)
      compiler.declare_global name, type.to_type(compiler)
    end
  end
end
