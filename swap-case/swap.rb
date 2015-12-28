module SwapCase
  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts line.swapcase!
      end
    end
  end
end

SwapCase.run if __FILE__ == $0