module SelfDescribingNumbers
  def self.self_describing?(n)
    digits = n.each_char.to_a.map(&:to_i)
    digits.each_with_index do |k, index|
      return false unless digits.count(index) == k
    end
    true
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts self_describing?(line) ? '1' : '0'
      end
    end
  end
end

SelfDescribingNumbers.run if __FILE__ == $0
