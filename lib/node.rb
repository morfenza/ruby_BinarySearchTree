# frozen_string_literal: true

# Class defining a node for a BST, includes comparable module
class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data, left, right)
    self.data = data
    self.left = left
    self.right = right
  end

  def <=>(other)
    data <=> other
  end
end
