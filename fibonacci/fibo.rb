module Fibonacci
  class Fibo
    def initialize
      @cache = Hash.new { |hash, n| hash[n] = caluculate_nth_fibo(n) }
    end

    def nth_fibo(n)
      @cache[n]
    end

    private
      def caluculate_nth_fibo(n)
        case n
        when 0
          0
        when 1
          1
        else
          nth_fibo(n-1) + nth_fibo(n-2)
        end
      end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      fibo_calculator = Fibo.new
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts fibo_calculator.nth_fibo(line.to_i)
      end
    end
  end
end

Fibonacci.run if __FILE__ == $0