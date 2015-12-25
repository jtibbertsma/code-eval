module MultiplicationTables
  def self.make_table
    (1..12).map do |i|
      (1..12).map do |j|
        i * j
      end
    end
  end

  def self.run
    table = make_table
    table.map! { |row| row.map {|item| format("%4d", item)}.join('').strip }
    table.each { |row| puts row }
  end
end

MultiplicationTables.run if __FILE__ == $0