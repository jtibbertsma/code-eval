module BeatOrBit
  def self.decode_binary(string)
    result = 0
    string.each_char.reverse_each.each_with_index do |c, i|
      result |= (1 << i) if c != '0'
    end
    result
  end

  def self.decode_gray(num)
    mask = num
    while (mask >>= 1) != 0
      num ^= mask
    end
    num
  end

  def self.decode(line)
    encoded_nums = line.split(/\s*\|\s*/).map! { |s| decode_binary s }
    encoded_nums.map! { |n| decode_gray n }
    encoded_nums.join(' | ')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts decode(line)
      end
    end
  end
end

BeatOrBit.run if __FILE__ == $0