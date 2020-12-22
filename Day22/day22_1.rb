#!/usr/bin/ruby

P1, P2 = IO.read("input").split("\n\n").map { |player|
    player.split("\n")[1..].map(&:to_i).reverse
}

until P1.length == 0 || P2.length == 0
    # In one line
    # (card1 = P1.pop) > (card2 = P2.pop) ? P1.unshift(card2, card1) : P2.unshift(card1, card2)

    # In multiple lines

    card1 = P1.pop
    card2 = P2.pop

    if card1 > card2
        P1.unshift(card2, card1)
    else
        P2.unshift(card1, card2)
    end
end

puts [P1, P2].find{ |p| p.length != 0 }.each_with_index.sum { |card, index| card*(index+1) }
