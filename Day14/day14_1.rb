#!/usr/bin/ruby

# Warning ! mask and int.digits are [LSb..MSb]
mask = []
memory = {}
IO.readlines("input", chomp: true).each { |instruct|
    /^(.*) = (.*)$/ =~ instruct
    if $1 == "mask"
        mask = $2.chars.reverse
    else
        val = ($2.to_i.digits(2) + Array.new(36-$2.length, 0)).map.with_index {|d, index|
            mask[index] == "X" ? d : mask[index]24

        }.reverse.join.to_i(2)
        memory[/mem\[(\d+)\]/.match($1)[1]] = val
    end
}

puts memory.values.sum
