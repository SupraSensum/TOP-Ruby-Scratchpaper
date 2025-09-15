# source: https://www.codewars.com/kata/541c8630095125aba6000c00/train/ruby

def digital_root(n)
  n_split = n.to_s.chars.map(&:to_i)
  
  recur_sum_array(n_split)
end

def recur_sum_array(arr)
  sum = 0
  
  arr.each do |n|
    sum += n
  end

  puts "#{arr.join} = #{sum}"
  
  if sum.to_s.length > 1
    sum = recur_sum_array(sum.to_s.chars.map(&:to_i))
  end
  
  puts "sub-result: #{sum}"

  sum
end

puts "RESULT: #{digital_root(16)}" # 7
puts "RESULT: #{digital_root(942)}" # 6
puts "RESULT: #{digital_root(132189)}" # 6
puts "RESULT: #{digital_root(493193)}" # 2
