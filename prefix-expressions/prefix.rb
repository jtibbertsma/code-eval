module PrefixExpressions
  class NumberExpr
    attr_reader :eval

    def initialize(num)
      @eval = num.to_i
    end
  end

  class Operation
    def initialize(op, items)
      @op    = op.to_sym
      @left  = PrefixExpressions.create_expression(items)
      @right = PrefixExpressions.create_expression(items)
    end

    def eval
      @left.eval.send(@op, @right.eval)
    end
  end

  def self.create_expression(items)
    first = items.shift
    if first =~ /\d/
      NumberExpr.new first
    else
      Operation.new first, items
    end
  end

  def self.evaluate_expr(line)
    items = line.split(/\s+/)
    expr = create_expression(items)
    expr.eval
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts evaluate_expr(line)
      end
    end
  end
end

PrefixExpressions.run if __FILE__ == $0