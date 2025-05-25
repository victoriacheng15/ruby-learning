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