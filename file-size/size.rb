module FileSize
  def self.run(filename = ARGV[0])
    puts File::Stat.new(filename).size
  end
end

FileSize.run if __FILE__ == $0