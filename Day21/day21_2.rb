#!/usr/bin/ruby

# Copy of part 1

all_ingredients = []
all_allergens = {}

IO.readlines("input", chomp: true).each { |food|
    ingredients, allergens = food.scan(/(.*) \(contains (.*)\)/).flatten
    ingredients = ingredients.split
    allergens = allergens.split(", ")

    all_ingredients.push(*ingredients)

    allergens.each { |allerg|
        if all_allergens.keys.include?(allerg)
            all_allergens[allerg] &= ingredients
        else
            all_allergens[allerg] = ingredients.clone
        end
    }
}

until all_allergens.values.flatten.length == all_allergens.keys.length
    all_allergens.keys.each { |allerg|

        if all_allergens[allerg].length == 1
            (all_allergens.keys - [allerg]).each { |to_clean|
                all_allergens[to_clean].delete(all_allergens[allerg][0])
            }
        end

    }
end

# Part 2 begins here

p sorted = all_allergens.keys.sort

puts sorted.map{ |allerg| all_allergens[allerg][0]}.join(",")
