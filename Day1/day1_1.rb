input = []

File.open("input.txt", "r") do |i|
    i.readlines.each do |j|
        input.push(j.to_i)
    end
end

l = input.filter{|i| i < 1010}
h = input.filter{|i| i > 1010}
exit = false

if h.count(1010) >= 2
    print(1010**2)
else
    l.each do |c|
        h.each do |d|
            if (exit = !(c+d == 2020 ? puts(c*d) : true))
                break
            end
        end
        if exit
            break
        end
    end
end
