# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'
require_relative '../lib/grep'

describe 'Grep Command - parse_options' do
  it 'parses -i option' do
    options, args = GrepTool.parse_options(['-i', 'pattern', 'file.txt'])
    _(options[:ignore_case]).must_equal true
    _(options[:invert_match]).must_equal false
    _(args).must_equal ['pattern', 'file.txt']
  end

  it 'parses -v option' do
    options, args = GrepTool.parse_options(['-v', 'pattern', 'file.txt'])
    _(options[:ignore_case]).must_equal false
    _(options[:invert_match]).must_equal true
    _(args).must_equal ['pattern', 'file.txt']
  end

  it 'defaults to false for both options' do
    options, args = GrepTool.parse_options(['pattern', 'file.txt'])
    _(options[:ignore_case]).must_equal false
    _(options[:invert_match]).must_equal false
    _(args).must_equal ['pattern', 'file.txt']
  end
end

describe 'Grep Command - run_cli' do
  let(:sample_text) { "foo\nbar\nbaz\nFoo\n" }

  it 'prints matching lines' do
    File.write('test.txt', sample_text)
    output = StringIO.new
    $stdout = output
    GrepTool.run_cli(['foo', 'test.txt'])
    $stdout = STDOUT
    _(output.string).must_equal "\e[31mfoo\e[0m\n"
    File.delete('test.txt')
  end

  it 'ignores case with -i' do
    File.write('test.txt', sample_text)
    output = StringIO.new
    $stdout = output
    GrepTool.run_cli(['-i', 'foo', 'test.txt'])
    $stdout = STDOUT
    _(output.string).must_equal "\e[31mfoo\e[0m\n\e[31mFoo\e[0m\n"
    File.delete('test.txt')
  end

  it 'inverts match with -v' do
    File.write('test.txt', sample_text)
    output = StringIO.new
    $stdout = output
    GrepTool.run_cli(['-v', 'foo', 'test.txt'])
    $stdout = STDOUT
    _(output.string).must_equal "bar\nbaz\nFoo\n"
    File.delete('test.txt')
  end
end
