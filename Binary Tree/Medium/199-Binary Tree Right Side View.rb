# Approach
# When looking at a tree right from the right you can see ndoes from the left side if the length of the left subtree is longer than the right subtree.
# We use dfs to start building the values in typical stack order(lifo), so we place our current node in an array and concat the nodes returned from the stack.
# We account for the lengths of the left and right subtree by expanding the right subtree returned values using values from the left subtree but we use the size of the right subtree as the beginning index.

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
# @return {Integer[]}
def right_side_view(root)
    if root
        dfs(root)
    else
        []
    end
end



def dfs node
    if node == nil
        return []
    end

    left = dfs(node.left)
    right = dfs(node.right)

    if left.size > right.size
        right.concat left[right.size..-1]
    end

    [node.val].concat right
end
