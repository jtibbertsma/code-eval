module LettercasePercentageRatio
  FORMAT = "%.2f"

  def self.find_percentage(line)
    total = line.size
    lower = line.each_char.count { |c| ('a'..'z').include? c }.to_f
    upper = total - lower

    lower = (lower / total) * 100
    upper = (upper / total) * 100
    "lowercase: #{format(FORMAT, lower)} uppercase: #{format(FORMAT, upper)}"
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts find_percentage(line)
      end
    end
  end
end

LettercasePercentageRatio.run if __FILE__ == $0