# frozen_string_literal: true

require_relative 'shared/cli_utils'
require_relative 'configs/cat_config'

module CatTool
  def self.parse_options(args)
    options = { number_lines: false, number_nonblank_lines: false }

    banner = 'Usage: ./bin/cat [options] filename'
    CLIUtils.parse_options(args, options, CatConfig::CAT_OPTION_DEFS, banner: banner)
  end

  def self.msg_for_args(args)
    return unless args.empty?

    puts 'Error: No input files or arguments provided.'
    puts 'Usage: ./bin/cat [options] [file ...]'
    puts "Try './bin/cat --help' for more information."
    exit 1
  end

  def self.print_output(content, options)
    if options[:number_lines]
      content.each_line.with_index(1) do |line, index|
        print "\t#{index} #{line}"
      end
    elsif options[:number_nonblank_lines]
      line_number = 1
      content.each_line do |line|
        if line.strip.empty?
          print line
        else
          print "\t#{line_number} #{line}"
          line_number += 1
        end
      end
    else
      print content
    end
  end

  def self.process_input(content, options)
    text = content.respond_to?(:read) ? content.read : content
    text.force_encoding('BINARY')

    print_output(text, options)
  end

  def self.run_cli(argv)
    options, args = parse_options(argv)
    msg_for_args(args)

    CLIUtils.each_input_file(args) do |content, _filename|
      process_input(content, options)
    end
  end
end
