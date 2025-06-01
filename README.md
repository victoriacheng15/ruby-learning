# Ruby CLI Learning

This project is a simple Ruby command-line interface (CLI) tool collection to help me learn Ruby. It includes basic tools written from scratch in Ruby, similar to Unix commands like `cat`, `grep`, and `wc`.

## Tools Included

- `cat` - Reads and displays the content of a file.
- `grep` - Searches for a string in a file and prints matching lines.
- `wc` - Counts words, lines, and characters in a file.

These tools are located in the `bin/` folder.

## Sample Files

Sample text files are located in the `samples/` folder. You can use these files to test the CLI tools.

## How to Use

1. Clone the repository
   ```bash
   git clone https://github.com/your-username/ruby-cli-learning.git
   cd ruby-cli-learning

2. Make the scripts executable (if not already)
  ```bash
  chmod +x bin/*
  ```

3. Run a tool
  ```bash
  ./bin/cat samples/cat.txt
  ./bin/grep "search term" samples/grep.txt
  ./bin/wc samples/wc.txt
  ```

## Requirements

Ruby installed on your system (`ruby -v to check)

## Why this project?

I’m learning Ruby by building small command-line tools. This helps me understand:
- File I/O in Ruby
- String manipulation
- Working with arguments (ARGV)
- Writing executable scripts