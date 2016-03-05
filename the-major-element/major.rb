module TheMajorElement
  def self.major_element(line)
    count = Hash.new(0)
    items = line.split(/,/)
    items.each { |el| count[el] += 1 }
    m = count.max_by { |el| el[1] }
    k, v = m
    return k if v > items.count/2
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts major_element(line) || 'None'
      end
    end
  end
end

TheMajorElement.run if __FILE__ == $0