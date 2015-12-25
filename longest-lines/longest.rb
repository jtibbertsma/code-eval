module LongestLines
  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      num = file.readline.to_i
      lines = []

      file.each_line do |line|
        line.strip!
        next if line.empty?

        lines.push line
      end

      lines.sort! { |a, b| b.length <=> a.length }
      lines = lines[0...num]
      lines.each { |line| puts line }
    end
  end
end

LongestLines.run if __FILE__ == $0