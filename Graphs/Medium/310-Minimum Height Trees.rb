# Approach
# 1. Get edges into a hash where each key is a not that is connected to each other. Each element within the the hash contains another hash where the keys are the nodes that connect to one another.
# Example:
# A and B are connected
# {"a": {"b": true}, "b": {"a": true}}
# 2. Collect all edges which connect only to 1 other edge and store them in an array called leaves.
# 3. After we remove all leaves and their hash key from non-leaf edges, we collect new leaves in the leaves array.
# Repeat steps 2 and 3 until we have 2 or less values. Remaining values are the answer.

# @param {Integer} n
# @param {Integer[][]} edges
# @return {Integer[]}
require 'set'

# Time: O(|V|)
# Space: O(|V|)
def find_min_height_trees(n, edges)
  # This makes it so when you add an element to the hash, it's value is a set.
  # Set is similar to an array except it only contains uniq values.
  # Also the look up time is as fast as checking an hash to see if a key exist, 0(1).
  adjs = Hash.new
  # Time: O(N)
  # Space: O(N)
  edges.each do |edge_1, edge_2|
    if !adjs[edge_1]
        adjs[edge_1] = {}
    end

    if !adjs[edge_2]
        adjs[edge_2] = {}
    end
    adjs[edge_1][edge_2] = true
    adjs[edge_2][edge_1] = true
  end
  remained = n
  # Get all the leaves, values with only 1 edge
  # Time: O(N)
  # Space: O(N)
  leaves = adjs.keys.select { |v| adjs[v].keys.size == 1 }


  # Time: O(|V|)
  # Space: O(|V|)
  # Remove leaves and from leaves from associacted adj sets.
  # After removing leaves, add new leaves from the associated sets.
  # We then set leaves to newleaves and  continue reducing the amount of vertices
  # until we have 2 or less vertices.
  # When we have 2 vertices, they are both interchangable and therefore fulfills the answer requirements.
  while remained > 2
    newleaves = []
    leaves.each do |vertice|
      # Remove leaf from set of all associated adj sets.
      # Time: O(N)
        # Space: O(N)
      adjs[vertice].keys.each { |to| adjs[to].delete(vertice) }
      # Now add leaves from all associated adj sets
      # Time: O(N)
     # Space: O(N)
      newleaves += adjs[vertice].keys.select { |to| adjs[to].keys.size == 1 }
    end
    # Now reduce remaining edges by all the leaves we just removed.
    remained -= leaves.size
    # Set leaves to newleaves
    leaves = newleaves
  end
  # If there are any leaves left, we return those leaves as they must be the answer.
  # Otherwise return [0]
  leaves.any? ? leaves : [0]
end
