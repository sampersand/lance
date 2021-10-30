module Ast
  class TypeDecl
    class ArrayDecl < TypeDecl
      attr_reader :type, :array_depth

      def initialize(type, array_depth=1)
        @type = type
        @array_depth = array_depth
      end

      # typedecl-array := '[' <typedecl> ']'
      def self.parse(parser)
        inner =
          parser.surround('[', ']') {
            TypeDecl.parse parser, ignore_colon: true or parser.error "found a `[` without a kind inside"
          } or return

        if inner.is_a? ArrayDecl
          new inner.type, inner.array_depth + 1
        else
          new inner
        end
      end
    end
  end
end