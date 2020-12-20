#!/usr/bin/ruby

class Piece

    attr_accessor :sides, :content, :matchs

    def initialize(content)
        @content = content.map(&:clone)
        untransposed = @content
        transposed = untransposed.transpose
        @sides = {"U" => untransposed[0].clone, "D" => untransposed[-1].clone, "L" => transposed[0].clone, "R" => transposed[-1].clone}

        @left_match, @right_match, @up_match, @down_match = Array.new(4) { [] }
        @matchs = [@left_match, @right_match, @up_match, @down_match]
    end

    # Compare this piece to an other, and save which sides matched
    def comparison(other_piece)
        if @sides["L"] == other_piece.sides["R"]
            @left_match << other_piece if !@left_match.include?(other_piece)
        end
        if @sides["R"] == other_piece.sides["L"]
            @right_match << other_piece if !@right_match.include?(other_piece)
        end
        if @sides["U"] == other_piece.sides["D"]
            @up_match << other_piece if !@up_match.include?(other_piece)
        end
        if @sides["D"] == other_piece.sides["U"]
            @down_match << other_piece if !@down_match.include?(other_piece)
        end
    end

    def get_match_count
        @matchs.sum{ |i|
            i.count > 0 ? 1 : 0
        }
    end

    def print
        @content.each { |i|
            p i
        }
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

        @p1 = Piece.new(content)
        @p2 = Piece.new(@p1.content.transpose.reverse)
        @p3 = Piece.new(@p2.content.transpose.reverse)
        @p4 = Piece.new(@p3.content.transpose.reverse)

        @p5 = Piece.new(@p1.content.reverse)
        @p6 = Piece.new(@p2.content.reverse)
        @p7 = Piece.new(@p3.content.reverse)
        @p8 = Piece.new(@p4.content.reverse)

        # @pieces = [@unflip, @Vflip, @Hflip, @HVflip]
        @pieces = [@p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8]
        @id = id
        @count = 0
    end

    def print
        puts "Tile n°#{@id}"
        @pieces.each.with_index { |idk, i|
            puts "Piece p#{i+1}"
            idk.content.each{ |a| p a }
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

res = []

tiles.values.each { |part|
    ids_to_test = tiles.keys - [part.id]
    # puts "New tile"
    piece = part.pieces[0]
    # testing one orientation with all the orientations of the other pieces is enough
    # to cover every cases of combination

    ids_to_test.each { |id|
        # puts "New other piece"
        tiles[id].pieces.each { |sub_p|
            piece.comparison(sub_p)
        }
    }

    part.update_count

    res << part.id if part.count == 2
}

p res.reduce(&:*)
