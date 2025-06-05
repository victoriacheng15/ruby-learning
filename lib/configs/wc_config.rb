# frozen_string_literal: true

WC_OPTION_DEFS = [
  {
    flags: ['-l', '--lines'],
    desc: 'Print the newline counts',
    action: ->(opts, _) { opts[:lines] = true }
  },
  {
    flags: ['-w', '--words'],
    desc: 'Print the word counts',
    action: ->(opts, _) { opts[:words] = true }
  },
  {
    flags: ['-m', '--chars'],
    desc: 'Print the character counts',
    action: ->(opts, _) { opts[:chars] = true }
  },
  {
    flags: ['-c', '--bytes'],
    desc: 'Print the byte counts',
    action: ->(opts, _) { opts[:bytes] = true }
  }
].freeze
