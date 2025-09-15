# source: https://www.codewars.com/kata/54da5a58ea159efa38000836/train/ruby

def find_it(seq)
  num_freq_count = {}
  oddball = nil
  
  seq.each do |num|
    if num_freq_count[num] == nil
      num_freq_count[num] = 1
    else
      num_freq_count[num] += 1
    end
    
    if num_freq_count[num].odd?
      oddball = num
    end
  end
  
  return oddball
end

puts find_it([20,1,-1,2,-2,3,3,5,5,1,2,4,20,4,-1,-2,5])
puts find_it([1,1,1,1,1,1,10,1,1,1,1])
puts find_it([10])