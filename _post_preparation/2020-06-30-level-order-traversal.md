---
layout: post
title: Level Order Traversal
bigimg: /img/image-header/yourself.jpeg
tags: [Tree]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using recursive version](#using-recursive-version)
- [Using iterative version](#using-iterative-version)
- [When to use](#when-to-use)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a binary tree, return the level order traversal of its node's value.

![](../img/Data-structure/binary-tree/traversal/sample-binary-tree.png)

The output of the above binary tree is:

```java
1 --> 2 --> 3 --> 4 --> 5 --> 6 --> 7
```

<br>

## Using recursive version

1. First way

    Belows are some steps that we use.
    - The first action we need to do is to calculate the maximum level of the tree.

    - After we had the tree's maximum level, we will iterate from level 1 to the maximum level, then get all elements of each level.

    ```java
    public class MaxLevelTraversal {

        private static int maxLevel = Integer.MIN_VALUE;

        public static List<Integer> levelOrderTraversal(TreeNode root) {
            List<Integer> nodes = new ArrayList<>();
            getMaxLevelTopDown(root, 1);

            for (int level = 1; level <= maxLevel; ++level) {
                getNodesInSameLevel(root, level, 1, nodes);
            }

            return nodes;
        }

        public static void getNodesInSameLevel(TreeNode root, int currentLevel, int level, List<Integer> nodes) {
            if (root == null) {
                return;
            }

            if (level == currentLevel) {
                nodes.add(root.val);
            }

            getNodesInSameLevel(root.left, currentLevel, level + 1, nodes);
            getNodesInSameLevel(root.right, currentLevel, level + 1, nodes);
        }

        private static void getMaxLevelTopDown(TreeNode root, int level) {
            if (root == null) {
                return;
            }

            if (root.left == null && root.right == null) {
                maxLevel = Math.max(maxLevel, level);
            }

            getMaxLevelTopDown(root.left, level + 1);
            getMaxLevelTopDown(root.right, level + 1);
        }
    }
    ```

2. Second way

    We will use hashmap to save nodes at each level.

    ```java
    public class MaxLevelTraversal {

        private static Map<Integer, List<Integer>> nodesPerLevel = new HashMap<>();

        public static List<Integer> levelOrderTraversalRecursiveVersion1(TreeNode root) {
            recursiveVersion(root, 0);

            // convert hash map to list
            if (nodesPerLevel.isEmpty()) {
                return Collections.emptyList();
            }

            return nodesPerLevel.values().stream()
                                .flatMap(valNodes -> Stream.of(valNodes.toArray()))
                                                           .map(value -> (Integer) value)
                                .collect(Collectors.toList());
        }

        public static void recursiveVersion(TreeNode root, int level) {
            if (root == null) {
                return;
            }

            if (nodesPerLevel.size() == level) {
                nodesPerLevel.put(level, new ArrayList<>());
            }

            // add the value of current node with the same level
            nodesPerLevel.get(level).add(root.val);

            recursiveVersion(root.left, level + 1);
            recursiveVersion(root.right, level + 1);
        }
    ```

<br>

## Using iterative version

In this version, we will use **Queue** to save the children nodes of the current node.

```java

```


<br>

## When to use

- When we want to work with the nodes that are in the same level such as applying in the peer-to-peer network, ...

<br>

## Wrapping up




<br>

Refer:

[https://www.geeksforgeeks.org/level-order-tree-traversal/](https://www.geeksforgeeks.org/level-order-tree-traversal/)

[https://leetcode.com/problems/binary-tree-level-order-traversal/](https://leetcode.com/problems/binary-tree-level-order-traversal/)

[https://www.educative.io/m/level-order-traversal-binary-tree](https://www.educative.io/m/level-order-traversal-binary-tree)