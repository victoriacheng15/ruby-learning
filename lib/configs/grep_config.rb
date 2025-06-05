# frozen_string_literal: true

GREP_OPTION_DEFS = [
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
