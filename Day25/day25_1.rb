#!/usr/bin/ruby

public_card, public_door = IO.readlines("input", chomp: true).map(&:to_i)
loop_card, loop_door = 0, 0

start = 7

value = 1
until value == public_card
    loop_card += 1
    value *= start
    value = value % 20201227
end

puts "Loop size for card : #{loop_card}"

value = 1
until value == public_door
    loop_door += 1
    value *= start
    value = value % 20201227
end

puts "Loop size for door : #{loop_door}"

encrypt = 1
1.upto(loop_card).each { |i|
    encrypt *= public_door
    encrypt = encrypt % 20201227
}

puts "Encryption key : #{encrypt} (loop_card on public_door has been used)"
