module FollowingInteger
  class Condition
    def initialize(str)
      @hash = freq(str)
    end

    def =~(num)
      data = freq(num.to_s)
      ('1'..'9').each do |k|
        return false if data[k] != @hash[k]
      end
      true
    end

    private
      def freq(str)
        hash = Hash.new(0)
        str.each_char { |c| hash[c] += 1 }
        hash
      end
  end

  def self.next_integer(line)
    n = line.to_i + 1
    condition = Condition.new line
    n += 1 until condition =~ n
    n
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts next_integer(line)
      end
    end
  end
end

FollowingInteger.run if __FILE__ == $0