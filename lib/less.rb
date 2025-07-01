# frozen_string_literal: true

require_relative 'shared/cli_utils'
require_relative 'configs/less_config'
require 'io/console'

module LessTool
  def self.parse_options(args)
    options = { line_numbers: false }

    banner = 'Usage: ./bin/less [options] filename...'
    CLIUtils.parse_options(args, options, LessConfig::LESS_OPTION_DEFS, banner: banner)
  end

  def self.msg_for_args(args)
    return unless args.empty?

    puts 'Error: No input files or arguments provided.'
    puts 'Usage: ./bin/less [options] [file ...]'
    puts "Try './bin/less --help' for more information."
    exit 1
  end

  def self.run_cli(argv)
    options, args = parse_options(argv)
    msg_for_args(args)

    filenames = args

    CLIUtils.each_input_file(filenames) do |content, _filename|
      if options[:line_numbers]
        content.lines.each_with_index do |line, index|
          puts "\t#{index + 1}: #{line.chomp}"
        end
      else
        puts content
      end
    end
  end
end
