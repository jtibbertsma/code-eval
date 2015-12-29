module StringMask
  def self.string_mask(line)
    string, mask = line.split(/\s+/)
    string.length.times do |i|
      string[i] = mask[i] == '1' ? string[i].upcase : string[i].downcase
    end
    string
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts string_mask(line)
      end
    end
  end
end

StringMask.run if __FILE__ == $0