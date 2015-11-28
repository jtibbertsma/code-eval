require 'set'

def next_happy(n)
  s = n.to_s
  s.each_char.map(&:to_i).inject(0) { |memo, i| memo + i*i }
end

def happy_enum(n)
  Enumerator.new do |y|
    loop do
      y << n
      n = next_happy(n)

      break if n == 1
    end
  end
end

File.open(ARGV[0]).each_line do |line|
  next if line.empty?
  line.strip!

  set = Set.new
  puts happy_enum(line.to_i).any? { |i| inc = set.include?(i); set << i; inc } ? '0' : '1'
end