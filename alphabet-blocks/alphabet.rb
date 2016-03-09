require 'set'

module AlphabetBlocks
  class BlockList
    def initialize(ary)
      @blocks = Set.new ary.map { |b| Set.new b.each_char.to_a }
    end

    def each_block(char)
      blocks = @blocks.select { |b| b.include? char }
      blocks.each do |b|
        @blocks.delete(b)
        yield
        @blocks << b
      end
    end
  end

  def self.spellable_recurse(goal, blocks)
    return true if goal == ''

    first = goal[0]
    goal = goal[1..-1]
    blocks.each_block(first) do
      return true if spellable_recurse(goal, blocks)
    end
    false
  end

  def self.parse_line(line)
    num, goal, blocks = line.split(/\s+\|\s+/)
    blocks = blocks.split(/\s+/)
    [goal, BlockList.new(blocks)]
  end

  def self.spellable?(line)
    goal, blocks = parse_line line
    spellable_recurse goal, blocks
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts spellable?(line) ? "True" : "False"
      end
    end
  end
end

AlphabetBlocks.run if __FILE__ == $0