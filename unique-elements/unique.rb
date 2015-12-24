module UniqueElements
  def self.unique_elements(line)
    line.split(/,/).uniq.join(',')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts unique_elements(line)
      end
    end
  end
end

UniqueElements.run if __FILE__ == $0