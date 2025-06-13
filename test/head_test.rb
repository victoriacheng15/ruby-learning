# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'
require_relative '../lib/head'

describe 'Head command - parse options' do
  it 'should parse -n option' do
    args = ['-n5', 'test.txt']
    expanded_argv, number = HeadTool.process_args(args)
    options, _filenames = HeadTool.parse_options(expanded_argv)
    _(options[:lines]).must_equal true
    _(options[:bytes]).must_equal false
    _(options[:quiet]).must_equal false
    _(number).must_equal 5
    _(expanded_argv.last).must_equal 'test.txt'
  end

  it 'should parse -c option' do
    args = ['-c20', 'test.txt']
    expanded_argv, number = HeadTool.process_args(args)
    options, _filenames = HeadTool.parse_options(expanded_argv)
    _(options[:lines]).must_equal false
    _(options[:bytes]).must_equal true
    _(options[:quiet]).must_equal false
    _(number).must_equal 20
    _(expanded_argv.last).must_equal 'test.txt'
  end

  it 'should parse -q option' do
    args = ['-q', 'test.txt']
    expanded_argv, number = HeadTool.process_args(args)
    options, _filenames = HeadTool.parse_options(expanded_argv)
    _(options[:lines]).must_equal false
    _(options[:bytes]).must_equal false
    _(options[:quiet]).must_equal true
    _(number).must_be_nil
    _(expanded_argv.last).must_equal 'test.txt'
  end

  it 'should have all options false by default' do
    args = ['test.txt']
    expanded_argv, number = HeadTool.process_args(args)
    options, _filenames = HeadTool.parse_options(expanded_argv)
    _(options[:lines]).must_equal false
    _(options[:bytes]).must_equal false
    _(options[:quiet]).must_equal false
    _(number).must_be_nil
    _(expanded_argv.last).must_equal 'test.txt'
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
    HeadTool.run_cli(['-n5'])
    $stdin = STDIN
    $stdout = STDOUT
    _(output.string).must_equal @expected_output
  end

  it 'should print first N bytes from stdin' do
    input = StringIO.new(@content)
    output = StringIO.new
    $stdin = input
    $stdout = output
    HeadTool.run_cli(['-c12'])
    $stdin = STDIN
    $stdout = STDOUT
    _(output.string).must_equal @content.byteslice(0, 12)
  end
end
