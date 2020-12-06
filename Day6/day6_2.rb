#!/usr/bin/ruby
puts IO.read("input").split("\n\n").map{ |group|
    group.split("\n").map{|sub| sub.chars}.reduce{|i, j| i & j}.count
}.sum
