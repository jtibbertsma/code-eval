module AlternativeReality
  COINS = [ 1, 5, 10, 25, 50 ]
  CACHE = Array.new(512)

  def self.count_coins(target, num_coins)
    return 0 if target < 0 || num_coins <= 0
    return 1 if target == 0

    cache_index = target*5 + num_coins
    return CACHE[cache_index] if CACHE[cache_index]

    result = count_coins(target, num_coins-1) +
             count_coins(target - COINS[num_coins-1], num_coins)
    CACHE[cache_index] = result

    result
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts count_coins(line.to_i, 5)
      end
    end
  end
end

AlternativeReality.run if __FILE__ == $0