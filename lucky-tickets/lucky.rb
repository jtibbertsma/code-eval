module LuckyTickets
  DIGIT_SUMS = Hash.new do |hash, num|
    
  end

  def self.sums_of_digits(n)
    hash = Hash.new { |hash, sum| hash[sum] = 0 }
    0.upto(('9' * n).to_i) { |i| hash[DIGIT_SUMS[i]] += 1 }
    hash.values
  end

  def self.lucky_number(line)
    num_digits = line.to_i / 2
    sum_count = sums_of_digits(num_digits)
    sum_count.inject(0) { |total, comb| total + comb*comb }
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts lucky_number(line)
      end
    end
  end
end

LuckyTickets.run if __FILE__ == $0