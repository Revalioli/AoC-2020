height = (input = IO.readlines("input","\n", chomp: true)).length
count, x, y, l = 0, 0, 0, input[0].length
# puts input

while y < height-1
    x += 3
    y += 1
    count += 1 if input[y][x%l] == '#'
end

puts count
