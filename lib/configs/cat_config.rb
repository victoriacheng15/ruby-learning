# frozen_string_literal: true

module CatConfig
  CAT_OPTION_DEFS = [
    {
      flags: ['-n', '--number'],
      desc: 'Number all output lines',
      action: ->(opts, _) { opts[:number_lines] = true }
    },
    {
      flags: ['-b', '--number-nonblank'],
      desc: 'Number non-blank output lines',
      action: ->(opts, _) { opts[:number_nonblank_lines] = true }
    }
  ].freeze
end
