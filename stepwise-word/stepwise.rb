module StepwiseWord
  def self.transform(string)
    mapped = string.each_char.each_with_index.map do |char, index|
      '*'*index + char
    end

    mapped.join(' ')
  end

  def self.stepwise(line)
    transform line.split(/\s+/).max_by { |s| s.length }
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts stepwise(line)
      end 
    end
  end
end

StepwiseWord.run if __FILE__ == $0