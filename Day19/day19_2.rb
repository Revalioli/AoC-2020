#!/usr/bin/ruby
def gen_regex hash, rule
    rule.delete!("\"")
    test = rule.gsub(/{?\d+}?/){ |num|
        if num[0] != "{"
            sub_regex = gen_regex(hash, hash[num])
            "(" + sub_regex + ")"
        else
            num
        end
    }.delete(" ")
end


rules, messages = IO.read("input").split("\n\n")
messages = messages.split("\n")

rules = Hash[rules.scan( /(\d+): (.+)/)]
# Let's rewrite with our "infinite" rules
# But meh let's just put a few * instead
rules["8"] << "+"

# Oskur le bruteforce
maximum = messages.map(&:length).max / 2

# rules["11"].gsub!(/\d+/) {|num| num + "+"}
original = rules["11"]

good_ones = []

1.upto(maximum).each { |count|
    rules["11"] = original.gsub(/\d+/) {|num| num + "{#{count}}"}

    regex = Regexp.new("^" + gen_regex(rules, rules["0"]) + "$")

    good_ones = good_ones | messages.filter{ |line|
        !!(line =~ regex)
    }
}

puts "\nThere are #{good_ones.length} matching messages"
