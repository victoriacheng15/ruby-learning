# frozen_string_literal: true

require 'optparse'

module CLIUtils
  # options_config: array of hashes, each with :flags, :desc, and :action
  def self.build_option_parser(options, options_config, banner: nil)
    OptionParser.new do |opts|
      opts.banner = banner if banner
      options_config.each do |opt|
        opts.on(*opt[:flags], opt[:desc]) do |val|
          opt[:action].call(options, val)
        end
      end
      opts.on('-h', '--help', 'Display help message') do
        puts opts
        exit
      end
    end
  end

  def self.parse_options(argv, options, option_defs, banner: nil)
    parser = build_option_parser(options, option_defs, banner: banner)
    parser.parse!(argv)
    [options, argv]
  end

  def self.each_input_file(filenames)
    if filenames.nil? || filenames.empty?
      yield $stdin.read, nil
    else
      filenames.each do |filename|
        if File.exist?(filename)
          File.open(filename, 'r') do |file|
            yield file.read, filename
          end
        else
          warn "File not found: #{filename}"
          exit 1
        end
      end
    end
  end
end
