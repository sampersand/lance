require_relative '../expression'

class Statement
  class Break
    def self.parse(parser)
      parser.guard 'break' or return
      parser.endline
      new
    end

    def compile
      $fn.whiles.last.last.push $fn.write_nop
      $fn.declare_label
    end
  end
end
