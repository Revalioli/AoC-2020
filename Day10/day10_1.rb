#!/usr/bin/ruby
puts ((adapts = IO.readlines("input", chomp: true).map(&:to_i).sort) << adapts.max+3).reduce([0,0,0]){|tab, jolt|[jolt - tab[2] == 1 ? tab[0]+1 : tab[0], jolt - tab[2] == 3 ? tab[1] + 1 : tab[1]] + [jolt]}[0..1].reduce(&:*)
