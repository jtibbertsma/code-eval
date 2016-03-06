module LowestCommonAncestor
  class Tree
    class NodeNotFoundError < RuntimeError; end;
    attr_reader :parent, :value, :level

    def initialize(ary, parent, level)
      @parent = parent
      @value = ary[0]
      @level = level
      @lchild = Tree.new(ary[1], self, level+1) if ary[1]
      @rchild = Tree.new(ary[2], self, level+1) if ary[2]
    end

    def +@
      ary = []
      node = self
      while node
        ary << [node.value, node.level]
        node = node.parent
      end
      ary
    end

    def find(val)
      case value <=> val
      when 1
        @lchild.find val
      when 0
        self
      when -1
        @rchild.find val
      end
    rescue NoMethodError
      # A child was nil and we called find on it
      raise NodeNotFoundError.new("Value not found: #{val}")
    end
  end

  TREE = Tree.new [30, [8, [3], [20, [10], [29]]], [52]], nil, 0

  def self.find_lowest(line)
    v1, v2 = line.split(/\s+/).map(&:to_i)
    (+TREE.find(v1) & +TREE.find(v2)).max_by { |_, level| level }.first
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts find_lowest(line)
      end
    end
  end
end

LowestCommonAncestor.run if __FILE__ == $0