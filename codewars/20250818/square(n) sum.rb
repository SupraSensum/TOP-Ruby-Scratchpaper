# https://www.codewars.com/kata/515e271a311df0350d00000f/train/ruby

def square_sum(numbers)
  numbers.map do |num|
    num ** 2
  end.sum
end

puts square_sum([1, 2, 3]) # should be 14