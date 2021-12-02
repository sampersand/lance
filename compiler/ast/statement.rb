require_relative 'statement/if'
require_relative 'statement/while'
require_relative 'statement/return'
require_relative 'statement/let'
require_relative 'statement/set'
require_relative 'statement/switch'
require_relative 'statement/do'
require_relative 'statement/break'
require_relative 'statement/continue'

class Statement
  class Unreachable
    def self.parse(parser)
      parser.guard 'unreachable' and new
    end

    def compile
      $fn.write 'unreachable'
    end
  end
  
  def self.parse(parser)
    If.parse(parser) ||
      While.parse(parser) ||
      Return.parse(parser) ||
      Do.parse(parser) ||
      Let.parse(parser) ||
      Set.parse(parser) ||
      Switch.parse(parser) ||
      Continue.parse(parser) ||
      Break.parse(parser) ||
      Unreachable.parse(parser)
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

  def compile
    @lines.each do |line|
      line.compile

      if line.is_a?(Statement::Do) && line.expr.llvm_type == Compiler::Type::Never
        return false
      end
    end

    true
  end
end
