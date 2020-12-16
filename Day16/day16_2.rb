#!/usr/bin/ruby

# Parse the input
input = IO.read("input").split("\n\n")

rules = Hash[input[0].split("\n").map { |field|
    name = field.scan(/^[^:]+/)[0]
    ranges = field.scan(/(\d+)-(\d+)/).map{ |pair|
        pair[0].to_i..pair[1].to_i
    }
    [name, ranges]
}]

my_ticket = input[1].scan(/\d+/).map(&:to_i)

nearby_tickets = input[2].split("\n")[1..].map{ |ticket|
    ticket.scan(/\d+/).map(&:to_i)
}


valid_ones = nearby_tickets.filter{ |ticket|
    # Search for wrong tickets
    !ticket.find{ |num|
        !rules.values.flatten.find { |range| range === num }
    }
}

# The fun begins here

possibilities = Array.new(my_ticket.length) {rules.keys}
by_index = valid_ones.transpose


until possibilities.flatten.length <= my_ticket.length
    # For each field index
    by_index.each.with_index { |numbers, index|
        # For each possible fields
        possibilities[index].filter!{ |field|
            r1, r2 = rules[field]
            # For each number of this index
            # Keep if no wrong number was found
            # find searchs for wrong number
            res = !numbers.find{|num| !(r1 === num) && !(r2 === num)}
        }

        # If field was found, remove this possibility for the other index
        if (name = possibilities[index]).length == 1
            possibilities.each{ |p| p.delete(name[0]) if p != name }
        end
    }
end


puts "Translated ticket :"
(my_ticket = possibilities.flatten.zip(my_ticket)).each{ |pair| puts "#{pair[0]} : #{pair[1]}"}

puts my_ticket.reduce(1){ |tot, pair| (pair[0].match(/^departure/) ? pair[1] : 1) * tot}
