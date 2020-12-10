#!/usr/bin/ruby
chain = [0] + (adapts =IO.readlines("input", chomp: true).map(&:to_i).sort) << adapts.max+3
paths = Array.new(chain.length, 0)
paths[0] = 1

chain.each.with_index {|jolt, index|
    pointer = index+1
    while pointer < chain.length && chain[pointer] - jolt <= 3
        paths[pointer] += paths[index]
        pointer += 1
    end
}

puts paths[-1]
