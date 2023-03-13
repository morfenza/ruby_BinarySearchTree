# Ruby Binary Search Tree
Project: Binary Search Tree from [The Odin Project](https://www.theodinproject.com/about), in this project I've implemented a balanced binary search tree
## Links
- [Link to the assignment](https://www.theodinproject.com/lessons/ruby-binary-search-trees)

## Running Locally
```console
ruby lib/main.rb
```

## Implemented Methods 
| Method        | Description   |
| ------------- |:-------------|
| #build_tree    | Takes an array of data and turns it into a balanced binary tree full of Node objects appropriately placed |
| #insert    | Adds a new node |
| #delete | Removes a node |
| #find | Accepts a value and returns the node with the given value    |
| #level_order | Traverse BST yielding each node to a block, in case there is no block, return array of values |
| #inorder | Inorder traverse BST yielding each node to a block, in case there is no block, return array of values    |
| #preorder | Preorder traverse BST yielding each node to a block, in case there is no block, return array of values |
| #postorder | Postorder traverse BST yielding each node to a block, in case there is no block, return array of values |
| #height | Return the height of given node |
| #depth | Return the height of given node |
| #balanced? | Checks if BST is balanced |
| #rebalance | Rebalances an unbalanced tree |