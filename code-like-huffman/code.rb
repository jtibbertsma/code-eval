module CodeLikeHuffman
  class HuffmanTree
    class PriorityQueue
      def initialize(queue)
        @queue = queue
        @queue.sort!
      end

      def <<(node)
        @queue.each_with_index do |nd, i|
          if node < nd
            @queue.insert(i, node)
            return @queue
          end
        end
        @queue << node
      end

      def shift
        @queue.shift
      end

      def empty?
        @queue.empty?
      end
    end

    class AbstractNode
      attr_reader :value

      include Comparable

      def <=>(other)
        case value <=> other.value
        when 1
          1
        when 0
          eq_compare other
        when -1
          -1
        end
      end
    end

    class Sym < AbstractNode
      attr_reader :sym

      def initialize(char, value)
        @sym = char
        @value = value
      end

      def compile_codes(table, code)
        table[sym] = code
      end

      protected
        def eq_compare(other)
          sym <=> other.sym
        end
    end

    class Node < AbstractNode
      def initialize(lchild, rchild)
        @lchild = lchild
        @rchild = rchild
        @value = lchild.value + rchild.value
      end

      def compile_codes(table, partial_code)
        @lchild.compile_codes(table, partial_code + '0')
        @rchild.compile_codes(table, partial_code + '1')
      end

      def sym
        @lchild.sym
      end

      protected
        def eq_compare(other)
          case other.class
          when Sym
            -1
          else
            sym <=> other.sym
          end
        end
    end

    def initialize(str)
      frequencies = get_frequencies(str)
      @root = construct(frequencies)
    end

    def to_s
      code_table = {}
      @root.compile_codes(code_table, '')
      build_string(code_table)
    end

    private
      def get_frequencies(str)
        freq = Hash.new(0)
        str.each_char { |c| freq[c] += 1 }
        freq
      end

      def construct(frequencies)
        data = frequencies.map { |k, v| Sym.new(k, v) }
        queue = PriorityQueue.new data
        loop do
          c1 = queue.shift
          return c1 if queue.empty?
          c2 = queue.shift
          queue << Node.new(c1, c2)
        end
      end

      def build_string(table)
        codes = table.to_a.sort_by { |k, _| k }
        codes.map! { |k, code| "#{k}: #{code};" }.join(' ')
      end
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts HuffmanTree.new(line)
      end
    end
  end
end

CodeLikeHuffman.run if __FILE__ == $0