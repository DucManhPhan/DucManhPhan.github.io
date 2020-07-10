---
layout: post
title: How to solve tree problems recursively
bigimg: /img/image-header/yourself.jpeg
tags: [Data Structure, Tree]
---

All contents of this article is referred on [leetcode](https://leetcode.com/explore/learn/card/data-structure-tree/17/solve-problems-recursively/534/).

<br>

## Table of contents
- [Using Top-Down solution](#using-top-down-solution)
- [Using Bottom-Up solution](#using-bottom-up-solution)
- [Wrapping up](#wrapping-up)


<br>

## Using Top-Down solution

**Top-down** means that in each recursive call, we will visit the node first to come up with some values, and pass these values to its children when calling the function recursively. So the **Top-down** solution can be considered as a kind of **preorder** traversal. To be specific, the recursive **function top_down(root, params)** works like this:

```
1. return specific value for null node
2. update the answer if needed                      // answer <-- params
3. left_ans = top_down(root.left, left_params)      // left_params <-- root.val, params
4. right_ans = top_down(root.right, right_params)   // right_params <-- root.val, params 
5. return the answer if needed                      // answer <-- left_ans, right_ans
```

For instance, consider this problem: given a binary tree, find its maximum depth.

We know that the depth of the root node is 1. For each node, if we know its depth, we will know the depth of its children. Therefore, if we pass the depth of the node as a parameter when calling the function recursively, all the nodes will know their depth. And for leaf nodes, we can use the depth to update the final answer. Here is the pseudocode for the recursive function maximum_depth(root, depth):

```
1. return if root is null
2. if root is a leaf node:
3.      answer = max(answer, depth)         // update the answer if needed
4. maximum_depth(root.left, depth + 1)      // call the function recursively for left child
5. maximum_depth(root.right, depth + 1)     // call the function recursively for right chil
```

In order to understand about when use Top-Down solution, we need to answer two questions:
- Can you determine some parameters to help the node know its answer?
- Can you use these parameters and the value of the node itself to determine what should be the parameters passed to its children?

If the answers are both yes, try to solve this problem using a "top-down" recursive solution.

<br>

## Using Bottom-Up solution

**Bottom-up** is another recursive solution. In each recursive call, we will firstly call the function recursively for all the children nodes and then come up with the answer according to the returned values and the value of the current node itself. This process can be regarded as a kind of postorder traversal. Typically, a **Bottom-up** recursive **function bottom_up(root)** will be something like this:

```
1. return specific value for null node
2. left_ans = bottom_up(root.left)          // call function recursively for left child
3. right_ans = bottom_up(root.right)        // call function recursively for right child
4. return answers                           // answer <-- left_ans, right_ans, root.val
```

Let's go on discussing the question about maximum depth but using a different way of thinking: for a single node of the tree, what will be the maximum depth x of the subtree rooted at itself?

If we know the maximum depth l of the subtree rooted at its left child and the maximum depth of the subtree rooted at its right child, can we answer the previous question? Of course yes, we can choose the maximum between them and add 1 to get the maximum depth of the subtree rooted at the current node. That is x = max(l, r) + 1.

It means that for each node, we can get the answer after solving the problem for its children. Therefore, we can solve this problem using a "bottom-up" solution. Here is the pseudocode for the recursive function maximum_depth(root):

```
1. return 0 if root is null                 // return 0 for null node
2. left_depth = maximum_depth(root.left)
3. right_depth = maximum_depth(root.right)
4. return max(left_depth, right_depth) + 1  // return depth of the subtree rooted at root
```

In order to understand about when use Bottom-Up solution, we need to answer question:
- For a node in a tree, if you know the answer of its children, can you calculate the answer of that node?

If the answer is yes, solving the problem recursively using a bottom up approach might be a good idea.


<br>

## Wrapping up

- Understanding about some conditions to use Bottom-up solution and Top-down solution.


<br>

Refer:

[https://leetcode.com/explore/learn/card/data-structure-tree/17/solve-problems-recursively/534/](https://leetcode.com/explore/learn/card/data-structure-tree/17/solve-problems-recursively/534/)