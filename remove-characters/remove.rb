module RemoveCharacters
  def self.scrubbed_text(line)
    text, chars = line.split(/,\s*/)
    text.gsub(/[#{chars}]/, '')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts scrubbed_text(line)
      end
    end
  end
end

RemoveCharacters.run if __FILE__ == $0