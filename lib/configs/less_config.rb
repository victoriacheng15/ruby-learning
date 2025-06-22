# frozen_string_literal: true

module LessConfig
  LESS_OPTION_DEFS = [
    {
      flags: ['-n', '--LINE-NUMBERS'],
      desc: 'Display line numbers',
      action: ->(opts, _) { opts[:line_numbers] = true }
    },
    {
      flags: ['-s', '--chop-long-lines'],
      desc: 'Chop long lines rather than wrapping',
      action: ->(opts, _) { opts[:chop_long_lines] = true }
    },
    {
      flags: ['-f', '--quit-if-one-screen'],
      desc: 'Exit if the entire file fits on one screen',
      action: ->(opts, _) { opts[:quit_if_one_screen] = true }
    },
    {
      flags: ['-x', '--no-init'],
      desc: 'Do not clear the screen before exiting',
      action: ->(opts, _) { opts[:no_init] = true }
    }
  ].freeze
end
