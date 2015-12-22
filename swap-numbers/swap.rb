module SwapNumbers
  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      text = file.read
      puts text.gsub(/\b(\d+)([a-z]+)(\d+)\b/i, '\3\2\1')
    end
  end
end

SwapNumbers.run if __FILE__ == $0