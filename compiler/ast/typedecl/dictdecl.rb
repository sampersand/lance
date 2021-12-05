require_relative '../../compiler/type'

class TypeDecl
  class DictDecl < TypeDecl
    attr_reader :key, :val

    def initialize(key, val)
      @key = key
      @val = val
    end

    # typedecl-dict := '{' <typedecl> ':' <typedecl> '}'
    def self.parse(parser)
      parser.surround '{', '}' do
        key = TypeDecl.parse(parser, ignore_colon: true) or parser.error "found a `{` without a kind inside"

        if parser.guard ':'
          val = TypeDecl.parse(parser, ignore_colon: true) or parser.error "found a `{` without a kind inside"
        else
          val = key
        end

        new key, val
      end
    end

    def llvm_type
      @type ||= Compiler::Type::Dict.new @key.llvm_type, @val.llvm_type
    end
  end
end

