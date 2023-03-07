# Approach
# serialize: Use bfs to create a level order transversal representation of the tree, 1:1 with nil values. Capture all node values to an array. Convert array to json.

# deserialize: Parse json array, rebuild all nodes via level order.

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# Encodes a tree to a single string.
#
# @param {TreeNode} root
# @return {string}
def serialize(root)

    if root == nil
        return [].to_json
    end
    serialized_array = []
    next_level = []

    q = [root]
    while q.size > 0
        node = q.shift
        if node
            serialized_array << node.val
            next_level << node.left
            next_level << node.right
        else
            serialized_array << nil
        end


        if q.size == 0
            if next_level.compact.empty?
                break
            end
            q = next_level
            next_level = []
        end
    end

    # Remove nils from end of array because they are useless and add complexity to deserialize.
    while serialized_array.last == nil
        serialized_array.pop
    end

    serialized_array.to_json
end

# Decodes your encoded data to tree.
#
# @param {string} data
# @return {TreeNode}
def deserialize(data)
    deserialized_nodes = (JSON.parse data)

    if deserialized_nodes.empty?
        return nil
    end

    # Create root node.
    node_val = deserialized_nodes[0]
    if node_val
        root_node = TreeNode.new(node_val)
    end

    # Start the q with the first 2 child nodes.
    q = deserialized_nodes[1..2]

    # Store last index added to the q.
    last_index = 2

    # Keep track of previous levels so we can connect parents back with their children.
    previous_level = [root_node]

    # Keeps track of nodes created at current level, will become value of previous level and set to an empty array
    # at the end of each level.
    current_level = []

    # Storage for the next level assigned at the end of each level. We use last_index and size of current level to determine
    # how many items will go into this array.
    next_level = []

    # We start at 1 as it's an odd number, we use odd number indexes to determine left child and even for right child.
    index = 1
    while q.size > 0

        node_val = q.shift
        if node_val
            new_node = TreeNode.new(node_val)
            parent_node = previous_level[parent_node index]

            if index.odd?
                parent_node.left = new_node
                #return parent_node.left.val
            else
                parent_node.right = new_node
            end
            current_level << new_node
        end
        index = index + 1

        # We need to:
        # 1. Update previous level with nodes created on current level then reset current level array.
        # 2. Refill q with next set of nodes based on the amount of nodes on current level * 2(a parent can have 2 children), this requires last_index as stated above.
        # 3. Reset index to 1.
        if q.size == 0
            previous_level = current_level
            current_level = []
            starting_point = last_index
            if starting_point
                starting_point = starting_point + 1
                amount_of_items = previous_level.size * 2
                last_index = last_index + amount_of_items
                q = deserialized_nodes[starting_point...(starting_point+amount_of_items)]
                if q == nil
                    q = []
                end
                index = 1
            end
        end
    end

    root_node
end


def parent_node index
    ((index - 1) / 2)
end


# Your functions will be called as such:
# deserialize(serialize(data))
