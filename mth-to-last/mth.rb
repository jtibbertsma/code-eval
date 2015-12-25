module MthToLast
  def self.mth_to_last(line)
    items = line.split(/\s+/)
    m = items.pop.to_i
    items[-m]
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts mth_to_last(line)
      end
    end
  end
end

MthToLast.run if __FILE__ == $0