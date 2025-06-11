# frozen_string_literal: true

HEAD_OPTION_DEFS = [
  {
    flags: ['-n', '--lines'],
    desc: 'Output the first NUM lines instead of the first 10',
    action: ->(opts, arg) { opts[:lines] = arg.to_i },
    arg_required: true
  },
  {
    flags: ['-c', '--bytes'],
    desc: 'Output the first NUM bytes instead of the first 10',
    action: ->(opts, arg) { opts[:bytes] = arg.to_i },
    arg_required: true
  },
  {
    flags: ['-q', '--quiet', '--silent'],
    desc: 'Never print headers giving file names',
    action: ->(opts, _) { opts[:quiet] = true }
  },
  {
    flags: ['--help'],
    desc: 'Display this help message',
    action: ->(_, _) { puts 'Usage: head [OPTION]... [FILE]...'; exit }
  }
].freeze