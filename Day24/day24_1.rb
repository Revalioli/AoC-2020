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

puts targets.uniq.filter { |tile|
    targets.count(tile) % 2 == 1
}.length
