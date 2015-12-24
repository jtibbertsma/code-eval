module ReadMore
  def self.trimmed(line)
    if line.length <= 55
      line
    else
      line[0...39].strip << '... <Read More>'
    end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts trimmed(line)
      end
    end
  end
end

ReadMore.run if __FILE__ == $0