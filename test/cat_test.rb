# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'
require_relative '../lib/cat'

describe 'Cat Command - parse_options' do
  it 'parses -n correctly' do
    options, args = CatTool.parse_options(['-n', 'file.txt'])
    _(options[:number_lines]).must_equal true
    _(options[:number_nonblank_lines]).must_equal false
    _(args).must_equal ['file.txt']
  end

  it 'parses -b correctly' do
    options, args = CatTool.parse_options(['-b', 'file.txt'])
    _(options[:number_lines]).must_equal false
    _(options[:number_nonblank_lines]).must_equal true
    _(args).must_equal ['file.txt']
  end

  it 'defaults to false for both options' do
    options, args = CatTool.parse_options(['file.txt'])
    _(options[:number_lines]).must_equal false
    _(options[:number_nonblank_lines]).must_equal false
    _(args).must_equal ['file.txt']
  end
end

describe 'Cat Command - run_cli' do
  let(:sample_text) { "foo\n\nbar\nbaz\n" }

  it 'prints all lines as-is by default' do
    File.write('test.txt', sample_text)
    output = StringIO.new
    $stdout = output
    CatTool.run_cli(['test.txt'])
    $stdout = STDOUT
    _(output.string).must_equal sample_text
    File.delete('test.txt')
  end

  it 'numbers all lines with -n' do
    File.write('test.txt', sample_text)
    output = StringIO.new
    $stdout = output
    CatTool.run_cli(['-n', 'test.txt'])
    $stdout = STDOUT
    _(output.string).must_equal "\t1 foo\n\t2 \n\t3 bar\n\t4 baz\n"
    File.delete('test.txt')
  end

  it 'numbers only non-blank lines with -b' do
    File.write('test.txt', sample_text)
    output = StringIO.new
    $stdout = output
    CatTool.run_cli(['-b', 'test.txt'])
    $stdout = STDOUT
    _(output.string).must_equal "\t1 foo\n\n\t2 bar\n\t3 baz\n"
    File.delete('test.txt')
  end
end
