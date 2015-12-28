module JugglingWithZeros
  def self.translate_zeros(line)
    zeros = line.split(/\s+/)
    binary = ''

    while flag = zeros.shift
      case flag
      when '0'
        digit = '0'
      when '00'
        digit = '1'
      end

      zeros.shift.length.times { binary << digit }
    end
    binary.to_i 2
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts translate_zeros(line)
      end
    end
  end
end

JugglingWithZeros.run if __FILE__ == $0