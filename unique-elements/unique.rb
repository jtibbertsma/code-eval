require 'set'

File.open(ARGV[0]).each_line do |line|
  next if line.empty?
  line.strip!

  puts Set.new(line.split(',')).sort.join(',')
end