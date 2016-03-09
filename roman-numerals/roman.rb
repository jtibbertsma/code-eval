module RomanNumerals
  class Converter
    def initialize(line)
      @n = line.to_i
      @roman = ''
      convert!
    end

    def to_s
      @roman
    end

    private
      def convert!
        step('M', 1000)
        step('CM', 900)
        step('D',  500)
        step('CD', 400)
        step('C',  100)
        step('XC',  90)
        step('L',   50)
        step('XL',  40)
        step('X',   10)
        step('IX',   9)
        step('V',    5)
        step('IV',   4)
        step('I',    1)
      end

      def step(str, val)
        while @n >= val
          @roman << str
          @n -= val
        end
      end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts Converter.new(line)
      end
    end
  end
end

RomanNumerals.run if __FILE__ == $0