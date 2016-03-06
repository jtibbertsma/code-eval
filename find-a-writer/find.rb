module FindAWriter
  def self.parse_line(line)
    string, indices = line.split(/\s*\|\s*/)
    indices = indices.split(/\s+/).map!(&:to_i)
    [string, indices]
  end

  def self.find_writer(line)
    string, indices = parse_line(line)
    res = ''
    indices.each { |i| res << string[i-1] }
    res
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts find_writer(line)
      end
    end
  end
end

FindAWriter.run if __FILE__ == $0