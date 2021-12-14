require_relative '../expression'

class Statement
  class Goto
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def self.parse(parser)
      parser.guard 'goto' or return
      name = parser.identifier err: 'missing identifier for `goto` statement'
      parser.endline
      new name
    end

    def compile
      $fn.declare_user_jump @name
    end
  end

  class Label
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def self.parse(parser)
      parser.guard 'label' or return
      name = parser.identifier err: 'missing identifier for `label` statement'
      parser.endline
      new name
    end

    def compile
      fn = $fn.write_nop
      fn.write "br label #{$fn.declare_user_label @name}"
    end
  end
end
