# source: https://www.codewars.com/kata/5264d2b162488dc400000001/solutions/ruby?filter=all&sort=best_practice&invalids=false

require 'benchmark'

# Implementations
def spin_words_v1(string)
  string.split(" ").each do |word|
    word.reverse! if word.length >= 5
  end.join(" ")
end

def spin_words_v2(string)
  string.gsub(/\w{5,}/, &:reverse)
end

def spin_words_v3(string)
  string.split.map { |s| s.length >= 5 ? s.reverse : s }.join(' ')
end

def spin_words_v4(string)
  tokens = string.split(' ')
  newTokens = []
  tokens.each do |token|
    if token.size >= 5
      token.reverse!
    end
    newTokens.push(token)
  end
  newTokens.join(' ')
end

# Test cases
TEST_STRINGS = [
  "Welcome",
  "Hey fellow warriors",
  "This is a test",
  "This is another test",
  "This sentence is a sentence",
  "You are almost to the last test",
  "Just kidding there is still one more",
  "Seriously this is the last one",
  # large random-ish string for stress testing
  Array.new(1000) { ('a'..'z').to_a.sample(rand(1..10)).join }.join(" ")
]

# Validate correctness before benchmarking
expected = lambda { |s| s.split.map { |x| x.length >= 5 ? x.reverse : x }.join(" ") }

[method(:spin_words_v1), method(:spin_words_v2), method(:spin_words_v3), method(:spin_words_v4)].each_with_index do |impl, i|
  TEST_STRINGS.each do |s|
    raise "Mismatch in v#{i+1} for '#{s}'" unless impl.call(s) == expected.call(s)
  end
end

puts "All implementations produce correct results ✅"
puts

# Benchmark
n = 500_000
Benchmark.bm do |x|
  x.report("v1 (each + reverse!)") {
    n.times { TEST_STRINGS.each { |s| spin_words_v1(s) } }
  }
  x.report("v2 (gsub regex)") {
    n.times { TEST_STRINGS.each { |s| spin_words_v2(s) } }
  }
  x.report("v3 (split/map)") {
    n.times { TEST_STRINGS.each { |s| spin_words_v3(s) } }
  }
  x.report("v4 (manual loop)") {
    n.times { TEST_STRINGS.each { |s| spin_words_v4(s) } }
  }
end
