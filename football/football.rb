module Football
  def self.data_to_s(hash)
    hash.keys.sort.map do |key|
      values = hash[key].sort.uniq.join(',')
      "#{key}:#{values};"
    end
    .join(' ')
  end

  def self.parse_line(line)
    countries = line.split(/\s+\|\s+/)
    team_hash = Hash.new { |hash, country| hash[country] = [] }
    countries.each_with_index do |c, i|
      i = i + 1
      c.split(/\s+/).each { |team| team_hash[team] << i }
    end
    team_hash
  end

  def self.fan_lists(line)
    team_hash = parse_line(line)
    data_to_s team_hash
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts fan_lists(line)
      end
    end
  end
end

Football.run if __FILE__ == $0