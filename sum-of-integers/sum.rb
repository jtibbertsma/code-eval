module SumOfIntegers
  def self.find_largest_sum(line)
    array = line.split(/,/).map!(&:to_i)

    max = array[0]
    0.upto(array.length-1).each do |i|
      (i+1).upto(array.length).each do |j|
        sum = array[i...j].inject(0, &:+)
        max = sum if sum > max
      end
    end

    max
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts find_largest_sum(line)
      end
    end
  end
end

SumOfIntegers.run if __FILE__ == $0
