input = []

File.open("input.txt", "r") do |i|
    i.readlines.each do |j|
        input.push(j.to_i)
    end
end

exit = false


# It is an o(n³) complexity but it was late and I was hungry

input.each do |i|
    input.each do |j|
        input.each do |k|
            if i+j+k == 2020
                puts i*j*k
                exit = true
                break
            end
        end
    exit ? break : false
    end
exit ? break : false
end
