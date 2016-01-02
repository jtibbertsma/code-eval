module TimeToEat
  def self.parse_time(t)
    t =~ /(\d+):(\d+):(\d+)/
    Time.new 1, 1, 1, $1.to_i, $2.to_i, $3.to_i
  end

  def self.sort_times(line)
    times = line.split(/\s+/).map { |t| parse_time t }
    times.sort.map { |t| t.to_s[/\d+:\d+:\d+/] }.reverse.join(' ')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts sort_times(line)
      end
    end
  end
end

TimeToEat.run if __FILE__ == $0