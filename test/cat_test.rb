# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'
require_relative '../lib/cat'

describe "Cat Command - parse_options" do
  it 'parses -n correctly' do
    options, args = CatTool.parse_options(['-n', 'file.txt'])

    _(options[:number_lines]).must_equal(true)
    _(options[:number_nonblank_lines]).must_equal(false)
    _(args).must_equal ['file.txt']
  end
  
  it 'parses -b option correctly' do
    options, args = CatTool.parse_options(['-b', 'file.txt'])
    
    _(options[:number_lines]).must_equal(false)
    _(options[:number_nonblank_lines]).must_equal(true)
    _(args).must_equal ['file.txt']
  end
end
