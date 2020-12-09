#!/usr/bin/ruby
require_relative 'day9_1.rb'

the_one = invalid_one(xmas = IO.readlines("input", chomp: true).map(&:to_i))

(0...xmas.length).each {|index|
    count, tail = 0, 0
    (0...xmas.length-index).each{ |offset|
        if (count += xmas[index + offset]) >= the_one
            tail = index + offset
            break
        end
    }
    if count == the_one
        puts xmas[index..tail].max + xmas[index..tail].min
        break
    end
}
