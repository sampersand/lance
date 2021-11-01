require_relative 'typedecl/arraydecl'
require_relative 'typedecl/fndecl'
require_relative 'typedecl/identdecl'

class TypeDecl
  # typedecl := ':' (<identifier> | <array-typedecl> | <fn-typedecl>)
  def self.parse(parser, ignore_colon: false)
    unless ignore_colon
      parser.guard ':' or return
    end

    IdentDecl.parse(parser) ||
      ArrayDecl.parse(parser) ||
      FnDecl.parse(parser) ||
      parser.error('missing kind after `:`')
  end
end
