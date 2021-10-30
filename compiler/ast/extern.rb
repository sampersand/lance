require_relative 'typedecl'

module Ast
  class Extern
    attr_reader :name, :type

    def initialize(name, type)
      @name = name
      @type = type
    end

    # extern := 'extern' <ident> <typedecl> ';'
    def self.parse(parser)
      parser.guard 'extern' or return
      name = parser.identifier err: 'missing name for extern'
      type = Ast::TypeDecl.parse(parser) or parser.error "missing kind for extern '#{name}'"
      parser.endline 

      new name, type
    end
  end
end
