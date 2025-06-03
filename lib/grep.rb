# frozen_string_literal: true

require_relative 'shared/cli_utils'

module GrepTool
  OPTION_DEFS = [
    {
      flags: ['-i', '--ignore-case'],
      desc: 'Ignore case distinctions',
      action: ->(opts, _) { opts[:ignore_case] = true }
    },
    {
      flags: ['-v', '--invert-match'],
      desc: 'Invert the sense of matching',
      action: ->(opts, _) { opts[:invert_match] = true }
    }
  ].freeze

  def self.parse_options(args)
    options = { ignore_case: false, invert_match: false }

    banner = 'Usage: grep_tool.rb [options] pattern filename'
    CLIUtils.parse_options(args, options, OPTION_DEFS, banner: banner)
  end

  def self.msg_for_args(args)
    return unless args.empty?

    puts 'Error: No arguments provided.'
    puts 'Usage: ./bin/grep [options] pattern filename'
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
    filename = args[1]

    if File.exist?(filename)
      File.open(filename, 'r') do |file|
        content = file.read
        process_input(content, pattern, options)
      end
    else
      puts "Error: File '#{filename}' does not exist."
      exit 1
    end
  end
end
