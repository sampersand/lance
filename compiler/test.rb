#!/usr/bin/ruby
$OLD_VERSION = TARGET_TRIPLE = 'x86_64-apple-macosx10.13.0' 

require_relative 'parser'
require_relative 'compiler'
require 'optparse'

class Hash
  method_defined? :transform_values or def transform_values
    map { |k,v| [k, yield(v)]}.to_h
  end
end

opts = {
  input: [],
  output: 'out',
  compile: true,
  clean: false,
  finished: false
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

  op.on '--[no-]clean', 'remove old directory' do |c|
    opts[:clean] = clean
  end

  op.on '--include', 'output files to include' do |m|
    opts[:include] = true
  end

end.parse! $*

(warn "no input files, aborting"; return) if opts[:input].empty? && !opts[:include]

require 'fileutils'

TARGET_TRIPLE = 'arm64-apple-macosx12' if !$OLD_VERSION
FileUtils.rm_r(opts[:output]) rescue nil if opts[:clean]
FileUtils.mkdir_p (outdir=opts[:output])

if opts[:include]
  FileUtils.cp_r File.join(__dir__, '..', 'include', 'out'), outdir
end

opts[:input].each do |filename|
  $compiler = Compiler.new target_triple: TARGET_TRIPLE

  begin
    olddir = Dir.pwd
    Dir.chdir File.dirname filename
    Parser.new(Lexer.new file: File.basename(filename)).parse_program.each(&:compile)
  ensure
    Dir.chdir olddir
  #rescue Parser::ParseError
   # abort "#$!"
  end

  File.write File.join(outdir, File.basename(filename, '.*') + '.ll'), $compiler.to_llvm(is_main: false)
end

if opts[:compile] || opts[:include]
  $compiler = Compiler.new target_triple: TARGET_TRIPLE
  File.write File.join(outdir, '___main.ll'), $compiler.to_llvm(is_main: true)

  if opts[:compile]
    opts[:compile] = outdir + '/lance.out' if opts[:compile] == true
    system 'clang', '-o', opts[:compile], '-xir', *Dir[outdir + '/*.ll'], *Dir[__dir__ + '/../include/out/*.ll']
    exit $?.to_i
  end
end
