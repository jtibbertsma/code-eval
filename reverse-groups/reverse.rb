module ReverseGroups
  class Reverser
    def parse_line(line)
      list, n = line.split(/;/)
      @n = n.to_i
      list = list.split(/,/)
      list.each_slice(@n).to_a
    end

    def all_but_last(groups)
      last = groups.pop if groups.last.length < @n
      groups = yield groups
      groups << last if last

      groups
    end

    def reverse_it(line)
      reversed_groups = all_but_last(parse_line(line)) do |groups|
        groups.map { |g| g.reverse }
      end

      reversed_groups.flatten.join(',')
    end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts Reverser.new.reverse_it(line)
      end
    end
  end
end

ReverseGroups.run if __FILE__ == $0