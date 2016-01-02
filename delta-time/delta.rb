module DeltaTime
  def self.time_diff(start_time, end_time)
    seconds_diff = (start_time - end_time).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

  def self.parse_time(t)
    t =~ /(\d+):(\d+):(\d+)/
    Time.new 1, 1, 1, $1.to_i, $2.to_i, $3.to_i
  end

  def self.delta(line)
    t1, t2 = line.split(/\s+/).map { |t| parse_time t }
    time_diff(t1, t2)
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts delta(line)
      end
    end
  end
end

DeltaTime.run if __FILE__ == $0