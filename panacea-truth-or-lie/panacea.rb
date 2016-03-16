module Panacea
  def self.calc_sum(str, base)
    str.split(/\s+/).map { |n| n.to_i(base) }.inject(&:+)
  end

  def self.cured?(line)
    virus, anti = line.split(/\s*\|\s*/)
    virus = calc_sum(virus, 16)
    anti = calc_sum(anti, 2)
    anti >= virus
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts cured?(line) ? "True" : "False"
      end
    end
  end
end

Panacea.run if __FILE__ == $0