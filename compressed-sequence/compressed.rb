module CompressedSequence
  def self.count_sequence(ary)
    value = ary.shift
    count = 1
    while ary.first == value
      ary.shift
      count +=1
    end
    [count, value]
  end

  def self.get_counts(ary)
    res = []
    until ary.empty?
      res << count_sequence(ary)
    end
    res
  end

  def self.compress(line)
    sequence_counts = get_counts(line.split(/\s+/))
    sequence_counts.flatten.join(' ')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts compress(line)
      end
    end
  end
end

CompressedSequence.run if __FILE__ == $0