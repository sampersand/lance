require_relative '../../compiler/type'

class TypeDecl
  class FnDecl < TypeDecl
    attr_reader :args, :ret_type

    def initialize(args, ret_type)
      @args = args
      @ret_type = ret_type
    end

    # typedecl-fn := 'fn' '(' {<typedecl> ','} ')' [':' <typedecl>
    #               trailing `,` in arguments is optional
    def self.parse(parser)
      parser.guard 'fn' or return
      parser.expect '(', err: 'missing `(` after fn in type decl'

      args =
        parser.delineated delim: ',', end: ')' do
          TypeDecl.parse parser, ignore_colon: true or parser.error 'invalid type found in fnkind decl'
        end

      ret_type = TypeDecl.parse parser
      new args, ret_type
    end

    def llvm_type
      @type ||= Compiler::Type::Function.new @args.map(&:llvm_type), @ret_type&.llvm_type
    end
  end
end
