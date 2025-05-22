# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'
require_relative '../lib/cat'

describe 'Cat Command - parse_options' do
  it 'parses -n correctly' do
    options, args = CatTool.parse_options(['-n', 'file.txt'])

    _(options[:number_lines]).must_equal(true)
    _(options[:number_nonblank_lines]).must_equal(false)
    _(args).must_equal ['file.txt']
  end

  it 'parses -b option correctly' do
    options, args = CatTool.parse_options(['-b', 'file.txt'])

    _(options[:number_lines]).must_equal(false)
    _(options[:number_nonblank_lines]).must_equal(true)
    _(args).must_equal ['file.txt']
  end
end

describe 'Cat Command - print output' do
  let(:sample_text) { "foo\n\nbar\nbaz\n" }

  it 'prints all lines as-is by default' do
    options = { number_lines: false, number_nonblank_lines: false }
    output = StringIO.new
    $stdout = output
    CatTool.print_output(sample_text, options)
    $stdout = STDOUT

    _(output.string).must_equal sample_text
  end

  it 'numbers all lines with -n' do
    options = { number_lines: true, number_nonblank_lines: false }
    output = StringIO.new
    $stdout = output
    CatTool.print_output(sample_text, options)
    $stdout = STDOUT

    _(output.string).must_equal "\t1 foo\n\t2 \n\t3 bar\n\t4 baz\n"
  end

  it 'numbers only non-blank lines with -b' do
    options = { number_lines: false, number_nonblank_lines: true }
    output = StringIO.new
    $stdout = output
    CatTool.print_output(sample_text, options)
    $stdout = STDOUT

    _(output.string).must_equal "\t1 foo\n\n\t2 bar\n\t3 baz\n"
  end
end

describe 'Cat Command - process inputs from either file or stdin' do
  it 'reads from a file' do
    options= { number_lines: false, number_nonblank_lines: false }
    File.open('test_file.txt', 'w') { |file| file.write("foo\nbar\nbaz\n") }
    output = StringIO.new
    $stdout = output
    CatTool.process_input(File.open('test_file.txt', 'r'), options)
    $stdout = STDOUT

    _(output.string).must_equal "foo\nbar\nbaz\n"
    File.delete('test_file.txt') if File.exist?('test_file.txt')
  end

  it 'reads from stdin' do
    options = { number_lines: false, number_nonblank_lines: false }
    input = StringIO.new("foo\nbar\nbaz\n")
    output = StringIO.new
    $stdout = output
    CatTool.process_input(input, options)
    $stdout = STDOUT

    _(output.string).must_equal "foo\nbar\nbaz\n"
  end
end