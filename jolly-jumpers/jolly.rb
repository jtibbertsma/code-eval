module JollyJumpers
  def self.find_differences(list)
    prev = nil
    list.inject([]) do |memo, num|
      memo << (prev - num).abs if prev
      prev = num
      memo
    end
  end

  def self.jolly?(line)
    n, *list = line.split(/\s+/).map(&:to_i)
    target = (1...n).to_a
    res = find_differences(list).sort
    target == res
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts jolly?(line) ? "Jolly" : "Not jolly"
      end
    end
  end
end

JollyJumpers.run if __FILE__ == $0