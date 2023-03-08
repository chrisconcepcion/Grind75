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
