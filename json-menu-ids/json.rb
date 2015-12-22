require 'json'

module JsonMenuIds
  def self.get_id_sum(hash)
    sum = 0
    hash.each do |k, v|
      if Hash === v
        sum += get_id_sum(v)
      elsif k == "items"
        v.each do |item|
          next unless Hash === item
          sum += item["id"] if item["id"] && item["label"]
        end
      end
    end
    sum
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        hash = JSON.parse!(line)
        puts get_id_sum(hash)
      end
    end
  end
end

JsonMenuIds.run if __FILE__ == $0