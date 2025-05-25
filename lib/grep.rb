# frozen_string_literal: true

require 'optparse'

module GrepTool
  def self.option_definition(options)
    OptionParser.new do |opts|
      opts.banner = 'Usage: grep_tool.rb [options] pattern filename'
      opts.on('-i', '--ignore-case', 'Ignore case distinctions') do
        options[:ignore_case] = true
      end
      opts.on('-v', '--invert-match', 'Invert the sense of matching') do
        options[:invert_match] = true
      end
    end
  end

  def self.parse_options(args)
    options = {
      ignore_case: false,
      invert_match: false
    }
    parser = option_definition(options)
    parser.parse!(args)
    [options, args]
  end

  def self.run_cli(argv)
    options, args = parse_options(argv)

    if args.size < 2
      puts 'Error: Missing pattern or filename.'
      puts 'Usage: grep_tool.rb [options] pattern filename'
      exit 1
    end

    pattern = args[0]
    filename = args[1]

    puts "Options: #{options.inspect}"
    puts "Pattern: #{pattern.inspect}"
    puts "Filename: #{filename.inspect}"
  end
end
