File.open(ARGV[0]).each_line do |line|
  next if line.empty?
  line.strip!

  string, pattern = line.split(',')
  pattern = Regexp.new(pattern.gsub(/(?<!\\)\*/, '.*'))
  puts pattern =~ string ? 'true' : 'false'
end