module MorseCode
  class MorseTree
    class Node
      attr_accessor :left, :right, :parent, :cipher

      def initialize(cipher, parent)
        @cipher = cipher
        @parent = parent

        @left = nil
        @right = nil
      end

      def translate(marks)
        return cipher if marks.empty?

        m = marks.shift
        m == '-' ? left.translate(marks) : right.translate(marks)
      end
    end

    def initialize
      @root = Node.new nil, nil
      curr = @root

      curr.left = Node.new 'T', curr
      curr.right = Node.new 'E', curr
      curr = curr.left

      curr.left = Node.new 'M', curr
      curr.right = Node.new 'N', curr
      curr = curr.left

      curr.left = Node.new 'O', curr
      curr.right = Node.new 'G', curr
      curr = curr.left

      curr.left = Node.new ',', curr
      curr.right = Node.new '.', curr
      curr = curr.left

      curr.left = Node.new '0', curr
      curr.right = Node.new '9', curr
      curr = curr.parent.right

      curr.right = Node.new '8', curr
      curr = curr.parent.parent.right

      curr.left = Node.new 'Q', curr
      curr.right = Node.new 'Z', curr
      curr = curr.right

      curr.right = Node.new '7', curr
      curr = curr.parent.parent.parent.right

      curr.left = Node.new 'K', curr
      curr.right = Node.new 'D', curr
      curr = curr.left

      curr.left = Node.new 'Y', curr
      curr.right = Node.new 'C', curr
      curr = curr.parent.right

      curr.left = Node.new 'X', curr
      curr.right = Node.new 'B', curr
      curr = curr.right

      curr.right = Node.new '6', curr
      curr = @root.right

      curr.left = Node.new 'A', curr
      curr.right = Node.new 'I', curr
      curr = curr.left

      curr.left = Node.new 'W', curr
      curr.right = Node.new 'R', curr
      curr = curr.left

      curr.left = Node.new 'J', curr
      curr.right = Node.new 'P', curr
      curr = curr.left

      curr.left = Node.new '1', curr
      curr = curr.parent.parent.right

      curr.right = Node.new 'L', curr
      curr = curr.parent.parent.right

      curr.left = Node.new 'U', curr
      curr.right = Node.new 'S', curr
      curr = curr.left

      curr.left = Node.new '-', curr
      curr.right = Node.new 'F', curr
      curr = curr.left

      curr.left = Node.new '2', curr
      curr = curr.parent.parent.right

      curr.left = Node.new 'V', curr
      curr.right = Node.new 'H', curr
      curr = curr.left

      curr.left = Node.new '3', curr
      curr = curr.parent.right

      curr.left = Node.new '4', curr
      curr.right = Node.new '5', curr
    end

    def translate(line)
      words = line.split(/\s{2}/)
      words.map! { |word| translate_word word }
      words.join(' ')
    end

    private
      def translate_word(word)
        letters = word.split(/\s/)
        letters.map! { |letter| @root.translate letter.split('') }
        letters.join('')
      end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      morse = MorseTree.new
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts morse.translate(line)
      end
    end
  end
end

MorseCode.run if __FILE__ == $0