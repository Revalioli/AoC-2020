#!/usr/bin/ruby
def try_run prog
    p, acc = 0, 0
    loop do
        op, val = prog[p]
        case op
        when "omedetou"
            return true, acc
        when "end"
            return false, acc
        when "acc"
            acc += val
        end
        prog[p][0] = "end"
        op == "jmp" ? p += val : p += 1
    end

    [false, acc]
end

input = IO.readlines("input", chomp: true).map{|line| [(l = line.split)[0], l[1].to_i] } << ["omedetou", -1]

input.each_with_index{ |instruct, line|
    case instruct[0]
    when "nop"
        temp = input.map{|suba| Array.new(suba)}
        temp[line][0] = "jmp"
        success, result = try_run temp
        if success
            puts result
            break
        end
    when "jmp"
        temp = input.map{|suba| Array.new(suba)}
        temp[line][0] = "nop"
        success, result = try_run temp
        if success
            puts result
            break
        end
    end
}
