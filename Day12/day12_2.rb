#!/usr/bin/ruby
waypoint = [10,1]
x, y = 0, 0

IO.readlines("input", chomp: true).each{ |instruct|
    op = instruct[0]
    val = instruct[1..].to_i

    case op
    when "E"
        waypoint[0] += val
    when "N"
        waypoint[1] += val
    when "W"
        waypoint[0] -= val
    when "S"
        waypoint[1] -= val
    when "L"
        1.upto(val/90){ |i|
            old_x, old_y = *waypoint
            waypoint[1] = old_x
            waypoint[0] = -old_y
        }
    when "R"
        1.upto(val/90){|i|
            old_x, old_y = *waypoint
            waypoint[0] = old_y
            waypoint[1] = -old_x
        }
    when "F"
        x += waypoint[0] * val
        y += waypoint[1] * val
    end
}

puts x.abs + y.abs
