# frozen_string_literal: true

require_relative 'shared/cli_utils'
require_relative 'configs/less_config'

module LessTool
  def self.parse_options(args)
    options = { line_numbers: false, chop_long_lines: false, quit_if_one_screen: false, no_init: false }

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
    _, filenames = parse_options(argv)

    CLIUtils.each_input_file(filenames) do |content, _filename|
      puts content
      # Here you would implement the actual less functionality
      # For now, we just print the content
    end
  end
end
