#!/usr/bin/ruby
require_relative 'parser'
require_relative 'compiler'
require 'optparse'

opts = {
  input: [],
  output: 'out',
  compile: true
}

OptParse.new do |op|
  op.on '-i', '--input=file', 'input file. CAn be specified multiple times' do |f|
    opts[:input].push f
  end

  op.on '-o', '--output=DIR', 'Output directory for llvm files, and final compiled file' do |o|
    opts[:output] = o
  end

  op.on '-c', '--[no-]compile[=file]', 'Compile the code to the output file,', 'which defaults to `lance.out` in output dir' do |c|
    opts[:compile] = c
  end
end.parse! $*

(warn "no input files, aborting"; return) if opts[:input].empty?

require 'fileutils'

FileUtils.mkdir_p (outdir=opts[:output])
opts[:input].each do |filename|
  $compiler = Compiler.new target_triple: 'arm64-apple-macosx12.0.0'
  Parser.new(Lexer.new File.read filename).parse_program.each(&:compile)

  File.write File.join(outdir, File.basename(filename, '.*') + '.ll'), $compiler.to_llvm(is_main: false)
end

if opts[:compile]
  $compiler = Compiler.new target_triple: 'arm64-apple-macosx12.0.0'
  File.write File.join(outdir, '___main.ll'), $compiler.to_llvm(is_main: true)

  opts[:compile] = outdir + '/lance.out' if opts[:compile] == true
  system 'clang', '-o', opts[:compile], '-xir', *Dir[outdir + '/*.ll'], *Dir[__dir__ + '/../include/out/*.ll']
end
