require_relative 'declaration/extern'
require_relative 'declaration/function'
require_relative 'declaration/global'
require_relative 'declaration/struct'
require_relative 'declaration/enum'

class Declaration
  class LLVM
    def initialize(llvm)
      @llvm = llvm
    end

    def self.parse(parser)
      parser.guard '__llvm__' or return
      parser.expect '('
      new parser.guard(:string).tap { parser.expect ')' }
    end

    def compile
      $llvm.write_inline @llvm
    end
  end

  def self.parse(parser)
    Extern.parse(parser) ||
      Function.parse(parser) ||
      Global.parse(parser) ||
      Struct.parse(parser) || 
      Enum.parse(parser) ||
      LLVM.parse(parser)
  end
end
