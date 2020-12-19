#!/usr/bin/ruby
require_relative "day18_1.rb"

priorities = {"+" => 2, "-" => 2, "*" => 1, "/" => 1}

puts IO.readlines("input", chomp: true).sum{ |calc|
    postfix_computation(gen_postfix(calc, priorities))
}
