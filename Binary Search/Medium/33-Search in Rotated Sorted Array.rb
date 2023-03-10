# Approach
# 1. Find the point where the array pivots(if it does indeed pivot)
# 2. Then determine if the target is within the array after it has pivoted or before it pivoted.
# 3. Check the array(pivoted or not) for the index.
# 4. If the index is available, return the index. Otherwise return -1.

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search(nums, target)

    # Find pivot point(if it exists)
    pivot_index = find_pivot nums

    # We did not find a pivot, so we use binary search to find the index.
    if pivot_index == nil || pivot_index == 0
        index = nums.bsearch_index {|n| target <=> n }
    else
        # Determine which part of the array the target is POSSIBILY in.
        # The last item of the array(when pivoted) will definitely be smaller than
        # Items at the beginning of the array.
        # Example to show how this is possible: [5, 6, 0, 1, 2, 3]
        if target <= nums[-1]
            index = nums[pivot_index..-1].bsearch_index {|n| target <=> n }
            if index
                index = pivot_index + index
            end
        # Otherwise the target is between the first item in the array up to
        # the pivot point.
        else
            index = nums[0...pivot_index].bsearch_index {|n| target <=> n }
        end
    end

    # If index is available then return index, otherwise return -1.
    if index
        return index
    else
        return -1
    end
end


# A very important property of the rotated array is the first half of the array if rotated anywhere will be detectable immediately as the mid point will always be lower than the starting point.
# Once we have cleared the first half of the array in the first loop, we start working through the second half of the array which does not have the same property as the first half. The last value of the array can be the rotated value and it wont be detected in the second loop(second loop being first loop that begins to check the second half of the array).
# From the second loop onward, we start working through the second half of the array by increasing the low/starting index of the array until we have worked through all possibilities of where the pivot can be.
# Lately we end the process if we do not find a pivot point by detecting if low index has increased so much it has surpassed the high index value.
# Examples of how the loop interations play out with [1,2,3,4,5,6,7,0]
# Initial array: [2,3,4,5,6,7,0,1]
# Step 2: We loss the first half of the array, [5,6,7,0]
# Step 3: Then we decrease the array in half again [7,0]
# Step 4: We return 7, the index of 0

# Another Example now with the pivot in the first half of the array:
# Initial array: [5, 6, 0, 1, 2, 3]
# Step 2: We loss the second half of the array, [5,6,0]
# Step 3: We return 2, the index of 0.
def find_pivot nums

    low = 0
    high = nums.size - 1
    mid = (low + high) /2
    while true
        if low > high
            return nil
        end
        if nums[mid - 1] && (nums[mid] < nums[mid - 1])
            return mid
        elsif nums[mid + 1] && (nums[mid + 1] < nums[mid] )
            return mid + 1
        elsif nums[low] >= nums[mid]
            high = mid - 1
        elsif nums[low] < nums[mid]
            low = mid + 1
        end
        mid = (low + high) /2
    end

    return nil
end
