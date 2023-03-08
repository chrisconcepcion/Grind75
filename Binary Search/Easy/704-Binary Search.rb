# Approach
# Write a simple binary index function. I realized later even though this passes,
# my implementation was incorrect.

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search(nums, target)
    return binary_index nums, target, nil, (nums.count/2)
end


def binary_index array, target, sign = nil, starting_point = nil
    # Set starting point to middle of array.
    if starting_point == nil
        starting_point = array.count/2
    end

    query_val = array[starting_point]
    # If the val is nil, we have gone out of bounds and the value does not exist
    # in the array.
    if query_val == nil
        return -1
    end

    # If the val is the target we are returning for return starting point.
    if query_val == target
        return starting_point
    # Otherwise set the direction of how we should be searching and set
    # starting point to go in that direction(+ or -)
    else
        if query_val > target
            starting_point = starting_point - 1
            new_sign = :subtract
        else
            starting_point = starting_point + 1
            new_sign = :add
        end
    end

    # If sign and new sign are different, we know we are attempting to find a value that doesn't exist.'
    # For example: [0,2,4] and we are searching for 3. We would keep changing directions
    # and would end up in an infinite loop.
    if sign
        if sign != new_sign
            return -1
        end
    end

    # Recursively call binary index until we find our target or determine it's not available in our array.
    binary_index array, target, new_sign, starting_point
end


# Second Approach, beats 93.55%, 14.52% memory
# Approach
# Write a simple binary index function.

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search(nums, target)
    return binary_index nums, target, nil
end


def binary_index array, target, index_range = nil
    if array.size == 0
        return -1
    end

    # Set starting point to middle of array.
    starting_point = array.count/2

    # Keeps track of index as our array changes.
    if index_range == nil
        index_range = (0..(array.size - 1)).to_a
    end

    query_val = array[starting_point]

    # If the val is nil, we have gone out of bounds and the value does not exist
    # in the array.
    if query_val == nil
        return -1
    end

    # If the val is the target we are returning for return starting point.
    if query_val == target
        return index_range[starting_point]
    # Otherwise set the direction of how we should be searching and set
    # starting point to go in that direction(+ or -)
    else
        # If our target is less than our query val, reduce the array from the beginning
        # of the array up to(not including) our starting_point.
        # Do the same operation on our index range.
        if query_val > target
            array = array[0...starting_point]
            index_range = index_range[0...starting_point]

        # If our target is larger than our query val, reduce the array from the starting_point + 1
        # up to the end of the array.
        # Do the same operation on our index range.
        else
            array = array[(starting_point + 1)..-1]
            index_range = index_range[(starting_point + 1)..-1]
        end
    end

    # Recursively call binary index until we find our target or determine it's not available in our array.
    binary_index array, target, index_range
end
