module EvenNumbers
  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts line.to_i % 2 == 0 ? '1' : '0'
      end
    end
  end
end

EvenNumbers.run if __FILE__ == $0