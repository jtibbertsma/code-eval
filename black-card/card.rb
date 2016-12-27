module BlackCard
  def self.parse(line)
    parts = line.split(/\s*\|\s*/)
    names = parts[0].split(/\s/)
    elim_num = parts[1].to_i

    [names, elim_num]
  end

  def self.eliminate_name(names, elim_num)
    i = 0
    j = 1

    while j != elim_num
      i += 1
      i = 0 if i == names.length
      j += 1
    end

    names.delete_at(i)
  end

  def self.find_winner(line)
    names, elim_num = parse line
    while names.length > 1
      eliminate_name(names, elim_num)
    end
    names[0]
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts find_winner(line)
      end
    end
  end
end

BlackCard.run if __FILE__ == $0
