# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'
require_relative '../lib/grep'

describe 'Grep command - parse options' do
  before do
    @options = {
      ignore_case: false,
      invert_match: false
    }
  end

  it 'should parse -i option' do
    args = ['-i', 'pattern', 'test.txt']
    options, _args = GrepTool.parse_options(args)

    _(options[:ignore_case]).must_equal true
    _(options[:invert_match]).must_equal false
    _(args[0]).must_equal 'pattern'
    _(args[1]).must_equal 'test.txt'
  end

  it 'should parse -v option' do
    args = ['-v', 'pattern', 'test.txt']
    options, _args = GrepTool.parse_options(args)

    _(options[:ignore_case]).must_equal false
    _(options[:invert_match]).must_equal true
    _(args[0]).must_equal 'pattern'
    _(args[1]).must_equal 'test.txt'
  end
end

describe 'Grep command - process input - ignore case' do
  before do
    @content = "This is a test line.\nAnother test line.\nYet another line."
    @pattern = 'test'
    @options = {
      ignore_case: false,
      invert_match: false
    }
  end

  it 'should print matching lines' do
    expected_output = <<~OUTPUT
      This is a \e[31mtest\e[0m line.
      Another \e[31mtest\e[0m line.
    OUTPUT
    output = StringIO.new
    $stdout = output

    GrepTool.process_input(@content, @pattern, @options)

    $stdout = STDOUT
    _(output.string).must_equal expected_output
  end

  it 'should handle case insensitivity' do
    @pattern = 'TEST'
    @options[:ignore_case] = true
    expected_output = <<~OUTPUT
      This is a \e[31mtest\e[0m line.
      Another \e[31mtest\e[0m line.
    OUTPUT
    output = StringIO.new
    $stdout = output

    GrepTool.process_input(@content, @pattern, @options)

    $stdout = STDOUT
    _(output.string).must_equal expected_output
  end
end

describe 'Grep command - process input - invert match' do
  before do
    @content = "This is a test line.\nAnother test line.\nYet another line."
    @pattern = 'test'
    @options = {
      ignore_case: false,
      invert_match: false
    }
  end

  it 'should print non-matching lines when invert match is true' do
    @options[:invert_match] = true
    expected_output = "Yet another line.\n"
    output = StringIO.new
    $stdout = output

    GrepTool.process_input(@content, @pattern, @options)

    $stdout = STDOUT
    _(output.string).must_equal expected_output
  end
end
