#!/usr/bin/ruby

#layout[line][column]
layout = IO.readlines("input", chomp: true).map{|i| i.split("")}
future = layout.map(&:clone)

dir = [*-1..1].product([*-1..1]) - [[0,0]]

loop{
    # puts "pof"
    layout.each.with_index {|line, i|
        line.each.with_index {|symb, j|
            next if symb == "."

            counter = 0

            dir.each { |direction|
                sub_count = 1
                loop{
                    x = i + sub_count * direction[0]
                    y = j + sub_count * direction[1]

                    break unless (0...layout.length).include?(x) && (0...line.length).include?(y)

                    unless (seat = layout[x][y]) == "."
                        counter += 1 if seat == "#"
                        break
                    end

                    sub_count += 1
                }
            }

            future[i][j] = '#' if counter == 0 && symb == "L"
            future[i][j] = 'L' if counter >= 5 && symb == "#"
        }
    }
    break if layout == future

    layout = future.map(&:clone)
}

puts layout.reduce(0){|tot, line| tot+line.count("#")}
