require_relative '../expression'

class Statement
  class Continue
    def self.parse(parser)
      parser.guard 'continue' or return
      parser.endline
      new
    end

    def compile
      label = $fn.whiles.last.first or raise "`continue` used outside of a loop"
      $fn.write "br label #{label}"
      $fn.declare_label
    end
  end
end
