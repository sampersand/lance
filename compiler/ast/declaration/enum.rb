require_relative '../typedecl'
require_relative '../../compiler/type'

class Declaration
  class Enum < Declaration
    attr_reader :name, :kinds

    def initialize(name, kinds)
      @name = name
      @kinds = kinds
      kinds&.each do |k|
        k.instance_variable_set :@enum, self
      end
      compile
    end

    def self.parse(parser)
      parser.guard 'enum' or return
      enum_name = parser.identifier err: 'missing name for enum'
      if parser.guard '{', err: 'missing `{` for enum'
        kinds = parser.delineated delim: ',', end: '}' do
          name = parser.guard(:identifier) or next
          parser.expect ':'

          if rhs=parser.guard(:identifier)
            if rhs == 'void'
              Struct.new name, {}
            else
              Struct.new name, '_' => TypeDecl::IdentDecl.new(rhs)
            end
          else
            Struct.parse(parser, struct_name: "#{name}")
          end
            .tap { |x| x.name.prepend "#{enum_name}-" }
        end
      end

      new enum_name, kinds
    end

    def llvm_type
      @type ||= begin
        l = (Compiler::Type::Enum.new name, @kinds)
        #if (t = $compiler.lookup_type(name, error: false))
         # t.variants = l.variants_
        #end
        l
      end
          
    end

    def compile
      @compiled ||= begin
        $compiler.declare_type llvm_type
        if @kinds
          llvm_type.variants.each do |var|
            $compiler.declare_type var
          end
        end
      end
    end
  end
end
