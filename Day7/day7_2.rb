#!/usr/bin/ruby
h = Hash[IO.readlines("input", chomp: true).map{|line|
    parent, children = line.split " bags contain "
    children = children.scan(/(\d) ([^,.]*) bag/).map{|sub| [sub[0].to_i, sub[1]]}

    [parent, children]

}]

def you_activated_tsa_agent_s_trap_card_! h, suitcase
    content = h[suitcase]
    count = content.map{|n| n[0] + n[0]*you_activated_tsa_agent_s_trap_card_!(h, n[1])}.sum
end

puts you_activated_tsa_agent_s_trap_card_!(h, "shiny gold")
