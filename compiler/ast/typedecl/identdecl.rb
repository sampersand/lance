module Ast
  class TypeDecl
    class IdentDecl < TypeDecl
      attr_reader :type

      def initialize(type)
        @type = type
      end

      # typedecl-ident := <identifier>
      def self.parse(parser)
        type = parser.guard(:identifier) or return

        new type
      end
    end
  end
end