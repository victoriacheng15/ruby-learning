# frozen_string_literal: true

module WcConfig
  WC_OPTION_DEFS = [
    {
      flags: ['-c', '--bytes'],
      desc: 'Print the byte counts',
      action: ->(opts, _) { opts[:bytes] = true }
    },
    {
      flags: ['-m', '--chars'],
      desc: 'Print the character counts',
      action: ->(opts, _) { opts[:chars] = true }
    },
    {
      flags: ['-l', '--lines'],
      desc: 'Print the newline counts',
      action: ->(opts, _) { opts[:lines] = true }
    },
    {
      flags: ['-w', '--words'],
      desc: 'Print the word counts',
      action: ->(opts, _) { opts[:words] = true }
    }
  ].freeze
end
