module TrickOrTreat
  def self.get_number_of(thing, line)
    line =~ /#{thing}: (\d+)/
    $1.to_i
  end

  def self.candy_average(line)
    zombies  = get_number_of('Zombies',  line)
    vampires = get_number_of('Vampires', line)
    witches  = get_number_of('Witches',  line)
    houses   = get_number_of('Houses',   line)

    per_house = vampires*3 + zombies*4 + witches*5
    total_tricksters = vampires + zombies + witches

    (per_house * houses) / total_tricksters
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts candy_average(line).floor
      end
    end
  end
end

TrickOrTreat.run if __FILE__ == $0