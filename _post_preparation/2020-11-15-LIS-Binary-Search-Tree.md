---
layout: post
title: Longest Increase Sequence with Binary Search Tree
bigimg: /img/path.jpg
tags: [Binary Search Tree]
---



<br>

## Table of Contents
- [Given problem](#given-problem)
- [Using brute force solution](#using-brute-force-solution)
- [Using Binary Search Tree](#using-binary-search-tree)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Given an integer array nums, return the length of the longest strictly increasing subsequence.

A subsequence is a sequence that can be derived from an array by deleting some or no elements without changing the order of the remaining elements. For example, [3,6,2,7] is a subsequence of the array [0,3,1,6,2,2,7].

```java
Example 1:
Input: nums = [10,9,2,5,3,7,101,18]
Output: 4
Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4.

Example 2:
Input: nums = [0,1,0,3,2,3]
Output: 4

Example 3:
Input: nums = [7,7,7,7,7,7,7]
Output: 1
```

Constraints:
- 1 <= nums.length <= 2500
- -10^4 <= nums[i] <= 10^4

<br>

## Using brute force solution



```java
public class Solution {
    public int lengthOfLISIII(int[] nums) {
        int leng = nums.length;
        int[] L = new int[leng];
        int[] tracker = new int[leng];

        for (int i = 1; i < leng; ++i) {
            int lmax = 0;
            int jmax = -1;

            for (int j = 0; j < i; ++j) {
                if (nums[j] < nums[i] && lmax < L[j]) {
                    lmax = L[j];
                    jmax = j;
                }
            }

            L[i] = lmax + 1;
            tracker[i] = jmax;
        }

        return L[leng - 1];
    }
}
```

The complexity of this solution:
- Time complexity: O(n^2) 
- Space complexity: O(2n)


<br>

## Using Binary Search Tree



```java
public class Solution {
    private int currentMax = 1;

    public int lengthOfLISI(int[] nums) {
        LisBst bst = new LisBst();
        int max = 1;
        bst.root = bst.add(nums[0], -1, bst.root);

        for (int i = 1; i < nums.length; ++i) {
            currentMax = 1;
            bst.add(nums[i], -1, bst.root);
            if (currentMax > max) {
                max = currentMax;
            }
        }

        return max;

    }

    private class LisBstNode {
        public int key;
        public int max;
        public int pre;
        public LisBstNode left, right;

        public LisBstNode(int key, int max, int pre, LisBstNode left,
                          LisBstNode right) {
            this.key = key;
            this.max = max;
            this.pre = pre;
            this.left = left;
            this.right = right;
        }
    }

    private class LisBst {
        private LisBstNode root;

        public LisBstNode add(int key, int pre, LisBstNode node) {
            if (node == null) {
                return new LisBstNode(key, currentMax, pre,
                        null, null);
            } else if (key > node.key) {
                if (currentMax < node.max + 1) {
                    currentMax = node.max + 1;
                }

                node.right = this.add(key, node.key, node.right);
            } else {
                node.left = this.add(key, node.key, node.left);
                if (currentMax > node.max) {
                    node.max = currentMax;
                }
            }

            return node;
        }
    }
}
```

The complexity of this solution:
- Time complexity: O(nlogn)
- Space complexity: O(n)

<br>

## Wrapping up

- Beside using Binary Search Tree for improving searching, we can use BST to save the previous states.

- To work with the other ways of this Longest Increasing Subsequence, we can refer to [Longest Increasing Subsequence in medium.com](https://afteracademy.com/blog/longest-increasing-subsequence).

<br>

Refer:

[https://leetcode.com/problems/longest-increasing-subsequence/](https://leetcode.com/problems/longest-increasing-subsequence/)

[https://afteracademy.com/blog/longest-increasing-subsequence](https://afteracademy.com/blog/longest-increasing-subsequence)