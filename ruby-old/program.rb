#!/usr/bin/env ruby
require_relative 'ast'
require_relative 'parser'
require_relative 'tokenizer'
require 'pp'

class Program
  attr_reader :globals
  def initialize
    @globals = {}
    @callstack = []
  end

  def with_locals(lcls, &block)
    @callstack.push lcls
    ret = catch(:return, &block)
    @callstack.pop
    ret.nil? ? :null : ret
  end

  def declare_ident(name, value)
    @callstack.last[name] = value
  end

  def update_ident(name, value)
    if @callstack.last.key? name
      @callstack.last[name] = value
    elsif @globals.key? name
      @globals[name] = value
    else
      fail "unknown identifier '#{name}'"
    end
  end

  def get_ident(name)
    if @callstack.last.key? name
      @callstack.last[name]
    elsif @globals.key? name
      @globals[name]
    else
      raise "unknown variable #{name.inspect}"
    end
  end

  def play(input, argv)
    parser = Parser.new Tokenizer.new input
    parser.program.each do |decl|
      decl.compile self
    end

    main = @globals['main'] or raise "missing 'main'"
    main.call self, argv
  end
end

class Ast::Global
  def compile pgm
    pgm.globals[name] ||= :null
  end
end

class Ast::Import
  def compile pgm
    parser = Parser.new Tokenizer.new File.read file
    parser.program.each do |decl|
      decl.compile pgm
    end
  end
end

class Ast::Function
  def compile pgm
    pgm.globals[name] = self
  end

  def call(pgm, call_args)
    unless call_args.length == args.length
      raise "argc mismatch ('#{name}' expects #{args.length}, got #{call_args.length})"
    end

    pgm.with_locals args.zip(call_args).to_h do
      body.each do |stmt|
        stmt.run pgm
      end
    end
  end
end

class Ast::If
  def run pgm
    if cond.run(pgm) == true
      body.each { |x| x.run pgm }
    else
      self.else&.each { |x| x.run pgm }
    end
  end
end

class Ast::While
  def run pgm
    while cond.run(pgm) == true
      body.each do |expr|
        expr.run pgm 
      end
    end
  end
end

class Ast::Return
  def run pgm
    throw :return, value&.run(pgm)
  end
end

class Ast::Do
  def run pgm
    expr.run pgm
  end
end

class Array
  def run _; self end
end
class Integer
  def run _; self end
end
class String
  def run _; self end
end
class TrueClass
  def run _; self end
end
class FalseClass
  def run _; self end
end

class Ast::Let
  def run pgm
    pgm.declare_ident name, value.run(pgm)
  end
end

class Ast::Set
  def run pgm
    if (indices || []).empty?
      pgm.update_ident name, value.run(pgm)
    else
      base = pgm.get_ident name
      *pre, last = indices.map { |x| x.run pgm }
      pre.each do |index| # todo: use reduce cause that's cool
        base = base[index]
      end

      base[last] = value.run pgm
    end
  end
end

class Ast::BinaryOperator
  def run pgm
    lhs.run(pgm).send op, rhs.run(pgm)
  end
end

class Ast::Unary
  def run pgm
    value.run(pgm).send op
  end
end

class Ast::Literal
  def run pgm
    case value
    when Integer, String then value
    when :true then true
    when :false then false
    when :null then :null
    when Symbol then pgm.get_ident value.to_s
    when Array then value.map { |x| x.run pgm }
    else fail "bad value: #{value}"
    end
  end
end

class Ast::FunctionCall
  def run pgm
    if fn.is_a?(Ast::Literal) && fn.value.is_a?(Symbol)
      run_symbol pgm
    else
      fn.run(pgm).call pgm, args.map { |a| a.run pgm }
    end
  end

  def run_symbol pgm
    a = args.map { |a| a.run pgm }
    case fn.value
    when :atoi then a[0].to_i
    when :itoa then a[0].to_s
    when :kindof then
      case a[0]
      when true, false then 'boolean'
      when :null then 'null'
      when Integer then 'integer'
      when String then 'string'
      when Array then 'array'
      else raise "unknown kind encountered: #{a[0].class}"
      end
    when :length then a[0].length
    when :insert then a[0].insert a[1], a[2]
    when :delete then a[0].delete_at a[1]
    when :substr then a[0][a[1], a[2]]
    when :print then print a[0]; $stdout.flush
    when :dump then pp a[0]
    when :prompt then gets
    when :exit then exit a[0]
    when :random then rand 0..65535
    else fn.run(pgm).call pgm, a
    end
  end
end

class Ast::ArrayIndex
  def run pgm
    ary.run(pgm)[idx=expr.run(pgm)] or raise "index out of bounds: #{idx}"
  end
end


Dir.chdir File.dirname $*.first
Program.new.play(File.read(File.basename $*.first), [$*.slice!(0..-1)]) if $0 == __FILE__
