# frozen_string_literal: true

# Class defining a node for a BST, includes comparable module
class Node
  include Comparable

  attr_accessor :key, :left, :right

  def initialize(key, left = nil, right = nil)
    self.key = key
    self.left = left
    self.right = right
  end

  def <=>(other)
    key <=> other
  end
end
