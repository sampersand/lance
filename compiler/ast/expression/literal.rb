class Expression
  class Literal
    def initialize(value)
      @value = value
    end

    def self.parse(parser)
      parser.guard 'true' and return new :true
      parser.guard 'false' and return new :false
      parser.guard 'null' and return new :null

      num = parser.guard(:number) and return new num
      str = parser.guard(:string) and return new str
      ident = parser.guard(:identifier) and return new ident.to_sym

      parser.surround '[', ']' do
        first = Expression.parse(parser) or next []
        new [first] + parser.repeat { parser.guard ',' and Expression.parse(parser) }
      end
    end

    def compile(fn)
      # case @value
      fail
      # when 
    end
  end
end
