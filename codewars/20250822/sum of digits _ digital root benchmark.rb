# source: https://www.codewars.com/kata/541c8630095125aba6000c00/train/ruby

require 'benchmark'

RUNS = 10_000  # adjust this as needed

# ---------- Implementations ----------

def digital_root_supra(n)
  n_split = n.to_s.chars.map(&:to_i)
  recur_sum_array(n_split)
end

def recur_sum_array(arr)
  sum = 0
  arr.each { |n| sum += n }
  if sum.to_s.length > 1
    sum = recur_sum_array(sum.to_s.chars.map(&:to_i))
  end
  sum
end

def digital_root_tomajask(n)
  n < 10 ? n : digital_root_tomajask(n.digits.sum)
end

def digital_root_ovhaag(n)
  n < 10 ? n : digital_root_ovhaag(n / 10 + n % 10)
end

def digital_root_colbydauph(n)
  n < 10 ? n : digital_root_colbydauph(n.to_s.split(//).map(&:to_i).inject(:+))
end

def digital_root_user5205985(n)
  n < 1 ? 0 : (n - 1) % 9 + 1
end

def digital_root_ipmsteven(n)
  return n if n < 10
  digital_root_ipmsteven(n.to_s.chars.map(&:to_i).reduce(&:+))
end

def digital_root_wurde(n)
  n = n.to_s.chars.map(&:to_i).reduce(:+) while n.to_s.length > 1
  n
end

# ---------- Test cases ----------
FIXED_TESTS = [
  [16, 7],
  [942, 6],
  [132189, 6],
  [493193, 2],
  [195, 6],
  [992, 2],
  [999999999999, 9],
  [167346, 9],
  [10, 1],
  [0, 0]
]

def random_tests
  Array.new(100) do
    n = rand(0..10**(rand(1..20)))
    expected = n
    expected = expected.digits.sum until expected < 10
    [n, expected]
  end
end

TESTS = FIXED_TESTS + random_tests

# ---------- Benchmark ----------
impls = {
  "SupraSensum"   => method(:digital_root_supra),
  "tomajask"      => method(:digital_root_tomajask),
  "ovhaag"        => method(:digital_root_ovhaag),
  "colbydauph"    => method(:digital_root_colbydauph),
  "user5205985"   => method(:digital_root_user5205985),
  "ipmsteven"     => method(:digital_root_ipmsteven),
  "wurde"         => method(:digital_root_wurde),
}

Benchmark.bm(12) do |x|
  impls.each do |name, func|
    x.report(name) do
      RUNS.times do
        TESTS.each do |input, expected|
          raise "Fail #{name} on #{input}" unless func.call(input) == expected
        end
      end
    end
  end
end
