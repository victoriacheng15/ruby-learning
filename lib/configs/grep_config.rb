# frozen_string_literal: true

module GrepConfig
  GREP_OPTION_DEFS = [
    {
      flags: ['-i', '--ignore-case'],
      desc: 'Ignore case distinctions in patterns and data',
      action: ->(opts, _) { opts[:ignore_case] = true }
    },
    {
      flags: ['-v', '--invert-match'],
      desc: 'select non-matching lines',
      action: ->(opts, _) { opts[:invert_match] = true }
    }
  ].freeze
end
