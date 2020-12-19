#!/usr/bin/ruby

# OLD IMPLEMENTATION OF PART 1
# Expression expr in its string format WITHOUT whitespaces
# Works only for part 1 because there are no priority on operators here
def compute expr
    expr = expr.chars
    until expr.length < 3
        res = 0
        val1, op, val2 = expr[0..2]

        if val1 == "("
            start, stop = find_sub_expr(expr, 0)
            sub_res = compute(expr[start+1..stop-1].join)
            expr = [sub_res] + expr[stop+1..]
            next
        end
        if val2 == "("
            start, stop = find_sub_expr(expr, 2)
            sub_res = compute(expr[start+1..stop-1].join)
            expr = [val1, op, sub_res] + expr[stop+1..]
            next
        end

        val1, val2 = val1.to_i, val2.to_i
        case op
        when "+"
            res = val1 + val2
        when "*"
            res = val1 * val2
        end
        expr = [res] + expr[3..]
    end
    expr[0]
end




# Find stop index of parenthesis which begins at start index
def find_sub_expr expr, start
    count = 1
    stop = start
    until count == 0
        stop += 1
        count += 1 if expr[stop] == "("
        count -= 1 if expr[stop] == ")"
    end
    [start, stop]

end


# Evaluate postfix expression expr in the array format, elements are evaluate
# from index 0 to the end
def postfix_computation expr
    stack = []
    expr.each { |elem|
        case elem
        when /^\d+$/
            stack << elem.to_i
        when "+"
            stack << stack.pop + stack.pop
        when "*"
            stack << stack.pop * stack.pop
        when "-"
            stack << stack.pop(2).reduce(&:-)
        when "/"
            stack << stack.pop(2).reduce(&:/)
        end
    }
    stack.pop
end

# Generate postfix expression in its array foramt
# from an infix expression in string format
# priorities is an Hash with all possible operators as keys and their
# priority (a integer) as values
def gen_postfix expr, priorities
    # Removing whitespaces
    expr.delete!(" ")
    postfix = []

    # Pointer on the infix expr
    pointer = 0
    while pointer < expr.length
        case c = expr[pointer]
        # Number
        when /\d/
            sub_count = 0
            sub_count += 1 while expr[pointer + sub_count + 1] =~ /\d/

            postfix << expr[pointer..pointer+sub_count]
            pointer += 1+sub_count
        # Parenthesis
        when "("
            # Sub-expression inside parenthesis have to be evaluated independently
            start, stop = find_sub_expr(expr, pointer)
            postfix += gen_postfix(expr[start+1..stop-1], priorities)
            pointer += stop-start+1
        # Operator
        else
            # Two cases :
            #   - The operator is not at aits right place inside the postfix expression,
            #   It needs to be moved just before the next operator with
            #   a lower or equal priority, or at the end of expr if there is no such operator.
            #   Parenthesis contains independant and must be skipped during the search.
            #   The operator is then inserted in expr, pointer is incremented but nothing is
            #   pushed in postfix, this operator will be evaluted later at its right place.
            #
            #   - The operator is already well placed (just before an operator with lower
            #   or equal priority) and must be push in postfix.

            next_char = expr[pointer+1]

            # If the operator has not to be shifted
            if priorities[next_char] && priorities[c] >= priorities[next_char] || pointer == expr.length-1
                postfix << c
                pointer += 1
                next
            end

            # If the operator must be shifted

            sub_pointer = pointer+1
            # While I haven't found the right place
            while !priorities[next_char] || priorities[next_char] > priorities[c]
                if next_char == "("
                    start, stop = find_sub_expr(expr, sub_pointer)
                    sub_pointer += stop - start + 1
                else
                    sub_pointer += 1
                end

                # If the end of expr has been reached
                break if sub_pointer >= expr.length
                next_char = expr[sub_pointer]
            end

            # When the while loop is exited, sub_pointer points at
            # the right place for the operator
            expr.insert(sub_pointer, c)

            # This allows us to keep evaluating the expression without
            # evaluating the wrongly placed operator
            pointer += 1
        end
    end

    postfix
end


if __FILE__ == $0
    priorities = {"+" => 1, "-" => 1, "*" => 1, "/" => 1}

    puts IO.readlines("input", chomp: true).sum{ |calc|
        postfix_computation(gen_postfix(calc, priorities))
    }
end
