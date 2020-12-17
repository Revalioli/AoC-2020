#!/usr/bin/ruby

# La part 2 met 2 min 20 à tourner, je vois pas où estt le problème c:

def get_neighbors x,y,z,w
    neighbors = []
    (x-1..x+1).each { |i|
        (y-1..y+1).each { |j|
            (z-1..z+1).each { |k|
                (w-1..w+1).each{ |l|
                    neighbors << [i,j,k,l] unless [i,j,k,l] == [x,y,z,w]
                }
            }
        }
    }
    neighbors
end


living_ones = []
turn = 0

IO.readlines("input", chomp: true).map(&:chars).each.with_index { |line, index|
    line.each.with_index { |cube, sub_index|
        living_ones << [index, sub_index, 0, 0] if cube == "#"
    }
}


until turn == 6

    puts "New turn"

    dead_to_check = []

    living_ones.each { |cube|
        get_neighbors(*cube).each { |c|
            dead_to_check << c unless living_ones.include?(c)
        }
    }

    dead_to_check.uniq!

    # Keep all cubes to be activated at the end of the turn
    dead_to_check.filter! { |dead|
        n = get_neighbors(*dead)
        # Which ones are active ? --> living_ones & n
        (living_ones & n).count == 3
    }

    # Keep all cubes which will stay active next turn
    to_keep = living_ones.filter { |alive|
        n = get_neighbors(*alive)
        (2..3) === (living_ones & n).count
    }

    living_ones = to_keep | dead_to_check

    turn += 1
end

puts living_ones.count
