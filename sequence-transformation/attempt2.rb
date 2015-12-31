module SequenceTransformation
  def self.something(line)

  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts something(line)
      end
    end
  end
end

SequenceTransformation.run if __FILE__ == $0