# https://www.codewars.com/kata/55bf01e5a717a0d57e0000ec/train/ruby

def persistence(n)
  count = 0
  while n.to_s.chars.length > 1
    n = n.to_s.chars.map {|c| c.to_i}.reduce(:*)
    count += 1
  end
  count
end