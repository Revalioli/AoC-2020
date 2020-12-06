#!/usr/bin/ruby
require 'set'
puts IO.read("input").split("\n\n").map{ |group|
    group.split("\n").reduce(Set[]){|s, p| s.merge(p.chars)}.count
}.sum
