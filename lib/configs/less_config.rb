# frozen_string_literal: true

module LessConfig
  LESS_OPTION_DEFS = [
    {
      flags: ['-N', '--LINE-NUMBERS'],
      desc: 'Display line numbers',
      action: ->(opts, _) { opts[:line_numbers] = true }
    }
  ].freeze
end
