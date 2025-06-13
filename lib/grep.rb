# frozen_string_literal: true

require_relative 'shared/cli_utils'
require_relative 'configs/grep_config'

module GrepTool
  def self.parse_options(args)
    options = { ignore_case: false, invert_match: false }

    banner = 'Usage: ./bin/grep [options] pattern filename'
    CLIUtils.parse_options(args, options, GrepConfig::GREP_OPTION_DEFS, banner: banner)
  end

  def self.msg_for_args(args)
    return unless args.empty?

    puts 'Error: No input files or arguments provided.'
    puts 'Usage: ./bin/grep [options] pattern [file ...]'
    puts "Try './bin/grep --help' for more information."
    exit 1
  end

  def self.print_output(content, pattern, options)
    content.each_line do |line|
      matched = line.match?(pattern)

      if options[:invert_match]
        puts line unless matched
      elsif matched
        highlighted_line = line.gsub(pattern) do |match|
          "\e[31m#{match}\e[0m"
        end
        puts highlighted_line
      end
    end
  end

  def self.process_input(content, pattern, options)
    pattern = if options[:ignore_case]
                Regexp.new(pattern, Regexp::IGNORECASE)
              else
                Regexp.new(pattern)
              end

    print_output(content, pattern, options)
  end

  def self.run_cli(argv)
    options, args = parse_options(argv)
    msg_for_args(args)

    pattern = args[0]
    filenames = args[1..] || []

    CLIUtils.each_input_file(filenames) do |content, _filename|
      process_input(content, pattern, options)
    end
  end
end
