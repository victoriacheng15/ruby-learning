# frozen_string_literal: true

require_relative 'shared/cli_utils'
require_relative 'configs/head_config'

module HeadTool
  def self.parse_options(args)
    options = { lines: 10, bytes: nil, quiet: false }

    banner = 'Usage: head_tool.rb [options] [file]...'
    CLIUtils.parse_options(args, options, HEAD_OPTION_DEFS, banner: banner)
  end

  def self.msg_for_args(args)
    return unless args.empty?

    puts 'Error: No files provided.'
    puts 'Usage: ./bin/head [options] [file]...'
    exit 1
  end

  def self.process_file(content, options)
    if options[:bytes]
      puts content.byteslice(0, options[:bytes])
    else
      puts content.lines.first(options[:lines])
    end
  end

  def self.run_cli(argv)
    options = parse_options(argv)
    msg_for_args(argv)

    filenames = argv.empty? ? ['-'] : argv

    CLIUtils.each_input_file(filenames) do |content, _filename|
      process_file(content, options)
    end
  end
end
