class String
  def each_rotation
    str = self
    yield str
    (str.length-1).times do
      str = str[1,str.length] + str[0]
      yield str
    end
  end
end

module StringRotation
  def self.is_rotation_of?(line)
    s1, s2 = line.split(/,/)
    s1.each_rotation { |rot| return true if rot == s2 }
    false
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts is_rotation_of?(line) ? 'True' : 'False'
      end
    end
  end
end

StringRotation.run if __FILE__ == $0