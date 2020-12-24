#!/usr/bin/ruby
targets = IO.readlines("input", chomp: true).map{ |path|
    pointer = 0
    x, y = 0, 0
    until pointer >= path.length
        case path[pointer]
        when "w"
            x -= 1
        when "e"
            x += 1
        when "s"
            pointer += 1
            case path[pointer]
            when "w"
                x -= 1
                y -= 1
            when "e"
                y -= 1
            end
        when "n"
            pointer += 1
            case path[pointer]
            when "w"
                y += 1
            when "e"
                x += 1
                y += 1
            end
        end
        pointer += 1
    end

    [x, y]
}

black_ones = targets.uniq.filter { |tile|
    targets.count(tile) % 2 == 1
}

# Part 2 begins here
# Yet another game of life, but with bestagons

black_ones = Hash[black_ones.map{ |tile| [tile, 1]}]

def get_neighbors x, y
    [[x-1, y] , [x, y+1] , [x+1, y+1] , [x+1, y] , [x, y-1] , [x-1,y-1]]
end


nb_turns = 100
turn = 0

until turn == nb_turns
    turn += 1

    to_check = []

    black_ones.keys.each { |tile|
        to_check.push(tile, *get_neighbors(*tile))
    }

    to_check.uniq!


    to_delete = []
    to_add = []

    to_check.each { |tile|
        neighbors = get_neighbors(*tile)

        # Really too slow
        # black_count = (neighbors & black_ones.keys).count

        black_count = neighbors.count { |t| black_ones[t] }


        if black_ones[tile]
            to_delete << tile unless (1..2) === black_count
        else
            to_add << tile if black_count == 2
        end
    }

    to_delete.each { |tile| black_ones.delete(tile) }
    to_add.each { |tile| black_ones[tile] = 1}

    puts "Turn n°#{turn} : #{black_ones.keys.count}"
end
