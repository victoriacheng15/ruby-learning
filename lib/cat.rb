# frozen_string_literal: true

require_relative 'shared/cli_utils'

module CatTool
  def self.parse_options(args)
    options = { number_lines: false, number_nonblank_lines: false }
    options_defs = [
      { flags: ['-n', '--number'], desc: 'Number all output lines', action: ->(opts, _) { opts[:number_lines] = true } },
      { flags: ['-b', '--number-nonblank'], desc: 'Number non-blank output lines', action: ->(opts, _) { opts[:number_nonblank_lines] = true } }
    ]
    CLIUtils.parse_options(args, options, options_defs, banner: 'Usage: cat_tool.rb [options] filename')
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

    if args.empty?
      content = $stdin.read
      process_input(content, options)
    else
      args.each do |filename|
        if File.exist?(filename)
          File.open(filename, 'r') do |file|
            content = file.read
            process_input(content, options)
          end
        else
          puts "File not found: #{filename}"
        end
      end
    end
  end
end
