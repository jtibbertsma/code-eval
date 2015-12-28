module RollerCoaster
  def self.coster_case(line)
    down = true
    line.gsub!(/\w/) do |s|
      down = !down
      down ? s.downcase : s.upcase
    end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts coster_case(line)
      end
    end
  end
end

RollerCoaster.run if __FILE__ == $0