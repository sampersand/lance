require_relative 'statement/if'
require_relative 'statement/while'
require_relative 'statement/return'
require_relative 'statement/let'
require_relative 'statement/set'
require_relative 'statement/do'

class Statement
  def self.parse(parser)
    If.parse(parser) ||
      While.parse(parser) ||
      Return.parse(parser) ||
      Let.parse(parser) ||
      Set.parse(parser) ||
      Do.parse(parser)
  end

  def self.parse_statements(parser)
    parser.surround '{', '}' do
      parser.repeat { parse(parser) }
    end
  end
end
