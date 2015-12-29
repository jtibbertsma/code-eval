module SlangFlavor
  class Flavor
    ADD_ONS = [
      ', yeah!',
      ', this is crazy, I tell ya.',
      ', can U believe this?',
      ', eh?',
      ', aw yea.',
      ', yo.',
      '? No way!',
      '. Awesome!'
    ]

    def initialize
      @index = 0
    end

    def next_flavor
      item = ADD_ONS[@index]
      @index += 1
      @index = 0 if @index == ADD_ONS.length
      item
    end

    def add(text)
      append = true
      text.gsub!(/[.!?]/) do |s|
        append = !append
        append ? next_flavor : s
      end
    end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      flavor = Flavor.new
      text = file.read
      puts flavor.add(text)
    end
  end
end

SlangFlavor.run if __FILE__ == $0