module MultiplyLists
  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        next if line.empty?

        l1, l2 = line.split(/\s*\|\s*/)
        l1, l2 = List.new(l1), List.new(l2)
        puts l1 * l2
      end
    end
  end

  class List
    attr_reader :nums

    def initialize(text)
      @nums = text.split(/\s+/).map!(&:to_i) if String === text
      @nums = text                           if Array === text
    end

    def *(other)
      new_a = []
      nums.length.times {|i| new_a << nums[i] * other.nums[i]}
      List.new new_a
    end

    def to_s
      nums.join(' ')
    end
  end
end

MultiplyLists.run