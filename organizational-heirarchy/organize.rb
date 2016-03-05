module OrganizationalHeirarchy
  class Tree
    def initialize
      @top = []
      @people = Hash.new do |hash, key|
        @top << key
        hash[key] = []
      end
    end

    def <<(relation)
      a = relation[0]
      b = relation[1]

      @people[a] << b
      @people[b] = [] unless @people.key?(b)

      @top.delete(b)
      self
    end

    def to_s
      sort!
      stringify @top
    end

    private
      def sort!
        @top.sort!
        @people.each_value { |v| v.sort! }
      end

      def stringify(array)
        stringed_array = array.map do |person|
          subordinates = @people[person]
          unless subordinates.empty?
            "#{person} [#{stringify(subordinates)}]"
          else
            person
          end
        end
        stringed_array.join(', ')
      end
  end

  def self.calc_tree(line)
    tree = Tree.new
    line.split(/\s*\|\s*/).each do |relation|
      tree << relation
    end
    tree
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts calc_tree(line)
      end
    end
  end
end

OrganizationalHeirarchy.run if __FILE__ == $0