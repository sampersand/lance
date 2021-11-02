require_relative '../../compiler/type'

class TypeDecl
  class ArrayDecl < TypeDecl
    attr_reader :inner

    def initialize(inner)
      @inner = inner
    end

    # typedecl-array := '[' <typedecl> ']'
    def self.parse(parser)
      parser.surround '[', ']' do
        inner = TypeDecl.parse(parser, ignore_colon: true) or parser.error "found a `[` without a kind inside"
        new inner
      end
    end

    def llvm_type
      @type ||= Compiler::Type::List.new @inner.llvm_type
    end
  end
end

