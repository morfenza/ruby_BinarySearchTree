# frozen_string_literal: true

require_relative 'node'

# Class defining a BST using node
# rubocop:disable Metrics/ClassLength
class Tree
  attr_accessor :root

  def initialize(arr)
    self.root = build_tree(arr.uniq.sort)
  end

  # Receives an array and returns the root to a balanced BST of Node objects
  def build_tree(arr)
    # base case
    return nil if arr.empty?

    # find the middle index
    mid = (arr.size / 2).floor

    # define root as the middle element
    root = Node.new(arr[mid])

    # recursive call
    # left subtree with keys < root
    root.left = build_tree(arr[0...mid])

    # recursive call
    # right subtree with keys > root
    root.right = build_tree(arr[mid + 1..])

    # returns root
    root
  end

  # Method to visualize the tree (Kudos to the student who shared it on Discord)
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.key}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(key, root = self.root)
    # Base case, if the root is empty,
    # return new Node with key
    if root.nil?
      root = Node.new(key)
      return root
    end

    # Checks key to call insert recursively on left/right tree
    # if key > root.key -> right else left
    key > root.key ? root.right = insert(key, root.right) : root.left = insert(key, root.left)

    # Return unchanged root
    root
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def delete(key, root = self.root)
    # Base case, return root if it is empty
    return root if root.nil?

    # Search for the key to be deleted recursively
    # if it is found than the else clause resolves
    if key < root.key
      root.left = delete(key, root.left)
    elsif key > root.key
      root.right = delete(key, root.right)
    else
      # node with one child or no children
      # deletes the node and return its only child in its place
      if root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end

      # node with two children, get the smallest value in subtree
      # set the root as the foun value
      root.key = tree_min_value(root.right)

      # delete minimum value (so there is an effective change of key, no repetition)
      root.right = delete(root.key, root.right)
    end

    root
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  # Serach for the mininum value on a tree
  def tree_min_value(root)
    min_value = root.key

    # Transverse the tree searching its left values (< root)
    until root.left.nil?
      min_value = root.left.key
      root = root.left
    end

    min_value
  end

  def find(key, root = self.root)
    # base case, return nil if empty, root if it finds
    return root if root.nil? || root.key.eql?(key)

    # recursive calls on left and right subtree depending on key value
    if root.key < key
      find(key, root.right)
    else
      find(key, root.left)
    end
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def level_order
    # guard clause case
    return if root.nil?

    # value arr
    values = []

    # Queue for BFS
    queue = [root]

    # Traverse until there are no discovered nodes
    until queue.empty?
      # remove element from queue and pass it into a variable
      current_node = queue.shift
      values << current_node.key

      yield(current_node) if block_given?

      # push discovered nodes into queue
      queue << current_node.left unless current_node.left.nil?
      queue << current_node.right unless current_node.right.nil?

    end

    values unless block_given?
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def inorder(root = self.root, values = [])
    # base case
    return if root.nil?

    # inorder access
    inorder(root.left, values)

    yield(root) if block_given?
    values << root.key

    inorder(root.right, values)

    values unless block_given?
  end

  def preorder(root = self.root, values = [])
    # base case
    return if root.nil?

    # preorder access
    yield(root) if block_given?
    values << root.key

    preorder(root.left, values)
    preorder(root.right, values)

    values unless block_given?
  end

  def postorder(root = self.root, values = [])
    # base case
    return if root.nil?

    # postorder accer
    postorder(root.left, values)
    postorder(root.right, values)

    yield(root) if block_given?
    values << root.key

    values unless block_given?
  end

  def depth(node, depth = 0, root = self.root)
    return -1 if root.nil?

    return depth if root.key == node

    if node > root.key
      depth += 1
      depth(node, depth, root.right)
    elsif node < root.key
      depth += 1
      depth(node, depth, root.left)
    end
  end

  def height(node = root)
    node = find(node) unless node.nil? || node.instance_of?(Node)

    # base case
    return -1 if node.nil?

    # calculates the height for right and left trees
    left_height = height(node.left)
    right_height = height(node.right)

    # height of current node
    [left_height, right_height].max + 1
  end

  def balanced?(root = self.root)
    # base case
    return true if root.nil?

    # calculate height for subtrees
    left = height(root.left)
    right = height(root.right)

    # check balance for current and subtrees
    return true if (left - right).abs <= 1 && balanced?(root.left) == true && balanced?(root.right) == true

    # unbalanced
    false
  end

  def rebalance
    self.root = build_tree(level_order)
  end
end
# rubocop:enable Metrics/ClassLength
