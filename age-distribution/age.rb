module AgeDistribution
  def self.category(line)
    i = line.to_i
    if (0..2).include? i
      'Still in Mama\'s arms'
    elsif (3..4).include? i
      'Preschool Maniac'
    elsif (5..11).include? i
      'Elementary school'
    elsif (12..14).include? i
      'Middle school'
    elsif (15..18).include? i
      'High school'
    elsif (19..22).include? i
      'College'
    elsif (23..65).include? i
      'Working for the man'
    elsif (66..100).include? i
      'The Golden Years'
    else
      'This program is for humans'
    end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts category(line)
      end
    end
  end
end

AgeDistribution.run if __FILE__ == $0