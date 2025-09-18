# https://www.codewars.com/kata/54da539698b8a2ad76000228/train/ruby

require 'pry-byebug'

# n -> y + 1
# s -> y - 1
# e -> x + 1
# w -> x - 1
# 
# also need to track time, which is just array length needs to equal 10

def is_valid_walk(walk)
  x = 0
  y = 0

  walk.each do |direction|
    case direction
      when 'n'
        x += 1
      when 's'
        x -= 1
      when 'e'
        y += 1
      when 'w'
        y -= 1
      else
        binding.pry
        puts "Some shit went down"
    end
  end

  puts x == 0 && y == 0 && walk.length == 10
end

is_valid_walk(['n','s','n','s','n','s','n','s','n','s'])
is_valid_walk(['w','e','w','e','w','e','w','e','w','e','w','e'])
is_valid_walk(['w'])
is_valid_walk(['n','n','n','s','n','s','n','s','n','s'])
