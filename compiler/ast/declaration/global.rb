require_relative '../typedecl'

class Declaration
  class Global < Declaration
    attr_reader :name, :type, :is_private

    def initialize(name, type, is_private)
      @name = name
      @type = type
      @is_private = is_private
    end

    # global := 'global' <ident> <typedecl> ';'
    def self.parse(parser)
      parser.guard 'global' or return
      is_private = parser.guard 'priv'
      name = parser.identifier err: 'missing name for global'
      type = TypeDecl.parse(parser) or parser.error "missing kind for global '#{name}'"
      parser.endline 

      new name, type, is_private
    end

    def compile
      $compiler.declare_global name, type.llvm_type, is_private
    end
  end
end
