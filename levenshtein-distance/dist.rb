require 'set'

Letters = 'abcdefghijklmnopqrstuvwxyz'

def one_distance_words(word)
  Enumerator.new do |y|
    # eliminate a character
    word.length.times do |i|
      y << (word.slice(0,i) << word.slice(i+1,word.length))
    end

    # change a character
    word.length.times do |i|
      mod = word.clone
      Letters.each_char do |c|
        mod[i] = c
        y << mod
      end
    end

    # add a character
    (word.length+1).times do |i|
      Letters.each_char do |c|
        mod = word.clone
        mod.insert(i, c)
        y << mod
      end
    end
  end
end

# read file
word_set = Set.new
test_cases = []

File.open(ARGV[0]) do |file|
  line = file.gets
  line.strip!

  while line != 'END OF INPUT'
    test_cases << line
    line = file.gets
    line.strip!
  end

  line = file.gets

  while line
    line.strip!
    word_set << line
    line = file.gets
  end
end

# check distances
test_cases.each do |ts|
  queue = []
  searched = Set.new
  queue << ts
  net_size = -1

  until queue.empty?
    net_size += 1
    word = queue.shift
    searched << word

    one_distance_words(word).each do |dw|
      queue << dw if word_set.include?(dw) && !searched.include?(dw)
    end
  end

  puts net_size
end