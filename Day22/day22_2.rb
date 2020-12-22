#!/usr/bin/ruby

# $depth = 0
# $max = 0

# Return true if Player 1 won, false if Player 2 won
def game p1, p2
    # puts "Starting game at depth #{$depth}"
    # $depth += 1
    # if $depth > $max
    #     $max = $depth
    #     puts "Reached depth #{$max}"
    # end

    previously_on_day_22 = {}


    # Game loop

    until p1.length == 0 || p2.length == 0
        # puts "New turn"
        # p previously_on_day_22

        # Checking decks constitution
        if previously_on_day_22.key?([p1, p2])
            # $depth -= 1
            return true # Player 1 won, omedetou !
        end

        # If it is a new configuration, it is stored
        previously_on_day_22[[p1.clone, p2.clone]] = 0

        # Then the turn really starts here
        card1 = p1.pop
        card2 = p2.pop

        if p1.length >= card1 && p2.length >= card2
            # Oh shit, it's recursion time
            new_deck1 = p1[-card1..-1]
            new_deck2 = p2[-card2..-1]

            if game(new_deck1, new_deck2)
                # Player 1 won the sub_game
                p1.unshift(card2, card1)
            else
                # Player 2 won the sub-game
                p2.unshift(card1, card2)
            end

        elsif card1 > card2
            # Player 1 won the round
            p1.unshift(card2, card1)
        else
            # Player 2 won the round
            p2.unshift(card1, card2)
        end
    end

    # $depth -= 1

    return p1.length != 0

end


P1, P2 = IO.read("input").split("\n\n").map { |player|
    player.split("\n")[1..].map(&:to_i).reverse
}


if game(P1, P2)
    puts "Player 1 won !"
    puts P1.each_with_index.sum { |card, index| card*(index+1) }
else
    puts "Player 2 won !"
    puts P2.each_with_index.sum { |card, index| card*(index+1) }
end
