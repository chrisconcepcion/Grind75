# Beats 60% runtime, 60% memory
# Approach
# We need to find first bad n using bsearch.

# The is_bad_version API is already defined for you.
# @param {Integer} version
# @return {boolean} whether the version is bad
# def is_bad_version(version):

# @param {Integer} n
# @return {Integer}
def first_bad_version(n)
    # https://www.rubydoc.info/stdlib/core/Array:bsearch
    # https://www.rubydoc.info/stdlib/core/Range:bsearch
    # find-minimum mode, method bsearch returns the first element for which the block returns true.
    (1..n).bsearch { |version| is_bad_version(version) }

end

# Beats 60% runtime, 50% memory
# Second approach using build your own binary search, recursion. bsearch felt
# like cheating.
# Approach
# We need to find first bad n using binary search.

# The is_bad_version API is already defined for you.
# @param {Integer} version
# @return {boolean} whether the version is bad
# def is_bad_version(version):

# @param {Integer} n
# @return {Integer}
def first_bad_version(n)
    binary_search 1, n
end

def binary_search beginning, ending
    # Start checking for bad version at medium point.
    mid = (beginning + ending)/2
    if !is_bad_version(mid)
        # If mid is not bad version, change beginning to mid + 1 as
        # mid and less are no longer possibilities.
        beginning = mid + 1
    else
        # If mid is bad version, set ending to mid to reduce possibilities.
        ending = mid
    end

    # If beginning is bad version then we know we found the solution.
    if is_bad_version(beginning)
        return beginning
    end

    binary_search beginning, ending
end

# Beats 99.9%, 76,82% memory.
# Third approach using build your own binary search, while loop this time.
# Approach
# We need to find first bad n using binary search.

# The is_bad_version API is already defined for you.
# @param {Integer} version
# @return {boolean} whether the version is bad
# def is_bad_version(version):

# @param {Integer} n
# @return {Integer}
def first_bad_version(n)
    binary_search 1, n
end

def binary_search beginning, ending
    while true
        # Start checking for bad version at medium point.
        mid = (beginning + ending)/2
        if !is_bad_version(mid)
            # If mid is not bad version, change beginning to mid + 1 as
            # mid and less are no longer possibilities.
            beginning = mid + 1
        else
            # If mid is bad version, set ending to mid to reduce possibilities.
            ending = mid
        end

        # If beginning is bad version then we know we found the solution.
        if is_bad_version(beginning)
            return beginning
        end
    end
end
