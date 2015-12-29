module PenultimateWord
  def self.penultimate(line)
    line =~ /\b(\w+)\b\s+\w+$/
    $1
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts penultimate(line)
      end
    end
  end
end

PenultimateWord.run if __FILE__ == $0