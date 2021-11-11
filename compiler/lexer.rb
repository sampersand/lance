class Lexer
  attr_reader :file, :lineno
  def initialize(file:)
    @stream = File.read @file=file
    @imports = {file => true}
    @lineno = 0
  end

  KEYWORDS = %w(
    global fn priv struct enum extern externf import
    if else while loop return do switch case break continue
    let set
    true false null
    unreachable
  ).freeze

  def next
    n = next_
    return n unless n == [:symbol, 'import']
    import = next_
    raise "need a string" unless import[0] == :string

    f = File.realpath import[1]
    @imports[f] ||= begin
      @stream.prepend f=File.read(f)
      @lineno -= f.count "\n"
      true
    end
    self.next
  end

  def next_
    @lineno += @stream.slice!(%r{\A(\s+|//.*?\n|/\*.*?\*/)*}m).count "\n"
    return if @stream =~ /\A__EOF__\n/

    return if @stream.empty?
    @stream.slice! /\A\d+\b/ and return [:number, $&.to_i]
    @stream.slice! /\A[a-zA-Z_][\w_]*\b(?:::[a-zA-Z_]\w*\b)?/ and return [KEYWORDS.include?($&) ? :symbol : :identifier, $&.sub('::', '-')]
    @stream.slice! /\A([=!><]?=|[&|]{2}|[-+*\/%<>!;,\[\]\{\}\(\):.?])/ and return [:symbol, $&]
    if @stream.slice! /\A'((?:\\[\']|[^'])*)'/
      @lineno += $&.count "\n"
      return [:string, $1.gsub(/\\(['"])/, '\1')]
    end

    @stream.slice! /\A"((?:\\.|[^"])*?)"/ or raise "invalid token start '#{@stream[0].inspect}'"
    @lineno += $&.count "\n"
    [:string, $1
        .gsub('\n',"\n")
        .gsub('\t',"\t")
        .gsub('\r',"\r")
        .gsub('\f',"\f")
        .gsub(/\\(['"\\])/,'\1')
        .gsub(/\\x\h\h/){ |x| x[/\h\h/].to_i(16).chr }]
  end
end
