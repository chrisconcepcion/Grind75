# Approach
# 1. Reverse a and b strings.
# 2. Determine max size by figuring out which of a or b is longer.
# 3. Use a value to store a carry over value("1" + "1" in binary gives us "10", in "10" the 1 is carried over like the 10 is in basic math.)
# 4. Now going both a and b 1 letter at a time, convert this letter to an integer and add it to the previously calculated carry over value. When 1 or 0, set carry over value to 0 and prepend this total value to the array. When total value is 2 or 3 set carry over to 1, subtract 2 from total value and prepend the calculated value to the array.
#5. When done account for the last carry over, if it's 1 then prepend 1 to the array.
#6. Go through the array and concat all the values together and return concat'd string.

# @param {String} a
# @param {String} b
# @return {String}
def add_binary(a, b)

    # 1. Reverse a and b
    a = a.reverse
    b = b.reverse

    answer = []
    max_length = nil

    # 2. Determine max size by figuring out which of a or b is longer
    if a.size > b.size
        max_length = a.size
    elsif  b.size > a.size
        max_length = b.size
    # equivalant
    else
        max_length = b.size
    end


    # 3. Use a value to store a carry over value("1" + "1" in binary gives us "10", in "10" the 1 is carried over like the 10 is in basic math.)
    # 4. Now going both a and b 1 letter at a time, convert this letter to an integer and add it to the previously calculated carry over value. When 1 or 0, set carry
    index = 0
    carry_over = 0
    while index < max_length
        a_val = a[index]
        b_val = b[index]
        total_val =  carry_over + a_val.to_i + b_val.to_i
        case total_val
        when 0
            answer.prepend "0"
            carry_over = 0
        when 1
            answer.prepend "1"
            carry_over = 0
        when 2
            answer.prepend "0"
            carry_over = 1
        when 3
            answer.prepend "1"
            carry_over = 1
        end


        index = index + 1
    end

    #5. When done account for the last carry over, if it's 1 then prepend 1 to the array.
    if carry_over == 1
        answer.prepend "1"

    end

    #6. Go through the array and concat all the values together and return concat'd string.
    string = ""
    answer.each do |an|
        string = string + an
    end

    return string
end
