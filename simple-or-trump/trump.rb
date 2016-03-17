module SimpleOrTrump
  class Card
    def self.compare(c1, c2, trump)
      case c1.compare(c2, trump)
      when -1
        [c2]
      when 1
        [c1]
      when 0
        [c1, c2]
      end
    end

    def self.value(value_string)
      if value_string == 'A'
        12
      elsif ['J', 'Q', 'K'].include? value_string
        11
      else
        value_string.to_i
      end
    end

    attr_reader :suit, :val, :str
    alias to_s str

    def initialize(str)
      @str = str
      str =~ /((?:[1-9]|10)|[AJKQ])([DHCS])/
      @val = Card.value($1)
      @suit = $2
    end

    def compare(other, trump)
      case compare_trump(other.suit, trump)
      when 0
        val <=> other.val
      when 1
        1
      when -1
        -1
      end
    end

    def compare_trump(other_suit, trump)
      if suit == other_suit || (suit != trump && other_suit != trump)
        0
      elsif suit == trump
        1
      else
        -1
      end
    end
  end

  def self.parse_line(line)
    cards, trump = line.split(/\s*\|\s*/)
    (cards.split(/\s+/).map { |c| Card.new(c) }) << trump
  end

  def self.trump_cards(line)
    card1, card2, trump_suit = parse_line(line)
    Card.compare(card1, card2, trump_suit).join(' ')
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts trump_cards(line)
      end
    end
  end
end

SimpleOrTrump.run if __FILE__ == $0