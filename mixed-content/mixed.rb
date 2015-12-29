module MixedContent
  def self.filter_words_and_numbers(line)
    words = []
    numbers = []
    line.split(/,/).each do |item|
      if item =~ /^\d+$/
        numbers << item
      else
        words << item
      end
    end
    return line if numbers.empty? || words.empty?
    [words.join(','), numbers.join(',')].join('|')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts filter_words_and_numbers(line)
      end
    end
  end
end

MixedContent.run if __FILE__ == $0