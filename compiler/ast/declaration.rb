require_relative 'declaration/extern'
require_relative 'declaration/function'
require_relative 'declaration/global'
require_relative 'declaration/struct'

class Declaration
  def self.parse(parser)
    Extern.parse(parser) ||
      Function.parse(parser) ||
      Global.parse(parser) ||
      Struct.parse(parser)
  end
end
