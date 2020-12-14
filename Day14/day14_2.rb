#!/usr/bin/ruby

# Warning ! mask and int.digits are [LSb..MSb]
mask = []
memory = {}

IO.readlines("input", chomp: true).each{ |instruct|
    /^(.*) = (.*)$/ =~ instruct
    if $1 == "mask"
        mask = $2.chars.reverse
        # puts "mask = " + mask.to_s
    else
        val = $2.to_i

        address = (address = /mem\[(\d+)\]/.match($1)[1].to_i.digits(2)) + Array.new(36-address.length, 0)
        # puts "Before : " + address.to_s
        address = address.map.with_index{ |bit, index| mask[index] == "X" ? "X" : bit|mask[index].to_i }
        # puts "After :  " + address.to_s

        # p address
        # This block gives bit number in normal format [MSb..LSb] because Array.pop return element on the right (so pop return LSb)
        [0, 1].repeated_permutation(address.count("X")).each { |comb|
            # Reminder : temp_addr == [LSb..MSb]
            temp_addr = address.map{|bit| bit == "X" ? comb.pop : bit }.reverse.join.to_i(2)
            # p temp_addr
            memory[temp_addr] = val
        }
    end

}

puts memory.values.sum
