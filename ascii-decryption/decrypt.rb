module AsciiDecryption
  SPACE = 32

  def self.parse_line(line)
    _, __, codepoints = line.split(/\s*\|\s*/)
    codepoints.split(/\s+/).map!(&:to_i)
  end

  def self.decrypted(line)
    codepoints = parse_line(line)
    n = codepoints.min - SPACE

    codepoints.inject('') do |string, codepoint|
      string << (codepoint - n).chr
    end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts decrypted(line)
      end
    end
  end
end

AsciiDecryption.run if __FILE__ == $0