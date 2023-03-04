# Approach
# Use BFS to go through each level and collect values.

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
# @return {Integer[][]}
def level_order(root)
    if root == nil
        return []
    end

    answer = []
    q = [root]
    next_level = []
    current_level = []
    while q.size > 0
        node = q.shift
        current_level << node.val

        if node.left
            next_level << node.left
        end

        if node.right
            next_level << node.right
        end

        if q.size == 0
            answer << current_level
            q = next_level
            next_level = []
            current_level = []
        end
    end
    answer
end
