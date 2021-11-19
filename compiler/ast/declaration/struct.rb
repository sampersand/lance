require_relative '../typedecl'
require_relative '../../compiler/type'

class Declaration
  class Struct < Declaration
    attr_reader :name, :fields

    def initialize(name, fields)
      @name = name
      @fields = fields
      compile unless @name =~ /-/
    end

    # struct-decl := 'struct' <ident> '{' {<ident> <typedecl> ','} '}'
    #                 note the last `,` is optional
    def self.parse(parser, struct_name: nil)
      parser.guard 'struct' or return

      struct_name ||= parser.identifier err: 'missing name for struct'
      if parser.guard '{', err: 'missing `{` for struct'
        fields = parser.delineated delim: ',', end: '}' do
          field_name = parser.identifier err: "invalid name for field of struct #{struct_name}"
          field_type = TypeDecl.parse(parser) || TypeDecl::IdentDecl.new(field_name) # or parser.error "missing kind for '#{struct_name}.#{field_name}'"
          [field_name, field_type]
        end.to_h
      elsif parser.guard '='
        toalias = parser.expect(:identifier).to_s

        return Class.new do
          define_method :compile do 
            $compiler.alias_type struct_name, $compiler.lookup_type(toalias)
          end
        end.new
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
