#!/usr/bin/ruby
def gen_regex hash, rule
    rule.delete!("\"")
    rule.gsub(/\d+/){ |num|
        sub_regex = gen_regex(hash, hash[num])
        "(" + sub_regex + ")"
    }.delete(" ")
end

if __FILE__ == $0
    rules, messages = IO.read("input").split("\n\n")

    rules = Hash[rules.scan( /(\d+): (.+)/)]

    regex = Regexp.new("^" + gen_regex(rules, rules["0"]) + "$")

    res = messages.split("\n").sum { |line|
        if line =~ regex
            puts "#{line} matchs the regex :>"
            1
        else
            puts "#{line} does not match the regex >:("
            0
        end
    }

    puts "\nThere are #{res} matching messages"
end
