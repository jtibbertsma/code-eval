module CalculateDistance
  def self.parse_line(line)
    line =~ /\((\-?\d+),\s+(\-?\d+)\)\s+\((\-?\d+),\s+(\-?\d+)\)/
    [$1.to_i, $2.to_i, $3.to_i, $4.to_i]
  end

  def self.distance(line)
    x1, y1, x2, y2 = parse_line(line)
    Math.sqrt((x2 - x1)**2 + (y2 - y1)**2).to_i
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts distance(line)
      end
    end
  end
end

CalculateDistance.run if __FILE__ == $0