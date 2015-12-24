module LongestWord
  def self.longest_word_in(line)
    line.split(/\s+/).max_by {|word| word.length}
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts longest_word_in(line)
      end
    end
  end
end

LongestWord.run if __FILE__ == $0