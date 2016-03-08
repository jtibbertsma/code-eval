module TextToNumber
  class Parser
    ACTIONS = {
      # Neg Value -> S
      1 => -> do |stack|
        -stack.pop
      end,

      # Value -> S
      2 => -> do |stack|
        stack.pop
      end,

      # 
    }

    def initializer(tokens)
      @tokens = tokens
      @state = 0
      @stack = []
    end

    def parse!
      
    end
  end

  def self.convert_to_num(line)
    tokens = Tokenizer.new line
    parser = Parser.new tokens
    parser.parse!
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts convert_to_num(line)
      end
    end
  end
end

TextToNumber.run if __FILE__ == $0