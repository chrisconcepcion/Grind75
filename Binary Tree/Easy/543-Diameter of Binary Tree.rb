# Approach
# Get the depth of eachs nodes left and right subtree and add them together to calculate the diameter of a node. Return the heightest depth.


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
# @return {Integer}
def diameter_of_binary_tree(root)
    return NodeDiameterCalculator.new(root).start
end


class NodeDiameterCalculator
    def initialize root
        @root = root
        @node_diameters = {}
        @heightest_combination = 0
    end

    def start
        max_of_depth_of_tree @root
        return @heightest_combination
    end

    def max_of_depth_of_tree node
        if node == nil
            return 0
        end

        left = max_of_depth_of_tree node.left
        right = max_of_depth_of_tree node.right

        combo = left + right
        if @heightest_combination < combo
            @heightest_combination = combo
        end
        [left, right].max + 1

    end
end
