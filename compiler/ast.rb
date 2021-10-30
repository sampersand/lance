module Ast
  class Type
    def self.parse(parser)
      parser.guard ':' or return

      if parser.guard '['
        inner = self.parse or parser.error "found a `[` without a kind inside"
        parser.expect ']', 'missing `]` for rhs of array kind'
        new inner, array: true
      else
        type = parser.identifier or parser.error 'missing kind after `:`'
        new type, array: false,
      end
    end
  end
end
