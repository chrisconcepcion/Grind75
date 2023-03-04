# Approach
# Use DFS to determine the depth of left and right node.

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

    def dfs node, depth = 0
        if node.nil?
            return 0
        end

        left = dfs(node.left, depth + 1)

        right = dfs(node.right, depth + 1)

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
