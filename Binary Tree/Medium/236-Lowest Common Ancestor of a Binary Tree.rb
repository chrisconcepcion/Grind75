# Approach
# When q is the child of p or when p is the child of q, return the parent.
# Otherwise return the parent of both p and q.
# Use dfs to determine the rules above, we create a hash with a set as the value. We only capture p and q in our set. Since dfs uses a call stack, the deepest nodes resolve first so once our set contains p and q for the first time, the current node is the least common ancestor.

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @param {TreeNode} p
# @param {TreeNode} q
# @return {TreeNode}
require 'set'
def lowest_common_ancestor(root, p, q)
    lca_finder = LcaFinder.new(root, p, q)
    lca_finder.start
    lca_finder.node
    end

# LCA standa for lowest common ancestor and p and q are our descendents.
class LcaFinder
    attr_accessor :node
    def initialize(root, p, q)
        @root = root
        @p = p
        @q = q
        @node = nil
    end

    def start
        lowest_common_ancestor @root
    end

    # This function is essentially a bfs function. Due to dfs creating a call stack, the order of resolution is
    # deepest nodes resolve first. Since deepest nodes resolve first we know the first time our set contains both p and q
    # that means we found our lowest common ancestor node
     def lowest_common_ancestor  node
        # Exists the stack early if we have found our solution.
        if node == nil || @node
            return Set.new
        end

        # Recurisely dig down through the left node to see if we can find p or q.
        left = collect_descendents node.left

        # Recurisely dig down through the right node to see if we can find p or q.
        right = collect_descendents node.right

        # Only if our node val is p or q do we add it to the set, otherwise set is just an empty set.
        if node.val == @p.val ||  node.val == @q.val
            set = Set.new([node.val])
        else
            set = Set.new
        end

        # Merge left and right set into our set.
        set.merge left
        set.merge right

        # When our set has both p and q, we found our lowest common ancestor node.
        if (set.include? @p.val) && (set.include? @q.val)
            if @node == nil
                @node = node
            end
        end

        # Return set, set will only contain p, q or both.
        set
    end
end
