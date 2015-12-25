module StackImplementation
  class Stack
    def self.stackify(line)
      stack = new
      stack.stack = line.split(/\s+/)

      stack.pop until stack.empty?
      puts
    end

    attr_writer :stack

    def initialize
      @stack = nil
      @accept = true
    end

    def pop
      item = @stack.pop
      if @accept
        print item
        print ' ' unless empty?
      end
      @accept = !@accept
    end

    def empty?
      @stack.empty?
    end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      stack = Stack.new
      file.each_line do |line|
        line.strip!
        next if line.empty?

        Stack.stackify(line)
      end
    end
  end
end

StackImplementation.run if __FILE__ == $0
