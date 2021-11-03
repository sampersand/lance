#!/usr/bin/ruby
require_relative 'parser'
require_relative 'compiler'


input = $*.shift or abort "missing input file"
output = $*.shift || '../tmp/lance'


$compiler = compiler = Compiler.new target_triple: 'arm64-apple-macosx12.0.0'
Parser.new(Lexer.new File.read input).parse_program.each do |decl|
  decl.compile
end

# c = Compiler.new Parser.new File.read input
IO.pipe do |r,w|
  w.write compiler.to_llvm
  w.close
  system 'clang', '-o', output, '-xir', '-', *Dir["../include/out/*.ll"], in: r
end

