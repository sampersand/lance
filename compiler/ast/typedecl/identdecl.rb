class TypeDecl
  class IdentDecl < TypeDecl
    attr_reader :name

    def initialize(name)
      @name = name
    end

    # typedecl-ident := <identifier>
    def self.parse(parser)
      name = parser.guard(:identifier, '!') or return

      new name
    end

    def llvm_type
      $compiler.lookup_type name
    end
  end
end
