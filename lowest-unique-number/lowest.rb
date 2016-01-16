require 'set'

module LowestUniqueNumber
  def self.lowest_unique(line)
    seen = Set.new
    nums = line.split(/\s/).map(&:to_i)
    unique = Set.new nums

    nums.each do |n|
      if seen.include? n
        unique.delete n
      else
        seen << n
      end
    end
    (nums.index(unique.min) || -1) + 1
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts lowest_unique(line)
      end
    end
  end
end

LowestUniqueNumber.run if __FILE__ == $0