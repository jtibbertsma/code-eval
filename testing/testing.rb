module Testing
  def self.bug_count(line)
    s1, s2 = line.split(/\s*\|\s*/)
    s1.length.times.inject(0) do |sum, n|
      s1[n] == s2[n] ? sum : sum + 1
    end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        score = bug_count(line)

        puts case
        when score == 0
          'Done'
        when score <= 2
          'Low'
        when score <= 4
          'Medium'
        when score <= 6
          'High'
        else
          'Critical'
        end
      end
    end
  end
end

Testing.run