#!/usr/bin/ruby
# [first occurence, cycle, offset with next bus]
bus = IO.readlines("input", chomp: true)[1].split(",").map.with_index{|id, index| [id, index]}.filter{|sub| sub[0] != "x"}.map{|sub| [0, sub[0].to_i, sub[1]]}

result = bus.reverse.reduce{|actual, next_bus|
    offset = actual[2] - next_bus[2]

    cycle = actual[1]%next_bus[1] == 0 ? actual[1] : actual[1] * next_bus[1]
    offset_all = actual[2]

    first = actual[0]

    while (first-offset)%next_bus[1] != 0
        first += actual[1]
    end

    [first, cycle, offset_all]
}

puts result[0] - result[2]
