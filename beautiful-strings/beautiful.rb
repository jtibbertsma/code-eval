module BeautifulStrings
  def self.count_letters(line)
    count = Hash.new(0)
    line.each_char { |c| count[c] += 1 }
    count
  end

  def self.get_scale(line)
    count = count_letters(line)
    val = 26
    ('a'..'z').to_a.sort_by { |l| -count[l] }.each_with_object({}) do |l, hash|
      hash[l] = val
      val -= 1
    end
  end

  def self.max_beauty(line)
    line.downcase!
    beauty_scale = get_scale(line)
    line.each_char.inject(0) do |sum, char|
      if char =~ /[a-z]/
        sum + beauty_scale[char]
      else
        sum
      end
    end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts max_beauty(line)
      end
    end
  end
end

BeautifulStrings.run if __FILE__ == $0