# frozen_string_literal: true

require_relative 'shared/cli_utils'
require_relative 'configs/head_config'

module HeadTool
  def self.parse_options(args)
    options = { lines: false, bytes: false, quiet: false }

    banner = 'Usage: ./bin/head [options] filename...'
    CLIUtils.parse_options(args, options, HeadConfig::HEAD_OPTION_DEFS, banner: banner)
  end

  def self.msg_for_args(args)
    return unless args.empty?

    puts 'Error: No input files or arguments provided.'
    puts 'Usage: ./bin/head [options] [file ...]'
    puts "Try './bin/head --help' for more information."
    exit 1
  end

  def self.process_input(content, options, num)
    if options[:lines]
      puts content.lines.first(num).join
    elsif options[:bytes]
      print content.byteslice(0, num)
    else
      puts content.lines.first(10).join
    end
  end

  def self.process_args(argv)
    expanded_argv = []
    number = nil
    argv.each do |arg|
      if arg =~ /^-(n|c)(\d+)$/
        expanded_argv << "-#{::Regexp.last_match(1)}"
        number = ::Regexp.last_match(2).to_i
      else
        expanded_argv << arg
      end
    end
    [expanded_argv, number]
  end

  def self.run_cli(argv)
    expanded_argv, number = process_args(argv)
    options, filenames = parse_options(expanded_argv)

    CLIUtils.each_input_file(filenames) do |content, _filename|
      process_input(content, options, number)
    end
  end
end
