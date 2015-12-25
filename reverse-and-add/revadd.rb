module ReverseAndAdd
  def self.reversed(n)
    n.to_s.reverse.to_i
  end

  def self.palindrome?(n)
    str = n.to_s
    i = 0
    j = str.length - 1
    while i < j
      return false if str[i] != str[j]
      i += 1
      j -= 1
    end
    true
  end

  def self.palindrome_distance(n)
    count = 0
    until palindrome? n
      count += 1
      k = reversed n
      n += k
    end
    "#{count} #{n}"
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts palindrome_distance(line.to_i)
      end
    end
  end
end

ReverseAndAdd.run if __FILE__ == $0