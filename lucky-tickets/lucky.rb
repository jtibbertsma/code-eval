module LuckyTickets
  def self.nums_upto_n_digits_with_sum(n, sum)
    
  end

  def self.sum_count(n)
    hi = 9 * n
    0.upto(hi).map do |i|
      nums_upto_n_digits_with_sum n, i
    end
  end

  def self.lucky_number(line)
    num_digits = line.to_i / 2
    sc = sum_count(num_digits)
    sc.inject(0) { |total, comb| total + comb*comb }
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