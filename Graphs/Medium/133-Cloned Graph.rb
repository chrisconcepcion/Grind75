# Approach
# 1. write bfs function where:
# a. clone root,
# b. add neighbors to queue,
# c. store clone in hash with key being node value. We want to use the hash to memo the value so we can ensure we do not clone the same node twice and cause a infinite loop.
# d. Add neighbors to node when neighbor is already in hash and when we do add the neighbor ensure that both the neighbor and the current node both have their neighbor.

# Definition for a Node.
# class Node
#     attr_accessor :val, :neighbors
#     def initialize(val = 0, neighbors = nil)
#		  @val = val
#		  neighbors = [] if neighbors.nil?
#         @neighbors = neighbors
#     end
# end

# @param {Node} node
# @return {Node}

# BFS
# Time: O(|Vertices|)
# Space: O(|Vertices|)
require 'set'
def cloneGraph(node)

    # Facts:
    # Each node has a value
    # Each node has a list of its neighbors( node.neighbors)

    if node == nil
        return node
    end

    original_node_val = node.val
    q = [node]
    nodes = Hash.new
    # BFS
    # Time: O(|Vertices|)
    # Space: O(|Vertices|)
    while q.size > 0
        node = q.shift
        if !nodes[node.val]
            new_node = Node.new(node.val)
            node.neighbors.each do |neighbor|
                neighbor_val = neighbor.val
                if nodes[neighbor_val]
                    if !new_node.neighbors.detect{|n| n.val == neighbor_val}
                        new_node.neighbors << nodes[neighbor_val]
                    end
                    if !nodes[neighbor_val].neighbors.detect{|n| n.val == new_node}
                        nodes[neighbor_val].neighbors << new_node
                    end
                end
                q << neighbor
            end
            nodes[new_node.val] = new_node

        end
    end

    return nodes[original_node_val]
end
