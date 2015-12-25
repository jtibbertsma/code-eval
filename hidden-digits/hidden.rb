module HiddenDigits
  def self.hidden_digits_in(line)
    digits = line.each_char.select {|char| char =~ /[0-9a-j]/}.map! do |char|
      case char
      when /[0-9]/
        char
      else
        char.ord - 'a'.ord
      end
    end

    digits.empty? ? 'NONE' : digits.join('')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts hidden_digits_in(line)
      end
    end
  end
end

HiddenDigits.run if __FILE__ == $0