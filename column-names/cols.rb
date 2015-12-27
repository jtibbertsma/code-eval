module ColumnNames
  def self.do_translation(n, desired_length)
    s = ''
    while n > 0
      s << ((n % 26) + 65).chr
      n /= 26
    end
    s << 'A' if s.length < desired_length
    s.reverse
  end

  def self.translate(n)
    n -= 1
    if n < 26
      do_translation(n, 1)
    elsif n < 703
      do_translation(n - 26, 2)
    else
      do_translation(n - 702, 3)
    end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts translate(line.to_i)
      end
    end
  end
end

ColumnNames.run if __FILE__ == $0