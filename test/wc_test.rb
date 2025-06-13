# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'
require_relative '../lib/wc'

describe 'Wc Command - parse_options' do
  it 'parses -l option' do
    options, args = WcTool.parse_options(['-l', 'file.txt'])
    _(options[:lines]).must_equal true
    _(options[:words]).must_equal false
    _(options[:bytes]).must_equal false
    _(args).must_equal ['file.txt']
  end

  it 'parses -w option' do
    options, args = WcTool.parse_options(['-w', 'file.txt'])
    _(options[:lines]).must_equal false
    _(options[:words]).must_equal true
    _(options[:bytes]).must_equal false
    _(args).must_equal ['file.txt']
  end

  it 'parses -c option' do
    options, args = WcTool.parse_options(['-c', 'file.txt'])
    _(options[:lines]).must_equal false
    _(options[:words]).must_equal false
    _(options[:bytes]).must_equal true
    _(args).must_equal ['file.txt']
  end

  it 'defaults to false for all options' do
    options, args = WcTool.parse_options(['file.txt'])
    _(options[:lines]).must_equal false
    _(options[:words]).must_equal false
    _(options[:bytes]).must_equal false
    _(args).must_equal ['file.txt']
  end
end

describe 'Wc Command - run_cli' do
  let(:sample_text) { "foo bar\nbaz qux\n" }

  it 'counts lines with -l' do
    File.write('test.txt', sample_text)
    output = StringIO.new
    $stdout = output
    WcTool.run_cli(['-l', 'test.txt'])
    $stdout = STDOUT
    _(output.string.strip).must_equal '2 test.txt'
    File.delete('test.txt')
  end

  it 'counts words with -w' do
    File.write('test.txt', sample_text)
    output = StringIO.new
    $stdout = output
    WcTool.run_cli(['-w', 'test.txt'])
    $stdout = STDOUT
    _(output.string.strip).must_equal '4 test.txt'
    File.delete('test.txt')
  end

  it 'counts bytes with -c' do
    File.write('test.txt', sample_text)
    output = StringIO.new
    $stdout = output
    WcTool.run_cli(['-c', 'test.txt'])
    $stdout = STDOUT
    _(output.string.strip).must_equal "#{sample_text.bytesize} test.txt"
    File.delete('test.txt')
  end
end
