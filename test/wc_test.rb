# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'
require_relative '../lib/wc'

describe 'WC command - process_input' do
  it 'returns zero counts for empty input' do
    input = StringIO.new('')
    counts = process_input(input, 'empty_input')

    # _ is a shorthand for expect
    # could write like expect(counts[:lines]).must_equal 0
    _(counts[:lines]).must_equal 0
    _(counts[:words]).must_equal 0
    _(counts[:chars]).must_equal 0
    _(counts[:bytes]).must_equal 0
    _(counts[:filename]).must_equal 'empty_input'
  end

  it 'counts lines, words, and bytes correctly for a single line' do
    input = StringIO.new("hello world\n")
    counts = process_input(input, 'single_line')

    _(counts[:lines]).must_equal 1
    _(counts[:words]).must_equal 2
    _(counts[:chars]).must_equal 12
    _(counts[:bytes]).must_equal "hello world\n".bytesize
    _(counts[:filename]).must_equal 'single_line'
  end
end

describe 'WC command - process_input with stdin' do
  it 'handles input from stdin (simulated with StringIO)' do
    input = StringIO.new("one two three\nfour five\n")
    counts = process_input(input, '-')

    _(counts[:lines]).must_equal 2
    _(counts[:words]).must_equal 5
    _(counts[:chars]).must_equal 24
    _(counts[:bytes]).must_equal "one two three\nfour five\n".bytesize
    _(counts[:filename]).must_equal '-'
  end
end
