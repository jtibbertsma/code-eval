require 'prime'

module CountingPrimes
  def self.parse_line(line)
    a, b = line.split(/,/).map(&:to_i)
    (a..b)
  end

  def self.number_of_primes(line)
    parse_line(line).count { |n| Prime.prime? n }
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts number_of_primes(line)
      end
    end
  end
end

CountingPrimes.run if __FILE__ == $0