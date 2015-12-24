module SwapElements
  def self.parse_line(line)
    nums, swaps = line.split(/\s*:\s*/)
    nums = nums.split(/\s+/)
    swaps = swaps.split(/,\s*/).map do |item|
      item.split(/-/).map!(&:to_i)
    end

    [nums, swaps]
  end

  def self.swapped_elements(line)
    nums, swaps = parse_line(line)
    swaps.each do |(i, j)|
      nums[i], nums[j] = nums[j], nums[i]
    end
    nums.join(' ')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts swapped_elements(line)
      end
    end
  end
end

SwapElements.run if __FILE__ == $0