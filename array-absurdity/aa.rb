require 'set'

module ArrayAbsurdity
  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        _, nums = line.split(/;/)
        nums = nums.split(/,/)
        
        s = Set.new
        nums.each do |n|
          if s.include? n
            puts n
            break
          end
          s << n
        end
      end
    end
  end
end

ArrayAbsurdity.run if __FILE__ == $0