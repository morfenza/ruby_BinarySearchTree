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
    # left subtree with values < root
    root.left = build_tree(arr[0...mid])

    # recursive call
    # right subtree with values > root
    root.right = build_tree(arr[mid + 1..])

    # returns root
    root
  end

  # Method to visualize the tree (Kudos to the student who shared it on Discord)
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, root = self.root)
    # Base case, if the root is empty,
    # return new Node with value
    if root.nil?
      root = Node.new(value)
      return root
    end

    # Checks value to call insert recursively on left/right tree
    # if value > root.data -> right else left
    value > root.data ? root.right = insert(value, root.right) : root.left = insert(value, root.left)

    # Return unchanged root
    root
  end

  def delete; end
end

bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

bst.insert(27)
bst.pretty_print
