#!/usr/bin/ruby
prog = IO.readlines("input", chomp: true).map{|line| [(l = line.split)[0], l[1].to_i] }
p, acc = 0, 0
loop do
    op, val = prog[p]
    case op
    when "end"
        break acc
    when "acc"
        acc += val
    end
    prog[p][0] = "end"
    op == "jmp" ? p += val : p += 1
end

puts acc
