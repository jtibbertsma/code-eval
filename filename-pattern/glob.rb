module FilenamePattern
  def self.regexp_from(glob)
    glob.gsub! /\./, '\.'
    glob.gsub! /\*/, '.*'
    glob.gsub! /\?/, '.'

    /^#{glob}$/
  end

  def self.matching_files_from(line)
    files = line.split(/\s+/)
    pattern = regexp_from(files.shift)

    result = files.select { |file| file =~ pattern }.join(' ')
    result = '-' if result.empty?
    result
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts matching_files_from(line)
      end
    end
  end
end

FilenamePattern.run if __FILE__ == $0