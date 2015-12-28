module SplitTheNumber
  def self.parse_line(line)
    num, letters = line.split(/\s+/)
    letters =~ /(\w+)(\-|\+)(\w+)/
    op = $2.to_sym
    pattern = /(\d{#{$1.length}})(\d{#{$3.length}})/

    [num, pattern, op]
  end

  def self.eval_number_split(line)
    num, pattern, op = parse_line(line)
    num =~ pattern
    $1.to_i.send(op, $2.to_i)
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts eval_number_split(line)
      end
    end
  end
end

SplitTheNumber.run if __FILE__ == $0