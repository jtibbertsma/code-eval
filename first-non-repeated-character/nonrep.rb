module FirstNonRepeatedCharacter
  class UniqueOrderedSet
    def initialize
      @index = 0
      @hash = {}
    end

    def <<(item)
      if @hash.include? item
        @hash[item] = nil
      else
        @hash[item] = @index
      end
      @index += 1
    end

    def first
      @hash.min_by { |_, v| v ? v : 10000000 }.first
    end
  end

  def self.first_nonrep(line)
    set = UniqueOrderedSet.new
    line.each_char { |c| set << c }
    set.first
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts first_nonrep(line)
      end
    end
  end
end

FirstNonRepeatedCharacter.run if __FILE__ == $0