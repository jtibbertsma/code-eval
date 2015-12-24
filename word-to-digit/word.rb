module WordToDigit
  def self.digits_for(line)
    digits = line.split(/;/).map do |word|
      case word
      when 'zero'
        '0'
      when 'one'
        '1'
      when 'two'
        '2'
      when 'three'
        '3'
      when 'four'
        '4'
      when 'five'
        '5'
      when 'six'
        '6'
      when 'seven'
        '7'
      when 'eight'
        '8'
      when 'nine'
        '9'
      end
    end

    digits.join('')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts digits_for(line)
      end
    end
  end
end

WordToDigit.run if __FILE__ == $0