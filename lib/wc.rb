# frozen_string_literal: true

require_relative 'shared/cli_utils'
require_relative 'configs/wc_config'

module WcTool
  def self.parse_options(argv)
    options = { lines: false, words: false, chars: false, bytes: false }
    banner = 'Usage: ./bin/cat [options] filename'
    CLIUtils.parse_options(argv, options, WcConfig::WC_OPTION_DEFS, banner: banner)
  end

  def self.msg_for_args(args)
    return unless args.empty?

    puts 'Error: No input files or arguments provided.'
    puts 'Usage: ./bin/cat [options] [file ...]'
    puts "Try './bin/cat --help' for more information."
    exit 1
  end

  def self.process_input(content, filename)
    text = content.respond_to?(:read) ? content.read : content
    text.force_encoding('BINARY')

    {
      lines: text.lines.count,
      words: text.split(/\s+/).count { |element| !element.empty? },
      chars: text.chars.count,
      bytes: text.bytesize,
      filename: filename
    }
  end

  def self.default_output(result)
    [result[:lines], result[:words], result[:bytes], result[:filename]]
  end

  def self.selective_output(result, options)
    [].tap do |out|
      out << result[:lines] if options[:lines]
      out << result[:words] if options[:words]
      out << result[:chars] if options[:chars]
      out << result[:bytes] if options[:bytes]
      out << result[:filename]
    end
  end

  def self.print_output(result, options)
    output = if options.values.none?
               default_output(result)
             else
               selective_output(
                 result, options
               )
             end
    puts output.join(options.values.none? ? "\t" : ' ')
  end

  def self.run_cli(argv)
    options, args = parse_options(argv)
    msg_for_args(args)

    CLIUtils.each_input_file(args) do |content, filename|
      result = process_input(content, filename)
      print_output(result, options)
    end
  end
end
