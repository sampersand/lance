require_relative 'expression/primary'
require_relative 'expression/binary'

class Expression
  def self.parse(parser)
    lhs = Primary.parse(parser) or return
    Binary.parse(lhs, parser) || lhs
  end
end
