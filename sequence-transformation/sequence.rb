module SequenceTransformation
  # The ruby regexp engine runs into catastrophic backtracking issues
  # so we need to contruct our own DFA. The ideal language for this
  # is Go, which constructs an optimized DFA for its regexes at the
  # expense of a few pieces of regex syntax.
  #
  # A DFA allows us to always match strings in O(n) time, while a
  # backtracking style regex engine (ruby, python, perl) has
  # exponential worst case matching time.
  class DFA
    class State
      attr_reader :label
      attr_writer :accept

      def initialize(label)
        @accept = false
        @label = label
      end

      def [](c)
        edges[c]
      end

      def []=(c, state)
        edges[c] = state
      end

      def accept?
        @accept
      end

      protected
        def edges
          @edges ||= {}
        end
    end

    class NFAState < State
      protected
        def edges
          @edges ||= Hash.new { |hash, key| hash[key] = [] }
        end
    end

    class TransitionTable
      def initialize(states)
        @table = {}
        states.each do |state|
          h = {}
          ['A', 'B'].each do |l|
            label = state[l].map { |s| s.label }.sort.join(',')
            label = 'NULL' if label.empty?
            h[l] = label
          end
          h[:accept] = state.accept?
          @table[state.label] = h
        end
        @table['NULL'] = { 'A' => 'NULL', 'B' => 'NULL', :accept => false }
      end

      def transition(label, edge)
        primitives = label.split(/,/).inject([]) do |memo, l|
          memo += @table[l][edge].split(/,/)
        end
        primitives.uniq.sort.join(',')
      end

      def accept?(label)
        label.split(/,/).any? { |l| @table[l][:accept] }
      end
    end

    def initialize(sequence)
      states = construct_nfa sequence
      eliminate_nondeterminism states
    end

    private
      def construct_nfa(sequence)
        init = NFAState.new('0')
        states = [init]
        prev = [init]

        sequence.each_char do |char|
          prev = char == '0' ? trans0(states, prev) : trans1(states, prev)
          states += prev
        end

        prev.each { |state| state.accept = true }
        states
      end

      def trans0(states, prev)
        a = NFAState.new(states.length.to_s)
        a['A'] << a

        prev.each { |state| state['A'] << a }

        [a]
      end

      def trans1(states, prev)
        a = NFAState.new(states.length.to_s)
        b = NFAState.new((states.length + 1).to_s)
        a['A'] << a
        b['B'] << b

        prev.each do |state|
          state['A'] << a
          state['B'] << b
        end

        [a, b]
      end

      def eliminate_nondeterminism(states)
        table = TransitionTable.new states
        deterministic_states = {}

        queue = [states.first.label]
        until queue.empty?
          label = queue.shift
          next if deterministic_states.key? label

          state = State.new label
          state.accept = table.accept? label
          ['A', 'B'].each do |l|
            new_label = table.transition(label, l)
            state[l] = new_label
            queue << new_label
          end

          deterministic_states[label] = state
        end
        replace_labels_with_states deterministic_states

        @init = deterministic_states['0']
      end

      def replace_labels_with_states(states)
        states.each do |label, state|
          state['A'] = states[state['A']]
          state['B'] = states[state['B']]
        end
      end

    public
      def =~(string)
        state = @init
        string.each_char do |char|
          state = state[char]
        end
        state.accept?
      end
  end

  def self.transformable?(line)
    sequence, string = line.split(/\s+/)
    pattern = DFA.new sequence
    pattern =~ string
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts transformable?(line) ? 'Yes' : 'No'
      end 
    end
  end
end

SequenceTransformation.run if __FILE__ == $0