# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'
require_relative '../lib/head'

describe 'Head command - parse options' do
  before do
    @options = {
      lines: 10,
      bytes: nil,
      quiet: false
    }
  end

  it 'should parse -n option' do
    args = ['-n', '5', 'test.txt']
    options, _args = HeadTool.parse_options(args)

    _(options[:lines]).must_equal true
    _(options[:bytes]).must_be_nil
    _(args[0]).must_equal '5'
    _(args[1]).must_equal 'test.txt'
  end

  it 'should parse -c option' do
    args = ['-c', '20', 'test.txt']
    options, _args = HeadTool.parse_options(args)

    _(options[:lines]).must_equal 10 # default value
    _(options[:bytes]).must_equal true
    _(args[0]).must_equal '20'
    _(args[1]).must_equal 'test.txt'
  end

  it 'should parse -q option' do
    args = ['-q', 'test.txt']
    options, _args = HeadTool.parse_options(args)

    _(options[:quiet]).must_equal true
    _(args[0]).must_equal 'test.txt'
  end
end

describe 'Head command - run_cli' do
  before do
    @content = "Line 1\nLine 2\nLine 3\nLine 4\nLine 5\nLine 6\nLine 7\nLine 8\nLine 9\nLine 10"
    @expected_output = "Line 1\nLine 2\nLine 3\nLine 4\nLine 5\n"
  end

  it 'should print first N lines from stdin' do
    input = StringIO.new(@content)
    output = StringIO.new
    $stdin = input
    $stdout = output

    # Pass '-n', '5' so the code can pick up '5' as the value for lines
    HeadTool.run_cli(['-n', '5'])

    $stdin = STDIN
    $stdout = STDOUT

    # Only the first 5 lines should be printed
    _(output.string).must_equal @expected_output
  end

  it 'should print first N bytes from stdin' do
    input = StringIO.new(@content)
    output = StringIO.new
    $stdin = input
    $stdout = output

    # Pass '-c', '12' so the code can pick up '12' as the value for bytes
    HeadTool.run_cli(['-c', '12'])

    $stdin = STDIN
    $stdout = STDOUT

    # Only the first 12 bytes should be printed
    _(output.string).must_equal @content.byteslice(0, 12)
  end

  it 'should handle quiet mode' do
    input = StringIO.new(@content)
    output = StringIO.new
    $stdin = input
    $stdout = output

    HeadTool.run_cli(['-q'])

    $stdin = STDIN
    $stdout = STDOUT

    _(output.string).must_equal @expected_output # No headers printed in quiet mode
  end
end
