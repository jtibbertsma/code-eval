module HexToDecimal
  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts line.to_i(16)
      end
    end
  end
end

HexToDecimal.run if __FILE__ == $0