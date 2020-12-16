#!/usr/bin/ruby

# Parse the input
input = IO.read("input").split("\n\n")

rules = input[0].split("\n").map {|field|
    field.scan(/(\d+)-(\d+)/).map{|pair|
        pair[0].to_i..pair[1].to_i
    }
}.flatten

my_ticket = input[1].scan(/\d+/).map(&:to_i)

nearby_tickets = input[2].split("\n")[1..].map{ |ticket|
    ticket.scan(/\d+/).map(&:to_i)
}


puts nearby_tickets.sum{ |ticket|
    ticket.sum{ |num|
        rules.find { |range| range === num } ? 0 : num
    }
}
