module ArmstrongNumbers
  def self.armstrong?(n)
    digits = n.to_s.split('').map(&:to_i)
    n == digits.inject(0) do |total, digit|
      total + digit ** digits.length
    end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts armstrong?(line.to_i) ? 'True' : 'False'
      end
    end
  end
end

ArmstrongNumbers.run if __FILE__ == $0