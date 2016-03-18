module BalancedSmileys
  def self.analyze_colons(line)
    hash = Hash.new(0)
    line.each_char.each_with_index do |c, i|
      if c == ':'
        hash[:left]  += 1 if line[i-1] == '('
        hash[:right] += 1 if line[i+1] == ')'
      end
    end
    hash
  end

  def self.paren_balance(line)
    balance = 0
    line.each_char do |c|
      case c
      when '('
        balance -= 1
      when ')'
        balance += 1
      end
    end
    balance
  end

  def self.balanced?(line)
    if (balance = paren_balance(line)) == 0
      true
    else
      colons = analyze_colons line
      if balance > 0
        colons[:right] >= balance
      else
        balance *= -1
        colons[:left] >= balance
      end
    end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts balanced?(line) ? "YES" : "NO"
      end
    end
  end
end

BalancedSmileys.run if __FILE__ == $0