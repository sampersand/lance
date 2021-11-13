require_relative '../typedecl'
require_relative '../../compiler/type'

class Declaration
  class Struct < Declaration
    attr_reader :name, :fields

    def initialize(name, fields)
      @name = name
      @fields = fields
      compile
    end

    # struct-decl := 'struct' <ident> '{' {<ident> <typedecl> ','} '}'
    #                 note the last `,` is optional
    def self.parse(parser, require_struct_keyword: true)
      if require_struct_keyword
        parser.guard 'struct' or return
      end

      struct_name = parser.identifier err: 'missing name for struct'
      if parser.guard '{', err: 'missing `{` for struct'
        fields = parser.delineated delim: ',', end: '}' do
          field_name = parser.identifier err: "invalid name for field of struct #{struct_name}"
          field_type = TypeDecl.parse(parser) or parser.error "missing kind for '#{struct_name}.#{field_name}'"
          [field_name, field_type]
        end.to_h
      end

      new struct_name, fields
    end

    def llvm_type
      @type ||= Compiler::Type::Struct.new name, @fields
    end

    def compile
      @compiled ||= $compiler.declare_type llvm_type
    end
  end
end
