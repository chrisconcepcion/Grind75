# Approach
# 1. Use bfs to swap child nodes.

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
# @return {TreeNode}

# Time: O|Vertices|
# Space: O|Vertices|
def invert_tree(root)
    if !root
        return root
    end

    original_root = root
    q =[original_root]
    while q.size > 0
        root = q.shift
        left_child = root.left.dup
        right_child = root.right.dup

        root.left = right_child
        root.right = left_child
        if right_child
            q << right_child
        end

        if left_child
            q << left_child
        end

    end

    original_root
end
