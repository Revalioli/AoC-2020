#!/usr/bin/ruby
def game limit
    input = IO.read("input").scan(/\d+/).map(&:to_i)

    turn = 0
    memory = {}
    input[...-1].each{ |num| memory[num] = turn += 1 }
    turn += 1
    last_spoken = input[-1]

    # puts turn
    # puts memory
    # puts last_spoken

    until turn == limit
        turn += 1
        if memory.key?(last_spoken)
            val = turn - 1 - memory[last_spoken]
            memory[last_spoken] = turn-1
            last_spoken = val
        else
            memory[last_spoken] = turn-1
            last_spoken = 0
        end
    end

    return last_spoken
end

if __FILE__ == $0
    puts game 2020
end
