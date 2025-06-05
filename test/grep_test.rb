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

describe 'Grep command - run_cli - ignore case' do
  before do
    @content = "This is a test line.\nAnother test line.\nYet another line."
    @pattern = 'test'
    @expected_output = <<~OUTPUT
      This is a \e[31mtest\e[0m line.
      Another \e[31mtest\e[0m line.
    OUTPUT
  end

  it 'should print matching lines from stdin' do
    input = StringIO.new(@content)
    output = StringIO.new
    $stdin = input
    $stdout = output

    GrepTool.run_cli([@pattern])

    $stdin = STDIN
    $stdout = STDOUT

    _(output.string).must_equal @expected_output
  end

  it 'should handle case insensitivity from stdin' do
    input = StringIO.new(@content)
    output = StringIO.new
    $stdin = input
    $stdout = output

    GrepTool.run_cli(['-i', 'TEST'])

    $stdin = STDIN
    $stdout = STDOUT

    _(output.string).must_equal @expected_output
  end
end

describe 'Grep command - run_cli - invert match' do
  before do
    @content = "This is a test line.\nAnother test line.\nYet another line."
    @pattern = 'test'
    @expected_output = "Yet another line.\n"
  end

  it 'should print non-matching lines from stdin when invert match is true' do
    input = StringIO.new(@content)
    output = StringIO.new
    $stdin = input
    $stdout = output

    GrepTool.run_cli(['-v', @pattern])

    $stdin = STDIN
    $stdout = STDOUT

    _(output.string).must_equal @expected_output
  end
end

describe 'Grep command - run_cli - file input' do
  before do
    @filename = 'test_grep_file.txt'
    @content = "apple\nbanana\nApple pie\n"
    File.write(@filename, @content)
  end

  after do
    File.delete(@filename) if File.exist?(@filename)
  end

  it 'prints matching lines from a file (case sensitive)' do
    output = StringIO.new
    $stdout = output

    GrepTool.run_cli(['apple', @filename])

    $stdout = STDOUT

    _(output.string).must_equal "\e[31mapple\e[0m\n"
  end

  it 'prints matching lines from a file (ignore case)' do
    output = StringIO.new
    $stdout = output

    GrepTool.run_cli(['-i', 'apple', @filename])

    $stdout = STDOUT

    _(output.string).must_equal "\e[31mapple\e[0m\n\e[31mApple\e[0m pie\n"
  end
end