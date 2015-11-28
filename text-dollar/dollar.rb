class Fixnum

  def in_words
    parts = to_s.reverse.scan(/(\d)(\d)?(\d)?/).reverse!
    len = parts.length

    words = []
    parts.each do |part|
      (words << convert_hundreds(*part)).flatten!
      words << BIG[len] if (len -= 1) > 0 && part.any? { |e| e && e > '0' }
    end

    words
  end

private

  ONES = %w{zero One Two Three Four Five Six Seven Eight Nine}

  TEENS = %w{Ten Eleven Twelve Thirteen Fourteen Fifteen Sixteen
            Seventeen Eighteen Nineteen}

  TENS = %w{zero Ten Twenty Thirty Forty Fifty Sixty Seventy Eighty Ninety}

  BIG = %w{zero Thousand Million Billion Trillion}

  def convert_hundreds(ones_place, tens_place, hundreds_place)
    words = []

    if hundreds_place
      i = hundreds_place.to_i
      if i > 0
        words << ONES[i] << 'Hundred'
      end
    end

    if tens_place
      i = tens_place.to_i
      if i == 1
        return words << TEENS[ones_place.to_i]
      elsif i == 0
      else
        words << TENS[i]
      end
    end

    i = ones_place.to_i
    if i > 0
      words << ONES[i]
    end
    words

  end
end

File.open(ARGV[0]).each_line do |line|
  next if line.empty?

  puts (line.to_i.in_words << 'Dollars').join('')
end