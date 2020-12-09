#!/usr/bin/ruby
def invalid_one xmas
    so_many_possibilities = xmas[0..24]

    xmas[25..].each { |num|
        continue = false
        so_many_possibilities.each { |i|
            so_many_possibilities.each { |j|
                if i+j == num
                    continue = true
                    break
                end
            }
            break if continue
        }
        return num if !continue
        so_many_possibilities.delete_at(0)
        so_many_possibilities << num
    }
end

if __FILE__ == $0
    xmas = IO.readlines("input", chomp: true).map(&:to_i)
    puts invalid_one xmas
end
