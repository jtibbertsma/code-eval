module SimpleSorting
  def self.sorted(line)
    nums = line.split(/\s+/).map(&:to_f).sort
    nums.map {|num| format("%.3f", num)}.join(' ')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts sorted(line)
      end
    end
  end
end

SimpleSorting.run if __FILE__ == $0