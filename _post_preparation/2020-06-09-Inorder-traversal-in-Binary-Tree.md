---
layout: post
title: Inorder traversal in Binary Tree
bigimg: /img/image-header/yourself.jpeg
tags: [Data Structure]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using recursive version](#using-recursive-version)
- [Using iterative version](#using-iterative-version)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a binary tree, return the inorder traversal of its nodes' values.

```
For example: 
Input: [1,null,2,3]
   1
    \
     2
    /
   3

Output: [1,3,2]
```


<br>

## Using recursive version 


```java
public void inorderTraversal(TreeNode root, List<Integer> res) {
    if (root == null) {
        return;
    }

    inorderTraversal(root.left, res);
    res.add(root.val);
    inorderTraversal(root.right, res);
}
```


<br>

## Using iterative version

Some steps for the iterative version:
- First, we will get all elements from the left side of the specific element.
- 
- 

Below is the source code for this version.

```java
public List<Integer> inorderTraversal(TreeNode root) {
    List<Integer> res = new ArrayList<>();
    Stack<TreeNode> stk = new Stack<>();
    TreeNode tmp = root;
    boolean isContinue = true;

    do {
        // get the left side
        while (tmp != null) {
            stk.push(tmp);
            tmp = tmp.left;
        }

        // goes with right side
        if (stk.size() > 0) {
            tmp = stk.pop();
            res.add(tmp.val);

            tmp = tmp.right;
            isContinue = true;
        } else {
            isContinue = false;
        }
    } while (isContinue);

    return res;
}
```


<br>

## Wrapping up




<br>

Refer:

