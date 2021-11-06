class Lexer
  def initialize(file:)
    @stream = File.read file
    @imports = {file => true}
  end

  KEYWORDS = %w(
    global fn struct enum extern externf import
    if else while return do switch case
    let set
    true false null
  ).freeze

  def next
    n = next_
    return n unless n == [:symbol, 'import']
    import = next_
    raise "need a string" unless import[0] == :string
    raise "need a semicolon" unless next_ == [:symbol, ';']

    f = File.realpath import[1]
    @imports[f] ||= begin
      @stream.prepend File.read f
      true
    end
    self.next
  end

  def next_
    @stream.slice! %r{\A(\s+|//.*?\n|/\*.*?\*/)*}m
    return if @stream =~ /\A__EOF__\n/

    return if @stream.empty?
    @stream.slice! /\A\d+\b/ and return [:number, $&.to_i]
    @stream.slice! /\A[a-zA-Z_][\w_]*\b(?:::[a-zA-Z_]\w*\b)?/ and return [KEYWORDS.include?($&) ? :symbol : :identifier, $&.sub('::', '$')]
    @stream.slice! /\A([=!><]?=|[&|]{2}|[-+*\/%<>!;,\[\]\{\}\(\):.?])/ and return [:symbol, $&]
    @stream.slice! /\A'([^']*)'/ and return [:string, $1]
    @stream.slice! /\A"((?:\\"|[^"])*)"/ or raise "invalid token start '#{@stream[0].inspect}'"
    [:string, $1
        .gsub('\n',"\n")
        .gsub('\t',"\t")
        .gsub('\r',"\r")
        .gsub('\f',"\f")
        .gsub(/\\['"\\]/,'\1')
        .gsub(/\\x\h\h/){ |x| x[/\h\h/].to_i(16).chr }]
  end
end
