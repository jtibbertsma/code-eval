module TrailingString
  def self.first_ends_with_second?(line)
    first, second = line.split(/,/)
    first.end_with?(second)
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts first_ends_with_second?(line) ? '1' : '0'
      end
    end
  end
end

TrailingString.run if __FILE__ == $0