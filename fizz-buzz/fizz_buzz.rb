
def fizz_buzz(line)
  arr = line.split(' ')
  x = arr[0].to_i
  y = arr[1].to_i
  n = arr[2].to_i
  res = []

  (1..n).each do |i|
    s = ''
    s << 'F' if i % x == 0
    s << 'B' if i % y == 0
    if s.empty?
      res << i
    else
      res << s
    end
  end

  return res.join(' ')
end

File.open(ARGV[0]).each_line do |line|
  puts fizz_buzz(line) unless line.empty?
endr