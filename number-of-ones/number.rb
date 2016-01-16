module NumberOfOnes
  def self.count_ones(line)
    n = line.to_i
    32.times.inject(0) do |memo, x|
      memo + ((n & (1 << x)) == 0 ? 0 : 1)
    end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts count_ones(line)
      end
    end
  end
end

NumberOfOnes.run if __FILE__ == $0