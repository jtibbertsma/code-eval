module CapitalizeWords
  def self.capitalize(line)
    line.gsub!(/\b[a-z]/i) { |s| s.upcase }
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts capitalize(line)
      end
    end
  end
end

CapitalizeWords.run if __FILE__ == $0