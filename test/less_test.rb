# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'
require_relative '../lib/less'

describe 'Less command - parse options' do
  it 'should pase -N option' do
    args = ['-N', 'test.txt']
    expanded_argv, number = LessTool.process_args(args)
    options, _filenames = LessTool.parse_options(expanded_argv)
    _(options[:numbered]).must_equal true
    _(expanded_argv.last).must_equal 'test.txt'
  end

  it 'should parse -S option' do
    args = ['-S', 'test.txt']
    expanded_argv, number = LessTool.process_args(args)
    options, _filenames = LessTool.parse_options(expanded_argv)
    _(options[:chop_long_lines]).must_equal true
    _(expanded_argv.last).must_equal 'test.txt'
  end

  it 'should parse -F option' do
    args = ['-F', 'test.txt']
    expanded_argv, number = LessTool.process_args(args)
    options, _filenames = LessTool.parse_options(expanded_argv)
    _(options[:quit_if_one_screen]).must_equal true
    _(expanded_argv.last).must_equal 'test.txt'
  end

  it 'should parse -X option' do
    args = ['-X', 'test.txt']
    expanded_argv, number = LessTool.process_args(args)
    options, _filenames = LessTool.parse_options(expanded_argv)
    _(options[:no_init]).must_equal true
    _(expanded_argv.last).must_equal 'test.txt'
  end
end

describe 'Less command - run_cli' do
end
