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
end

class Statements
  def initialize(lines)
    @lines = lines
  end

  def self.parse(parser)
    parser.surround '{', '}' do
      new parser.repeat { Statement.parse parser }
    end
  end

  def compile(fn)
    @lines.each do |line|
      line.compile fn
    end
  end
end
