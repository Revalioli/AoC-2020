#!/usr/bin/ruby

# For debug
def print_circle circ, first
    pointer = first
    res = []
    loop do
        res << pointer
        pointer = circ[pointer]
        break if pointer == first
    end

    p res
end


input = IO.read("input").chomp.chars.map(&:to_i)

# Part 1
# much_cups = input.map{ |cup| cup-1 }

# Part 2
much_cups = (input + (input.max+1..1000000).to_a).map{ |cup| cup - 1}

modulo = much_cups.max+1

# Hash{cup_label => next_cup_label}
# circle[cup_label] = next_cup_label
circle = Hash[much_cups.map.with_index {|cup, index| [cup, much_cups[(index+1) % much_cups.length]] }]
current = circle.keys[0]

nb_turns = 10000000

(1..nb_turns).each { |t|
    # Progress bar
    progress = t/100000.0
    print "\r#{progress.to_i} % " + "="*progress if progress%1==0

    pointer = current

    picked = (1..3).map { |off|
        pointer = circle[pointer]
    }

    # Searching destination label
    dest_label = ((current-4..current-1).map{|num| num % modulo} - picked)[-1]

    # Movings links
    first = dest_label
    last = circle[dest_label]

    circle[current] = circle[picked[-1]]
    circle[first] = picked[0]
    circle[picked[-1]] = last

    current = circle[current]
}

puts

# Part 1

# res = []
# pointer = circle[0]
# until pointer == 0
#     res << pointer+1
#     pointer = circle[pointer]
# end
#
# puts res.join

# Part 2

puts "The first #{circle[0]+1}"
puts "The second #{circle[circle[0]]+1}"

puts (circle[0]+1)*(circle[circle[0]]+1)
