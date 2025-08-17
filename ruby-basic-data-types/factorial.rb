numArr = [5, 6, 7, 8]
resArr = []

numArr.each do |num|
  facProd = 1

  num.downto(1) do |i|
    facProd *= i
  end
  
  resArr.push(facProd)
end

resArr.each do |num|
  puts num
end