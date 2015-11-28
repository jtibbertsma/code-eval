require 'set'

File.open(ARGV[0]).each_line do |line|
  next if line.empty?

  sets = line.split(';').map { |str| Set.new str.split(',') }
  puts (sets[0] & sets[1]).sort.join(',')
end