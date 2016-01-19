module EmailValidation
  def self.valid_email?(line)
    line =~ /\S+@\S+\.\S{2,4}/
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts valid_email?(line) ? 'true' : 'false'
      end
    end
  end
end

EmailValidation.run if __FILE__ == $0