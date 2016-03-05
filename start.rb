# This script helps me start a code eval ruby challenge. I keep typing
# the same boilerplate everytime, so I should just automate it. Generates
# a folder with files for code and input, and writes some boilerplate in
# the code file.

require 'fileutils'
require 'optparse'

module Start
  # command to open files in a text editor
  DEFAULT_EDITOR = 'subl'

  # Keeps track of name information, such as folder name, camelcase
  # module name, and file names.
  class Name
    attr_reader :dash

    DEFAULT_FUNCNAME = 'something'
    DEFAULT_TESTNAME = 'test.txt'

    def initialize(name, options)
      raise "Error: must supply challenge name" unless name && name !~ /^\-/
      @dash      = name
      @code_name = options[:code]
      @test_name = options[:test]
      @camel     = options[:modname]
      @func      = options[:func]
    end

    def camel
      @camel ||= camelize
    end

    def code
      @code ||= File.join(dash, "#{code_name}.rb")
    end

    def test
      @test ||= File.join(dash, "#{test_name}")
    end

    def func
      @func ||= DEFAULT_FUNCNAME
    end

    private
      def camelize
        dash.gsub(/\b\w/) { |s| s.upcase }
            .gsub(/\-/, '')
      end

      def code_name
        @code_name || dash.split(/\-/).first
      end

      def test_name
        @test_name || DEFAULT_TESTNAME
      end
  end

  # ruby boilerplate code
  def self.boilerplate(name)
<<-RUBY.strip
module #{name.camel}
  def self.#{name.func}(line)

  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts #{name.func}(line)
      end
    end
  end
end

#{name.camel}.run if __FILE__ == $0
RUBY
  end

  # Create a dir unless it exists.
  def self.create_dir(name)
    Dir.mkdir(name.dash) unless Dir.exist? name.dash
  end

  # Create the code and test files.
  def self.create_files(name)
    # test file
    FileUtils.touch name.test

    # code file
    FileUtils.touch name.code
    # only write to the file if it's empty
    if File::Stat.new(name.code).size == 0
      File.open(name.code, 'w') do |file|
        file.print boilerplate(name)
      end
    end
  end

  # Create a symlink in the new directory to the .pryrc in the main directory
  def self.create_pryrc_symlink(name)
    orig_rc = File.join File.expand_path('.'), '.pryrc'
    new_rc = File.join File.expand_path(name.dash), '.pryrc'
    File.symlink(orig_rc, new_rc) unless File.exist? new_rc
  end

  # Open new files in sublime
  def self.open_files_in_editor(name, editor)
    `#{editor} #{name.code} #{name.test}`
  end

  def self.command_line_options
    options = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: . start name-of-challenge [options]"
      opts.separator ''

      opts.on("-m", "--modname NAME", "Name of the module in the generated boilerplate") do |m|
        raise "Error: #{m} is not valid ruby constant" unless m =~ /^[A-Z]\w*$/
        options[:modname] = m
      end

      opts.on("-c", "--code NAME", "Name of the generated ruby file. Non-empty files are not overwritten.") do |c|
        options[:code] = c[/.*(?=\.rb$)|.*/]
      end

      opts.on("-t", "--test NAME", "Name of the test file. Defaults to test.txt") do |t|
        options[:test] = t
      end

      opts.on("-e", "--editor NAME", "Command to open files in a text editor") do |e|
        options[:editor] = e
      end

      opts.on("-f", "--func NAME", "Name of main function") do |f|
        options[:func] = f
      end

      opts.separator ''
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit 2
      end

      opts.parse!
    end
    options
  end

  def self.run(name = ARGV[0], options = {})
    options.merge!(command_line_options)
    options[:editor] ||= DEFAULT_EDITOR
    name = Name.new name, options

    create_dir name
    create_files name
    create_pryrc_symlink name
    open_files_in_editor name, options[:editor]
  rescue RuntimeError => e
    STDERR.puts e
    exit 1
  end
end

Start.run if __FILE__ == $0