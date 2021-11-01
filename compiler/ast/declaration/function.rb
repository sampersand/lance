require_relative '../typedecl'
require_relative '../statement'
require_relative '../../compiler/function'

class Declaration
  class Function < Declaration
    attr_reader :name, :args, :return_type, :body

    def initialize(name, args, return_type, body)
      @name = name
      @args = args
      @return_type = return_type
      @body = body
    end

    # fn-decl := 'fn' <ident> '(' {<ident> <typedecl> ','} ')' [':' <typedecl>] <brace-statements>
    #                 note the last `,` is optional in arguments
    def self.parse(parser)
      parser.guard 'fn' or return
      fn_name = parser.identifier err: 'missing name for fn'
      parser.expect '(', err: 'missing `(` for fn arg decl'

      args = parser.delineated delim: ',', end: ')' do
        arg_name = parser.identifier err: "invalid name for field of fn #{fn_name}"
        arg_type = TypeDecl.parse(parser) or parser.error "missing kind for fn #{fn_name}'s argument #{arg_name}"
        [arg_name, arg_type]
      end

      return_type = TypeDecl.parse parser
      body = Statements.parse(parser) or parser.error "missing body for fn #{fn_name}"

      new fn_name, args, return_type, body
    end

    def compile(compiler)
      fn =
        Compiler::Function.new(
          name,
          args.map { |name, type| [name, type.to_type(compiler)] },
          return_type&.to_type(compiler),
          compiler: compiler
        )
      compiler.declare_global fn.name, fn

      body.compile fn
    end
  end
end
