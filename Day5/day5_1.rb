#!/usr/bin/ruby

# puts IO.readlines("input", chomp: true).map{|seat|
#     seat[0,7].split("").map(&{"F" => "0", "B" => "1"}.to_proc).join.to_i(2) * 8 + seat[-3,3].split("").map(&{"L" => "0", "R" => "1"}.to_proc).join.to_i(2)
# }.max

puts IO.readlines("input", chomp: true).map{|seat|
    seat[0,7].tr("FB","01").to_i(2) * 8 + seat[-3,3].tr("LR","01").to_i(2)
}.max
