class Tokenizer
  def initialize(stream)
    @stream = stream
  end

  KEYWORDS = %w(global function import if else while return let set do true false null).freeze

  def next
    @stream.slice! %r{\A(\s+|/\*.*?\*/)*}m

    return if @stream.empty?
    @stream.slice! /\A\d+\b/ and return [:number, $&.to_i]
    @stream.slice! /\A\w[\w_]*\b/ and return [KEYWORDS.include?($&) ? :symbol : :identifier, $&]
    @stream.slice! /\A([=!><]?=|[-+*\/%<>!;&|,])/ and return [:symbol, $&]
    @stream.slice! /\A[\[\]\{\}\(\)]/ and return [:symbol, $&]
    @stream.slice! /\A'([^']*)'/ and return [:string, $1]
    @stream.slice! /\A"((?:\\"|[^"])*)"/ or raise "invalid token start '#{@stream[0].inspect}'"
    [:string, $1
        .gsub('\n',"\n")
        .gsub('\t',"\t")
        .gsub('\r',"\r")
        .gsub('\f',"\f")
        .gsub(/\\x\h\h/){ |x| x[/\h\h/].to_i(16).chr }]
  end
end
