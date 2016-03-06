module ChainInspection
  class Link
    attr_reader :goal

    def initialize(goal)
      @goal = goal
      @touched = false
    end

    def touch
      @touched = true
      self
    end

    def touched?
      @touched
    end
  end

  def self.generate_link_hash(line)
    hash = {}
    line.split(/;/).each do |range|
      range =~ /(\w+)\-(\w+)/
      hash[$1] = Link.new $2
    end
    hash
  end

  def self.passable_chain?(line)
    link_hash = generate_link_hash(line)
    n = link_hash.size
    link = link_hash["BEGIN"].touch
    while link.goal != "END"
      return false if (n -= 1) < 0
      link = link_hash[link.goal].touch
    end
    link_hash.all? { |_, link| link.touched? }
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts passable_chain?(line) ? "GOOD" : "BAD"
      end
    end
  end
end

ChainInspection.run if __FILE__ == $0