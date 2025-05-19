# frozen_string_literal: true

module CatTool
  def self.option_definition(options)
    OptionParser.new do |opts|
      opts.banner = 'Usage: cat_tool.rb [options] filename'
      opts.on('-n', '--number', 'Number all output lines') do
        options[:number_lines] = true
      end
      opts.on('-b', '--number-nonblank', 'Number non-blank output lines') do
        options[:number_nonblank_lines] = true
      end
      opts.on('-h', '--help', 'Display help message') do
        puts opts
        exit
      end
    end
  end

  def self.parse_options(args)
    options = {
      number_lines: false,
      number_nonblank_lines: false
    }
    parser = option_definition(options)
    parser.parse!(args)
    [options, args]
  end

  def self.process_input(content, filename)
    text = content.respond_to?(:read) ? content.read : content
    text.force_encoding('BINARY')

    puts "Processing file: #{filename}"
    puts text
  end

  def self.run_cli(argv)
    options, args = parse_options(argv)
    puts "Options: #{options.inspect}"
    puts "Arguments: #{args.inspect}"
  end
end

# To run CLI only if this file is executed directly
CatTool.run_cli(ARGV) if __FILE__ == $PROGRAM_NAME
