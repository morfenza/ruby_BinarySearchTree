# frozen_string_literal: true

require_relative 'node'

# Class defining a BST using node
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
    find(key, root.right) if root.key < key
    find(key, root.left)
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
end

bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

p bst.find(3)
bst.insert(27)
bst.delete(4)

bst.pretty_print

p bst.level_order

bst.level_order do |node|
  puts node.key + 1
end
