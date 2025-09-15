require "benchmark"

# 1. Ternary inside .find
def find_outlier_ternary(integers)
  odd_count = 0
  integers.first(3).each { |num| odd_count += 1 if num.odd? }
  arr_is_odd = odd_count >= 2 ? true : false

  integers.find { |num| arr_is_odd ? num.even? : num.odd? }
end

# 2. If/else inside .find
def find_outlier_if(integers)
  odd_count = 0
  integers.first(3).each { |num| odd_count += 1 if num.odd? }
  arr_is_odd = odd_count >= 2

  integers.find do |num|
    if arr_is_odd
      num.even?
    else
      num.odd?
    end
  end
end

# 3. If around two separate .find calls
def find_outlier_split_find(integers)
  odd_count = 0
  integers.first(3).each { |num| odd_count += 1 if num.odd? }
  arr_is_odd = odd_count >= 2

  if arr_is_odd
    integers.find { |num| num.even? }
  else
    integers.find { |num| num.odd? }
  end
end

# ----------------------
# Test data
# ----------------------

# Large array: 999 even numbers + 1 odd outlier at the end
mostly_even = (1..999).map { |n| n * 2 } << 9999

# Large array: 999 odd numbers + 1 even outlier at the end
mostly_odd = (1..999).map { |n| n * 2 - 1 } << 2000

n = 50_000
Benchmark.bm do |x|
  x.report("ternary - odd outlier")     { n.times { find_outlier_ternary(mostly_even) } }
  x.report("if-in-find - odd outlier") { n.times { find_outlier_if(mostly_even) } }
  x.report("split-find - odd outlier") { n.times { find_outlier_split_find(mostly_even) } }

  x.report("ternary - even outlier")     { n.times { find_outlier_ternary(mostly_odd) } }
  x.report("if-in-find - even outlier") { n.times { find_outlier_if(mostly_odd) } }
  x.report("split-find - even outlier") { n.times { find_outlier_split_find(mostly_odd) } }
end
