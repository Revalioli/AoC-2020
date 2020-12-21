#!/usr/bin/ruby

class Piece

    attr_accessor :sides, :content, :matchs
    attr_reader :parent_id

    def initialize(content, parent_id)
        @content = content.map(&:clone)
        untransposed = @content
        transposed = untransposed.transpose
        @sides = {"U" => untransposed[0].clone, "D" => untransposed[-1].clone, "L" => transposed[0].clone, "R" => transposed[-1].clone}

        @parent_id = parent_id
        # matchs[left, right, up, down]
        @matchs = Array.new(4) { [] }
    end

    # Compare this piece to an other, and save which sides matched
    def comparison(other_piece)
        if @sides["L"] == other_piece.sides["R"]
            @matchs[0] << other_piece if !@matchs[0].include?(other_piece)
        end
        if @sides["R"] == other_piece.sides["L"]
            @matchs[1] << other_piece if !@matchs[1].include?(other_piece)
        end
        if @sides["U"] == other_piece.sides["D"]
            @matchs[2] << other_piece if !@matchs[2].include?(other_piece)
        end
        if @sides["D"] == other_piece.sides["U"]
            @matchs[3] << other_piece if !@matchs[3].include?(other_piece)
        end
    end

    def get_match_count
        @matchs.sum{ |i| i.count > 0 ? 1 : 0 }
    end

    def print
        @content.each { |i| p i }
    end
end

class Part
    attr_accessor :pieces, :id, :count

    def initialize(content, id)
        # 2 dimensional array, [lines][columns]

        # reverse ==> vertical flip
        # transpose.reverse ==> 90° left rotation
        # transpose.reverse.transpose ==> horizontal flip

        # 8 possible orientations for a square

        @p1 = Piece.new(content, id)
        @p2 = Piece.new(@p1.content.transpose.reverse, id)
        @p3 = Piece.new(@p2.content.transpose.reverse, id)
        @p4 = Piece.new(@p3.content.transpose.reverse, id)

        @p5 = Piece.new(@p1.content.reverse, id)
        @p6 = Piece.new(@p2.content.reverse, id)
        @p7 = Piece.new(@p3.content.reverse, id)
        @p8 = Piece.new(@p4.content.reverse, id)

        @pieces = [@p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8]
        @id = id
        @count = 0
    end

    def print
        puts "Tile n°#{@id}"
        @pieces.each.with_index { |idk, i|
            puts "Piece p#{i+1}"
            idk.content.each{ |a| puts a.join }
        }
    end

    def update_count
        @count = @pieces.map{ |p| p.get_match_count}.max
    end
end

tiles = {}

IO.read("input").split("\n\n").each{ |part|
    input = part.split("\n")
    id = input[0].match(/\d+/)[0].to_i
    content = input[1..].map(&:chars)
    tiles[id] = Part.new(content, id)
}

corners = []

# Creating links between pieces
tiles.values.each { |part|
    ids_to_test = tiles.keys - [part.id]

    # Compared to part 1, I must compute every orientations with every other
    # pieces and their orientations to get all the informations I need to
    # reconstruct the puzzle later

    # puts "New tile"
    part.pieces.each { |piece|
        ids_to_test.each { |id|
            # puts "New other piece"
            tiles[id].pieces.each { |sub_p|
                piece.comparison(sub_p)
            }
        }
    }

    part.update_count

    corners << part.id if part.count == 2
}

# This is a square puzzle, so the sides are Math.sqrt(tiles.keys.count).to_i pieces long
side_size = Math.sqrt(tiles.keys.count).to_i

# Doing this show us that, to reconstruct our puzzle, we can use tile n° 2417
# in its infliped orientation as our bottom right corner
puts "################"
p corners
p tiles[2417].pieces.map{ |p| p.get_match_count}
p tiles[2417].pieces[0].matchs.map(&:count)
puts "################"
# Of course, this way of doing things does not allow to use something else that
# the input I used
# Then we can start there and reconstruct the puzzle

puzzle = Array.new(side_size) {Array.new(side_size, -1)}
puzzle[-1][-1] = tiles[2417].pieces[0]

line = side_size-1
until line < 0
    # Do columns
    column = side_size-2
    until column < 0
        puzzle[line][column] = puzzle[line][column+1].matchs[0][0]
        column -= 1
    end
    # Place on the next line the first
    if line != 0
        puzzle[line-1][side_size-1] = puzzle[line][side_size-1].matchs[2][0]
    end
    # Pass to next line
    line -= 1
end

puts "So this is the reconstructed puzzle with tiles IDs"
puzzle.map{ |l| l.map(&:parent_id)}.each { |l| p l}

# If this is still equals to side_size**2, then it's okay
# In our case, side_size**2 == 144
#
# puts puzzle.flatten.uniq.count

# Let's reconstruct our image

puzzle.map!{ |line|
    line.map { |piece|
        piece.content[1..-2].map{ |sub_a| sub_a[1..-2]}
    }
}

# After this, puzzle is just a 4 dimensional array

puzzle.map!{ |big_line|
    smaller_big_line = Array.new(big_line[0].length) { [] }

    big_line.each{ |big_column|
        big_column.each.with_index { |line, index|
            smaller_big_line[index].concat(line)
        }
    }
    smaller_big_line
}.flatten!(1)

# puzzle is now a 2 dimensional array !!


puts "And this is the reconstructed image"
puzzle.each{ |line|
    puts line.join
}

# puzzle is now a Part object
puzzle = Part.new(puzzle, 0)

# Now time to find these bloody sea monsters

pattern = [/.{18}#./, /#.{4}##.{4}##.{4}###/, /.#..#..#..#..#..#.../]

# pattern1 = /.{18}#./
# pattern2 = /#.{4}##.{4}##.{4}###/
# pattern3 = /.#..#..#..#..#..#.../

sea_monsters = 0

puzzle.pieces.each { |orientation|
    grid = orientation.content

    0.upto(grid.length-3).each { |line|
        0.upto(grid[line].length-20) { |column|
            if grid[line][column, 20].join =~ pattern[0] && grid[line+1][column, 20].join =~ pattern[1] && grid[line+2][column, 20].join =~ pattern[2]
                sea_monsters += 1
            end
        }
    }

    break if sea_monsters > 0
}

puts "There are #{sea_monsters} sea monsters"

puts puzzle.pieces[0].content.flatten.count("#") - sea_monsters*15
