# Approach
# Use DFS to determine the depth of left and right node.
# When we have a difference of more than 1 between the depth of left and
# right subtrees, we return false.
# DFS is the best algo for this question.


# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {Boolean}
def is_balanced(root)

    if root.nil?
        return true
    end

    answer = Dfs.new(root).start




end

class Dfs
    def initialize(root)
        @root = root
        @success = true
    end

    def start
        dfs(@root)
        return @success
    end

    # Recursively transverse nodes til we reach the bottom(run out of children).
    # Once at the bottom of tree, 0 will be return and for each level above it
    # we will add 1.
    # Stack Data Structure, Last in, first out.
    # Essentially this returns the depth of a left and right subtree and when we
    # have a difference of more than 1 between the depth of left and right subtrees,
    # we set @success to false.
    def dfs node
        if node.nil?
            return 0
        end

        left = dfs(node.left)

        right = dfs(node.right)

        difference = (left - right).abs

        if difference > 1
            @success = false
        end

        if left > right
            return left + 1
        else
            return right + 1
        end
    end

end
