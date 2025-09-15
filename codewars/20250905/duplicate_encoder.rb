require "benchmark"

# -----------------------------
# Implementations
# -----------------------------

def studentprogrammer(word)
  word
    .downcase
    .chars
    .map { |char| word.downcase.count(char) > 1 ? ')' : '(' }
    .join
end

def abeltje1(word)
  word.downcase.chars.map { |x| word.downcase.count(x) > 1 ? ")" : "(" }.join
end

def c0nspiracy(word)
  chars = word.downcase.chars
  count = chars.each_with_object(Hash.new(0)) { |char, h| h[char] += 1 }
  chars.map { |char| count[char] > 1 ? ")" : "(" }.join
end

def jiop(word)
  word = word.downcase # avoid mutating original
  word.chars.map { |c| word.count(c) == 1 ? "(" : ")" }.join
end

def mine(word)
  word = word.downcase # avoid mutating original
  char_tally = word.chars.tally
  word.chars.map { |c| char_tally[c] > 1 ? ")" : "(" }.join
end

# -----------------------------
# Benchmarking
# -----------------------------

input = "Success(( @ Recede Din SomethingLongerToStressTest"
n = 50000

Benchmark.bm(15) do |x|
  x.report("studentprogrammer") { n.times { studentprogrammer(input) } }
  x.report("abeltje1")          { n.times { abeltje1(input) } }
  x.report("c0nspiracy")        { n.times { c0nspiracy(input) } }
  x.report("jiop")              { n.times { jiop(input) } }
  x.report("mine")              { n.times { mine(input) } }
end
