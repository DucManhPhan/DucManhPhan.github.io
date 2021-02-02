---
layout: post
title: Longest Increase Subsequence
bigimg: /img/path.jpg
tags: [Binary Search Tree, Dynamic Programming]
---



<br>

## Table of Contents
- [Given problem](#given-problem)
- [Using Recursion](#using-recursion)
- [Using Top-Down approach in DP](#using-top-down-approach-in-dp)
- [Using Bottom-up approach in DP](#using-bottom-up-approach-in-dp)
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

## Using Recursion

To use recursion to list all cases, this problem is the same as the 0/1 Knapsack. So, we have its source code:

```java
public class Solution {
    public int lengthOfLISII(int[] nums) {
        return this.maxLengthSubset(nums, -1, 0);
    }

    public int maxLengthSubset(int[] nums, int prevElement, int currentIdx) {
        if (currentIdx == nums.length) {
            return 0;
        }

        int includedElemMaxLenSubset = 1;
        if (prevIdx <0 || nums[prevIdx] < nums[currentIdx]) {
            includedElemMaxLenSubset = 1 + this.maxLengthSubset(nums, currentIdx, currentIdx + 1);
        }

        int excludedElemMaxLenSubset = this.maxLengthSubset(nums, prevIdx, currentIdx + 1);
        return Math.max(includedElemMaxLenSubset, excludedElemMaxLenSubset);
    }
}
```

The complexity of this solution:
- Time complexity: O(2^n)
- Space complexity: O(n^2)

<br>

## Using Top-Down approach in DP

Based on the [Using Recursion](#using-recursion) approach, we can use memorization to optimize the recomputing. 

```java
public class Solution {
    public int lengthOfLIS(int[] nums) {
        int[][] dp = new int[nums.length + 1][nums.length];
        for (int[] arr : dp) {
            Arrays.fill(arr, -1);
        }

        return this.lengthOfLISIV(nums, -1, 0, dp);
    }

    public int lengthOfLIS(int[] nums, int preIdx, int currentIdx, int[][] dp) {
        if (currentIdx == nums.length) {
            return 0;
        }

        if (dp[preIdx + 1][currentIdx] >= 0) {
            return dp[preIdx + 1][currentIdx];
        }

        int includedElemMaxLenSubset = 1;
        if (preIdx < 0 || nums[preIdx] < nums[currentIdx]) {
            includedElemMaxLenSubset = 1 + this.lengthOfLISIV(nums, currentIdx, currentIdx + 1, dp);
        }

        int excludedElemMaxLenSubset = this.lengthOfLISIV(nums, preIdx, currentIdx + 1, dp);
        dp[preIdx + 1][currentIdx] = Math.max(includedElemMaxLenSubset, excludedElemMaxLenSubset);
        
        return dp[preIdx + 1][currentIdx];
    }
}
```

The complexity of this solution:
- Time complexity: O(n^2)
- Space complexity: O(n^2)

<br>

## Using Bottom-up approach in DP

Below is the source code of bottom-up approach in Dynamic programming.

```java
public class Solution {
    public int lengthOfLIS(int[] nums) {
        int leng = nums.length;
        int[] L = new int[leng];     // save the longest length of the subset at i index
        L[0] = 1;

        int[] tracker = new int[leng];  // save the previous index of an element to T[i]
        Arrays.fill(tracker, -1);

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

        this.printSubsequence(nums, L, tracker);

        return Arrays.stream(L).max().getAsInt();
    }

    public void printSubsequence(int[] nums, int[] L, int[] tracker) {
        int idxMaxElem = IntStream.range(0, L.length)
                                  .reduce((i, j) -> L[i] < L[j] ? j : i)
                                  .getAsInt();
        int i = idxMaxElem;
        int j = 0;

        while (true) {
            System.out.println(nums[i]);
            j = tracker[i];

            if (j == -1) break;
            i = j;
        }
    }
}
```

The complexity of this solution:
- Time complexity: O(n^2) 
- Space complexity: O(2n)

<br>

## Using Binary Search Tree

Due to save the previous state obout the length of the subset, instead of using an array, we can use Binary Search Tree to deal with it. So, below is the source code that describes the usage of Binary Search Tree.

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

[https://www.geeksforgeeks.org/longest-increasing-subsequence-using-longest-common-subsequence-algorithm/?ref=rp](https://www.geeksforgeeks.org/longest-increasing-subsequence-using-longest-common-subsequence-algorithm/?ref=rp)