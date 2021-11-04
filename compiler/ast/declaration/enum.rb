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
    end

    def self.parse(parser)
      parser.guard 'enum' or return
      enum_name = parser.identifier err: 'missing name for enum'
      parser.expect '{', err: 'missing `{` for enum'

      kinds = parser.delineated delim: ',', end: '}' do
        str = Struct.parse(parser, require_struct_keyword: false) or next
        str.tap { |x| x.name.prepend "#{enum_name}$" }
      end

      new enum_name, kinds
    end

    def llvm_type
      @type ||= Compiler::Type::Enum.new name, @kinds
    end

    def compile
      $compiler.declare_type llvm_type
      llvm_type.variants.each do |var|
        $compiler.declare_type var
      end
    end
  end
end
