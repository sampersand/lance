require_relative 'lexer'
require_relative 'ast/declaration'

class Parser
  def initialize(lexer)
    @lexer = lexer
  end

  def peek
    @peeked ||= @lexer.next
  end

  def peek?(val)
    p = peek

    if guard val
      @peeked = p
      true
    else
      false
    end
  end

  def take
    peek.tap { @peeked = nil }
  end

  def eof?
    peek.nil?
  end

  def error(msg='Parser Error occurred')
    raise msg
  end

  def guard(*korvs)
    k, v = peek

    korvs.each do |korv|
      if korv.is_a?(Symbol) && k == korv || k == :symbol && v == korv
        return take.last
      end
    end

    nil
  end

  def expect(korv, err: nil)
    guard korv or error(err || "expected: #{korv}, got: #{peek}")
  end

  def surround(lhs, rhs)
    guard(lhs)&.then { yield.tap { expect rhs } }
  end

  def delineated(delim:, end:)
    end_ = binding.local_variable_get(:end)
    all = []

    until guard end_
      error "missing closing `#{end_}`" if eof?
      all.push yield
      next if guard delim
      # if we don't have the delim, we must have the end_
      expect end_, err: "missing #{end_.inspect} in delineated list"
      break
    end

    all
  end

  def repeat
    x = []
    while t = yield
      x << t
    end
    x
  end

  def endline(err: nil)
    expect ';', err: err
  end

  def identifier(err: nil)
    expect :identifier, err: err
  end

  def parse_program
    repeat { Declaration.parse self }
      .tap { eof? or raise "unexpected token: #{take.inspect}" }
  end
end
