module NotSoClever
  def self.parse_line(line)
    nums, n = line.split(/\s*\|\s*/)
    n = n.to_i
    nums = nums.split(/\s+/).map(&:to_i)
    [n, nums]
  end

  def self.stupid_iteration(ary)
    i = 0
    j = 1
    while j < ary.length
      if ary[j] < ary[i]
        ary[j], ary[i] = ary[i], ary[j]
        break
      end
      i += 1
      j += 1
    end
  end

  def self.get_stupid_array(line)
    n, ary = parse_line(line)
    n.times { stupid_iteration ary }
    ary.join(' ')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts get_stupid_array(line)
      end
    end
  end
end

NotSoClever.run if __FILE__ == $0