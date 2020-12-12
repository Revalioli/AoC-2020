#!/usr/bin/ruby
rot, x, y = 0, 0, 0
dir = {0 => "E", 90 => "N", 180 => "W", 270 => "S"}
IO.readlines("input", chomp: true).each{ |instruct|
    op = instruct[0]
    val = instruct[1..].to_i

    op = dir[rot] if op == "F"

    case op
    when "E"
        x += val
    when "N"
        y += val
    when "W"
        x -= val
    when "S"
        y -= val
    when "L"
        rot = (rot + val)%360
    when "R"
        rot = (rot - val)%360
    end

    # p [x, y, rot]
}

puts x.abs+y.abs
