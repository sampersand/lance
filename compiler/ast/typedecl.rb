require_relative 'typedecl/arraydecl'
require_relative 'typedecl/fndecl'
require_relative 'typedecl/identdecl'
require_relative 'typedecl/dictdecl'

class TypeDecl
  # typedecl := ':' (<identifier> | <array-typedecl> | <fn-typedecl>)
  def self.parse(parser, ignore_colon: false)
    unless ignore_colon
      parser.guard ':' or return
    end

    nil while parser.guard '*' # remove pointers
    IdentDecl.parse(parser) ||
      ArrayDecl.parse(parser) ||
      DictDecl.parse(parser) ||
      FnDecl.parse(parser) ||
      parser.error('missing kind after `:`')
  end
end
