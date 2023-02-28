# frozen_string_literal: true

require_relative 'node'

# Class defining a BST using node
class Tree
  attr_accessor :root

  def initialize(arr)
    self.root = build_tree(arr)
  end

  def build_tree(arr); end
end
