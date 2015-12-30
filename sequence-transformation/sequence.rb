class Array
  # [1, 1, 1, 2, 2, 1, 1, 2] -> [[1, 1, 1], [2, 2], [1, 1], [2]]
  def seperate
    new_array = []
    until empty?
      a = [shift]
      while first == a.first
        a << shift
      end
      new_array << a
    end

    new_array
  end
end

module SequenceTransformation
  # Try to prevent catastrophic backtracking
  def self.optimize(chunks)
    chunks = chunks.seperate
    chunks.map! do |items|
      if items.first == 'A+'
        "A{#{items.length},}"
      else
        "(?:A+|B+){#{items.length}}"
      end
    end
  end

  def self.regexp_from(sequence)
    chunks = sequence.each_char.map do |char|
      char == '0' ? 'A+' : '(?:A+|B+)'
    end
    chunks = optimize(chunks)

    /^#{chunks.join('')}$/
  end

  def self.transformable?(line)
    sequence, string = line.split(/\s+/)
    pattern = regexp_from(sequence)
    string =~ pattern
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts transformable?(line) ? 'Yes' : 'No'
      end 
    end
  end
end

SequenceTransformation.run if __FILE__ == $0