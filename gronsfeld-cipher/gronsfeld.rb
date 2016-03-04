module GronsfeldCipher
  class Decoder
    ALPHABET = " !\"#$%&'()*+,-./0123456789:<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

    attr_accessor :key, :data

    def initialize(key, data)
      @key = key
      @data = data
    end

    def decode
      enum = key_enum
      data.each_char.inject('') do |str, char|
        shift = enum.next
        str << next_char(char, shift)
      end
    end

    private
      def key_enum
        Enumerator.new do |y|
          index = 0
          loop do
            y << key[index].to_i
            index = 0 if (index += 1) == key.length
          end
        end
      end

      def next_char(char, shift)
        index = alpha_indices[char] - shift
        index = alphabet.length + index if index < 0
        alphabet[index]
      end

      def alpha_indices
        @alpha_indices ||= begin
          enum = alphabet.each_char.each_with_index
          enum.each_with_object({}) do |(char, index), hash|
            hash[char] = index
          end
        end
      end

    protected
      def alphabet
        ALPHABET
      end
  end

  def self.decode(line)
    key, data = line.split(/;/)
    Decoder.new(key, data).decode
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts decode(line)
      end
    end
  end
end

GronsfeldCipher.run if __FILE__ == $0