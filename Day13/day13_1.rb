#!/usr/bin/ruby
start = (a = IO.readlines("input", chomp: true))[0].to_i
bus = a[1].split(",").filter{|c| c != "x"}.map(&:to_i).map{|id| [id, id-start%id] }
init = [bus.map{|suba| suba[0]}.max+1, bus.map{|suba| suba[1]}.max+1]

puts bus.reduce(init){|res, b|
    b[1] < res[1] ? b : res
}.reduce(&:*)
