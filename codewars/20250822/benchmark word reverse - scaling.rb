# source: https://www.codewars.com/kata/5264d2b162488dc400000001/solutions/ruby?filter=all&sort=best_practice&invalids=false
# Benchmarking spinWords implementations by string size

require 'benchmark'

# Implementations
def spin_words_v1(string)
  string.split(" ").each { |word| word.reverse! if word.length >= 5 }.join(" ")
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
    token.reverse! if token.size >= 5
    newTokens.push(token)
  end
  newTokens.join(' ')
end

IMPLEMENTATIONS = {
  "v1 (each+reverse!)" => method(:spin_words_v1),
  "v2 (gsub regex)"    => method(:spin_words_v2),
  "v3 (split/map)"     => method(:spin_words_v3),
  "v4 (manual loop)"   => method(:spin_words_v4)
}

# Test cases (increasing length)
TEST_STRINGS = [
  "Welcome",
  "Hey fellow warriors",
  "This is a test",
  "This is another test",
  "This sentence is a sentence",
  "You are almost to the last test",
  "Just kidding there is still one more",
  "Seriously this is the last one",
  Array.new(1000) { ('a'..'z').to_a.sample(rand(1..10)).join }.join(" ")
]

# Validate correctness first
expected = ->(s) { s.split.map { |x| x.length >= 5 ? x.reverse : x }.join(" ") }
IMPLEMENTATIONS.each do |name, impl|
  TEST_STRINGS.each do |s|
    raise "Mismatch in #{name} for '#{s}'" unless impl.call(s) == expected.call(s)
  end
end
puts "All implementations produce correct results ✅\n\n"

# Benchmarking
n = 100_000   # adjust as needed
overall_times = Hash.new(0)

TEST_STRINGS.each_with_index do |test_str, idx|
  puts "=== Round #{idx+1}: String length #{test_str.size}, words=#{test_str.split.size} ==="
  Benchmark.bm(20) do |x|
    IMPLEMENTATIONS.each do |name, impl|
      t = x.report(name) { n.times { impl.call(test_str) } }
      overall_times[name] += t.real
    end
  end
  puts
end

# Final summary
puts "=== Overall cumulative times ==="
overall_times.sort_by { |_, t| t }.each do |name, t|
  puts "#{name.ljust(20)}: #{t.round(4)} sec"
end
