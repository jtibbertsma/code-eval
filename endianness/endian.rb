module Endianness
  def self.run(filename = ARGV[0])
    puts "LittleEndian"
  end
end

Endianness.run if __FILE__ == $0