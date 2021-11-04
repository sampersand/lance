require_relative 'declaration/extern'
require_relative 'declaration/function'
require_relative 'declaration/global'
require_relative 'declaration/struct'
require_relative 'declaration/enum'

class Declaration
  def self.parse(parser)
    Extern.parse(parser) ||
      Function.parse(parser) ||
      Global.parse(parser) ||
      Struct.parse(parser) || 
      Enum.parse(parser)
  end
end
