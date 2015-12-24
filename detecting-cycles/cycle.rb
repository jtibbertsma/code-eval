module DetectingCycles
  class Animal
    attr_reader :index

    def initialize(nums)
      @nums = nums
    end

    def reset
      @index = 0
    end

    def !=(other)
      @nums[@index] != other[other.index]
    end

    def [](ind)
      @nums[ind]
    end

    def after(other)
      @index = other.index
      inc
    end

    def inc
      @index += @inc_rate
      @index %= @nums.length
    end

    def slow_down
      @inc_rate -= 1
    end

    def get_cycle(lam, mu)
      @nums[mu, lam]
    end
  end

  class Tortoise < Animal
    def initialize(nums)
      super
      @index = 1
      @inc_rate = 1
    end
  end

  class Hare < Animal
    def initialize(nums)
      super
      @index = 2
      @inc_rate = 2
    end
  end

  def self.move(tortoise, hare)
    while tortoise != hare
      tortoise.inc
      hare.inc

      yield if block_given?
    end
  end

  def self.floyds_algorithm(tortoise, hare)
    move(tortoise, hare)

    mu = 0
    tortoise.reset
    hare.slow_down
    move(tortoise, hare) { mu += 1 }

    lam = 1
    hare.after(tortoise)
    tortoise.slow_down
    move(tortoise, hare) { lam += 1 }

    tortoise.get_cycle(lam, mu)
  end

  def self.cycle_in(line)
    nums = line.split(/\s+/)
    tortoise = Tortoise.new(nums)
    hare = Hare.new(nums)
    cycle = floyds_algorithm(tortoise, hare)

    cycle.join(' ')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts cycle_in(line)
      end
    end
  end
end

DetectingCycles.run if __FILE__ == $0