#!/usr/bin/ruby
def search h, suitcase
    content = h[suitcase]
    return true if content.include?("shiny gold")
    if content.compact.count == 0
        return false
    else
        return h[suitcase].map{ |s| search(h,s) }.count(true) > 0
    end
end

h = Hash[IO.readlines("input", chomp: true).map{|line|
    parent, children = line.split " bags contain "
    children = children.split(/,|\./).map{|c| /\d (.*) bag/.match(c) ? $1 : nil}

    [parent, children]

}]

puts h.filter{|k,v|
    search(h, k)
}.count
