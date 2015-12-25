module ValidParentheses
  class ParenStack
    PARENS = {')' => '(', ']' => '[', '}' => '{'}

    def initialize
      @valid = true
      @stack = []
    end

    def <<(item)
      return unless @valid

      if PARENS.key? item
        if @stack[-1] == PARENS[item]
          @stack.pop
        else
          @valid = false
        end
      else
        @stack << item
      end
    end

    def valid?
      @valid && @stack.length == 0
    end
  end

  def self.valid_parentheses?(line)
    stack = ParenStack.new
    line.each_char do |char|
      stack << char
    end
    stack.valid?
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts valid_parentheses?(line) ? 'True' : 'False'
      end
    end
  end
end

ValidParentheses.run if __FILE__ == $0