puts IO.read("input").split("\n\n").map{|i|
    i.split(/[\n\s]/).reduce(0){|c, field|
        n, v = field.split(":")
        case n
        when "byr"
            c+=1 if (1920..2002) === v.to_i
        when "iyr"
            c+=1 if (2010..2020) === v.to_i
        when "eyr"
            c+=1 if (2020..2030) === v.to_i
        when "hgt"
            /^(\d*)(cm|in)$/ =~ v
            c+=1 if $2 == "cm" && (150..193) === $1.to_i || $2 == "in" && (59..76) === $1.to_i
        when "hcl"
            c+=1 if /^#[0-9a-f]{6}$/ =~ v
        when "ecl"
            c+=1 if /amb|blu|brn|gry|grn|hzl|oth/ =~ v
        when "pid"
            c+=1 if /^[0-9]{9}$/ =~ v
        end
        c
    }
}.count(7)
