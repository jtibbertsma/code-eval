module RealFake
  def self.real?(number)
    number.scan(/\d/).map!(&:to_i).each_with_index.inject(0) do |sum, (n, ind)|
      n *= 2 if ind % 2 == 0
      sum + n
    end % 10 == 0
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        next if line.empty?

        puts real?(line) ? "Real" : "Fake"
      end
    end
  end
end

RealFake.run