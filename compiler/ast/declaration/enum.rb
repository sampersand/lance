require_relative '../typedecl'
require_relative '../../compiler/type'

class Declaration
  class Enum < Declaration
    attr_reader :name, :kinds

    def initialize(name, kinds)
      @name = name
      @kinds = kinds
      kinds.each do |k|
        k.instance_variable_set :@enum, self
      end
      compile
    end

    def self.parse(parser)
      parser.guard 'enum' or return
      enum_name = parser.identifier err: 'missing name for enum'
      parser.expect '{', err: 'missing `{` for enum'

      kinds = parser.delineated delim: ',', end: '}' do
        name = parser.guard(:identifier) or next
        parser.expect ':', err: 'expected `:` after enum decl'

        str = Struct.parse(parser, struct_name: "#{enum_name}-#{name}") and next str
      end

      new enum_name, kinds
    end

    def llvm_type
      @type ||= Compiler::Type::Enum.new name, @kinds
    end

    def compile
      @compiled ||= begin
        $compiler.declare_type llvm_type
        llvm_type.variants.each do |var|
          $compiler.declare_type var
        end
      end
    end
  end
end
