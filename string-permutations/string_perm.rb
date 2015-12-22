module StringPermutations
  def self.permutations_of(line)
    line.each_char.to_a.permutation.map { |a| a.inject(&:+) }.sort.join(',')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts permutations_of(line)
      end
    end
  end
end

StringPermutations.run if __FILE__ == $0