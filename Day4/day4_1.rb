to_match = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]
count = 0

IO.read("input").split("\n\n").map{|i|
    count+=1 if (to_match - i.split(/[\n\s]/).map{|sub| sub[0,3]}).length == 0
}

puts count
