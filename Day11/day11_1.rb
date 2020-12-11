#!/usr/bin/ruby

#layout[line][column]
layout = IO.readlines("input", chomp: true).map{|i| i.split("")}
future = layout.map(&:clone)

loop{
    # puts "pof"
    layout.each.with_index {|line, i|
        line.each.with_index {|symb, j|
            next if symb == "."

            counter = 0
            left = [0, j-1].max
            if i-1 >= 0
                counter += layout[i-1][left..j+1].count("#")
            end
            counter += line[left..j+1].count("#")
            if i+1 < layout.length
                counter += layout[i+1][left..j+1].count("#")
            end

            # puts counter

            future[i][j] = '#' if counter == 0 && symb == "L"
            future[i][j] = 'L' if counter >= 5 && symb == "#"
        }
    }
    break if layout == future

    layout = future.map(&:clone)
}

layout.each {|i|
    print i
    puts
}

puts layout.reduce(0){|tot, line| tot+line.count("#")}
