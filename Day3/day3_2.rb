height = (input = IO.readlines("input","\n", chomp: true)).length
l = input[0].length
patterns = [[1,1],[3,1],[5,1],[7,1],[1,2]]

results = patterns.map{|dx,dy|
    count, x, y = 0, 0, 0
    while y < height-1
        x += dx
        y += dy
        count += 1 if input[y][x%l] == '#'
    end
    count
}

# puts results
puts results.reduce(:*)
