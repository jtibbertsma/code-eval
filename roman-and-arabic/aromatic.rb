module RomanAndArabic
  class RomanDigit
    DIGMAP = {
      "M" => 1000,
      "D" => 500,
      "C" => 100,
      "L" => 50,
      "X" => 10,
      "V" => 5,
      "I" => 1
    }

    include Comparable
    attr_reader :value

    def initialize(letter)
      @value = DIGMAP[letter]
    end

    def <=>(other)
      value <=> other.value
    end

    def *(str)
      value * str.to_i
    end
  end

  def self.decode_aromatic(line)
    prev_rom = nil
    prev_val = nil
    total = line.scan(/(\d)(\w)/).inject(0) do |memo, (dig, rom)|
      rom = RomanDigit.new rom
      if prev_rom
        if prev_rom < rom
          memo -= prev_val
        else
          memo += prev_val
        end
      end
      prev_rom = rom
      prev_val = rom * dig
      memo
    end
    total + prev_val
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts decode_aromatic(line)
      end
    end
  end
end

RomanAndArabic.run if __FILE__ == $0