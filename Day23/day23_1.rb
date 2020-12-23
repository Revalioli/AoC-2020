#!/usr/bin/ruby
circle = IO.read("input").chomp.chars.map(&:to_i).map { |i| i-1}
current = circle[0]

modulo = circle.length

nb_turns = 100

(1..nb_turns).each { |t|
    # puts "New turn !"
    # puts "Before : #{circle}"
    # puts "Current : #{current}"
    # puts "Cups picked"
    picked = (1..3).map { |off| circle.delete_at((circle.index(current)+1) % circle.length) }
    # puts "Destination label
    dest_label = ((current-4..current-1).map{|num| num % modulo} - picked)[-1]

    circle.insert(circle.index(dest_label)+1, *picked)

    current = circle[(circle.index(current)+1) % modulo]
    # puts "After : #{circle}"
}

circle.map!{ |i| i+1}

circle.rotate! until circle[0] == 1

puts circle[1..].join
