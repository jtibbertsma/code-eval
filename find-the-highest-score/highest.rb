module FindTheHighestScore
  def self.transposed(table)
    table[0].each_index.map do |i|
      row = []
      table.each { |r| row << r[i] }
      row
    end
  end

  def self.parse_table0(line)
    line.split(/\s+\|\s+/).map do |row|
      row.split(/\s+/).map(&:to_i)
    end
  end

  def self.parse_table(line)
    transposed parse_table0(line)
  end

  def self.highest(line)
    table = parse_table(line)
    table.map { |r| r.max }.join(' ')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts highest(line)
      end
    end
  end
end

FindTheHighestScore.run if __FILE__ == $0