require 'prime'

module PrimeNumbers
  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts Prime.each(line.to_i).to_a.join(',')
      end
    end
  end
end

PrimeNumbers.run if __FILE__ == $0