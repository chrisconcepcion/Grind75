# Failed to solve this one but was interesting. Added comments to explain.
def build_tree(preorder, inorder)
  return if inorder.empty?

  root_val = preorder.shift
  root_index = inorder.index(root_val)

  root = TreeNode.new(root_val)
  # Exclude the root_val as its already consumed.
  # When we run root.left = .. it will remove all items from preorder that are on the left side of the tree.
  # "..." in a range means exclude the final item in the range(if it exists).
  root.left = build_tree(preorder, inorder[0...(root_index)])
  # Exclude the root_val as its already consumed.
  # By the time we run root.right on the first preorder item, all left side nodes have already been removed from preorder.
  root.right = build_tree(preorder, inorder[(root_index + 1)..-1])
  root
end
