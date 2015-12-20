module JuggleFest
  def self.parse_file(filename)
    hash = {jugglers: {}, circuits: {}}
    File.open(filename) do |file|
      klass = Circuit
      symbol = :circuits
      r = true

      file.each_line do |line|
        next if line.empty?

        if r && line =~ /^J/
          klass = Juggler
          symbol = :jugglers
          r = false
        end

        item = klass.new hash, line
        hash[symbol][item.id] = item
      end
    end
    hash[:circuits]
  end

  module IDAble
    attr_accessor :id

    def initialize(line)
      line =~ /#{id_prefix}\d+/
      @id = $&
    end
  end

  # module Skillable
  #   attr_accessor :skills

  #   def initialize(line)
  #     super

  #     @skills = {}
  #     skill_regex_chunk = "([HEP]):(\d+)"
  #     get_skills = /(?:#{skill_regex_chunk}\s*?){3}/
  #     skill = /#{skill_regex_chunk}/

  #     line =~ get_skills
  #     $&.scan(skill) do
  #       skills[$1] = $2.to_i
  #     end
  #   end
  # end

  class Circuit
    include IDAble
    # include Skillable

    attr_accessor :jugglers

    def initialize(_, line)
      super(line)
      @jugglers = []
    end

    def id_prefix; "C"; end

    def juggler_sum
      jugglers.inject(0) do |sum, juggler|
        juggler.id =~ /J(\d+)/
        sum + $1.to_i
      end
    end
  end

  class Juggler
    include IDAble
    # include Skillable

    attr_accessor :circuits

    def initialize(hash, line)
      super(line)

      line =~ /(?:C\d+,?)+/
      @circuits = $&.split(/,/).map! {|id| hash[:circuits][id]}

      @circuits.each do |c|
        c.jugglers << self
      end
    end

    def id_prefix; "J"; end
  end

  def self.run(filename = ARGV[0])
    puts parse_file(filename)["C1970"].juggler_sum
  end
end

JuggleFest.run