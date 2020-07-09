---
layout: post
title: Postorder traversal in Binary Tree
bigimg: /img/image-header/yourself.jpeg
tags: [Tree]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using recursive version](#using-recursive-version)
- [Using iterative version](#using-iterative-version)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a binary tree, return the postorder traversal of its nodes' values.

```
Example:

Input: [1,null,2,3]
   1
    \
     2
    /
   3

Output: [3,2,1]
```


<br>

## Using recursive version


```java
class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;

    TreeNode() {
        // nothing to do
    }

    TreeNode(int val) {
        this.val = val;
    }

    TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

public static void postorderTraversal(TreeNode root, List<Integer> res) {
    if (root == null) {
        return;
    }

    postorderTraversal(root.left, res);
    postorderTraversal(root.right, res);
    res.add(root.val);
}
```

The complexity of this version:
- Time complexity: O(n)
- Space complexity: O(n)


<br>

## Using iterative version

1. Using one stack but marking when the current node is right or not.

    In this version, we will follow by some steps:
    - push the root node and the right node into the stack, but the root node will be pushed first, then the right node.

    - but we need to differentiate between the root node and the right node by using the additional class that contains two fields that contains TreeNode's instance and boolean variable with ```false``` - the root node, ```true``` - the right node.

    ```java
    class TreeNodeState {
        TreeNode node;
        boolean isRightNode;

        TreeNodeState(TreeNode node, boolean isRightNode) {
            this.node = node;
            this.isRightNode = isRightNode;
        }
    }

    public List<Integer> postorderTraversal(TreeNode root) {
        List<Integer> res = new ArrayList<>();
        Stack<TreeNodeState> stk = new Stack<>();
        stk.push(new TreeNodeState(null, false));   // mark the end of stack

        TreeNode tmp = root;
        boolean isRightNode = true;

        do {
            while (tmp != null && isRightNode) {
                TreeNodeState stateRoot = new TreeNodeState(tmp, false);
                stk.push(stateRoot);

                if (tmp.right != null) {
                    TreeNodeState stateRight = new TreeNodeState(tmp.right, true);
                    stk.push(stateRight);
                }

                tmp = tmp.left;
            }

            if (tmp != null) {
                res.add(tmp.val);
            }

            TreeNodeState poppedNode = stk.pop();
            tmp = poppedNode.node;
            isRightNode = poppedNode.isRightNode;
        } while (tmp != null);

        return res;
    }
    ```

<br>

## Wrapping up

- Understanding about using stack with postorder traversal.
