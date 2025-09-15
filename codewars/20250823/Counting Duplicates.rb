#source: https://www.codewars.com/kata/54bf1c2cd5b56cc47f0007a1/train/ruby

require 'benchmark'

# --- Solutions ---

def duplicate_count_mine(text)
  text = text.downcase
  char_count = {}
  text.chars.each do |c|
    if char_count[c] == nil
      char_count[c] = 1
    else
      char_count[c] += 1
    end
  end
  dupes = 0
  char_count.each do |_, v|
    dupes += 1 if v > 1
  end
  dupes
end

def duplicate_count_best_practice(text)
  arr = text.downcase.split("")
  arr.uniq.count { |n| arr.count(n) > 1 }
end

def duplicate_count_next_best(text)
  hsh = Hash.new(0)
  text.downcase.chars.each { |c| hsh[c] += 1 }
  hsh.values.count { |k| k > 1 }
end

def duplicate_count_tally(text)
  text.downcase.chars.tally.count { |_, v| v > 1 }
end

def duplicate_count_clever(text)
  text.downcase.chars.group_by(&:to_s).count { |_, v| v.count > 1 }
end

# --- Benchmark setup ---

N = 50_000 # number of iterations per method
test_string = Array('a'..'z').join * 10 + Array('0'..'9').join * 5
# => a relatively long string with duplicates

Benchmark.bm(25) do |x|
  x.report("Mine")             { N.times { duplicate_count_mine(test_string) } }
  x.report("Best practice")    { N.times { duplicate_count_best_practice(test_string) } }
  x.report("Next best")        { N.times { duplicate_count_next_best(test_string) } }
  x.report("Tally")            { N.times { duplicate_count_tally(test_string) } }
  x.report("Clever")           { N.times { duplicate_count_clever(test_string) } }
end
