# frozen_string_literal: true

module HeadConfig
  HEAD_OPTION_DEFS = [
    {
      flags: ['-n', '--lines'],
      desc: 'Output the first NUM lines instead of the first 10',
      action: ->(opts, _) { opts[:lines] = true }
    },
    {
      flags: ['-c', '--bytes'],
      desc: 'Output the first NUM bytes of each file',
      action: ->(opts, _) { opts[:bytes] = true }
    },
    {
      flags: ['-q', '--quiet', '--silent'],
      desc: 'Never print headers giving file names',
      action: ->(opts, _) { opts[:quiet] = true }
    }
  ].freeze
end
