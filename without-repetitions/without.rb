module WithoutRepetitions
  REGEX = begin
    regex_chunks = (32..125).map do |codepoint|
      char = codepoint.chr
      char.gsub!(/\[|\]|\^|\-|\\/) { |c| "\\" + c }
      "[#{char}]{2,}"
    end
    /#{regex_chunks.join('|')}/
  end

  def self.remove_repetitions(line)
    line.gsub(REGEX) { |s| s[0] }
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts remove_repetitions(line)
      end
    end
  end
end

WithoutRepetitions.run if __FILE__ == $0