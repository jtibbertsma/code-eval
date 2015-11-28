class QueryBoard
  def initialize
    @matrix = []
    256.times do |i|
      a = []
      256.times do |j|
        a << 0
      end
      @matrix << a
    end
  end

  def setrow(i, x)
    256.times do |j|
      @matrix[i][j] = x
    end
  end

  def setcol(j, x)
    256.times do |i|
      @matrix[i][j] = x
    end
  end

  def queryrow(i)
    puts @matrix[i].inject(&:+)
  end

  def querycol(j)
    sum = 0
    256.times do |i|
      sum += @matrix[i][j]
    end
    puts sum
  end
end

board = QueryBoard.new
File.open(ARGV[0]).each_line do |line|
  next if line.empty?
  line.strip!

  method, *args = line.split(' ')
  args.map!(&:to_i)
  method = method.downcase.to_sym
  board.send(method, *args)
end