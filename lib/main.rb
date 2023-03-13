# frozen_string_literal: true

require_relative 'tree'

# Driver script
# create bst with 15 rand nums
bst_arr = Array.new(15) { rand(1..100) }
bst = Tree.new(bst_arr)

# confirm that is balanced
bst.balanced?

# print
bst.pretty_print

puts 'Level'
p bst.level_order

puts 'preorder'
p bst.preorder

puts 'postorder'
p bst.postorder

puts 'inorder'
p bst.inorder

# Unbalance tree
bst.insert(100)
bst.insert(110)
bst.insert(120)
bst.insert(130)
bst.insert(140)

# print
bst.pretty_print

# check if balanced?
p bst.balanced?

# rebalance
bst.rebalance

# check if balanced?
p bst.balanced?

# print
bst.pretty_print

puts 'Level'
p bst.level_order

puts 'preorder'
p bst.preorder

puts 'postorder'
p bst.postorder

puts 'inorder'
p bst.inorder

####
# Testing
#bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

#p bst.find(3)
#bst.insert(27)
#bst.delete(4)

#bst.pretty_print

#p bst.level_order

#bst.level_order do |node|
#  puts node.key + 1
#end

#p bst.inorder
#p bst.preorder
#p bst.postorder

#p bst.depth(324)
#p bst.height(8)
#p bst.height(325)

#bst.insert(100)
#bst.insert(110)
#bst.insert(120)
#bst.insert(130)

#bst.pretty_print

#p bst.balanced?

#bst.rebalance

#bst.pretty_print

#p bst.balanced?