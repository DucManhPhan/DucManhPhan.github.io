---
layout: post
title: Leetcode 1351 - Count Negative Numbers in a Sorted Matrix
bigimg: /img/image-header/yourself.jpeg
tags: [Java, Hibernate]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute-force solution](#using-brute-force-solution)
- [Using Binary Search algorithm](#using-binary-search-algorithm)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a `m x n` matrix `grid` which is sorted in non-increasing order both row-wise and column-wise, return the number of negative numbers in `grid`.

```
Example 1:
Input: grid = [[4,3,2,-1],[3,2,1,-1],[1,1,-1,-2],[-1,-1,-2,-3]]
Output: 8
Explanation: There are 8 negatives number in the matrix.

Example 2:
Input: grid = [[3,2],[1,0]]
Output: 0
```

Constraints:
- `m == grid.length`
- `n == grid[i].length`
- `1 <= m, n <= 100`
- `-100 <= grid[i][j] <= 100`


<br>

## Using brute-force solution

The first idea is that we will use brute-force solution to iterate all elements in this `grid` matrix. Then, check whether this element is negative element or not.

```java
class Solution {
    public int countNegatives(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        
        int countNegative = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] < 0) {
                    ++countNegative;
                }
            }
        }
        
        return countNegative;
    }
}
```

The complexity of this solution:
- Time complexity: O(m * n)
- Space complexity: O(1)


<br>

## Using Binary Search algorithm





<br>

## Wrapping up




<br>

Refer:

[1351. Count Negative Numbers in a Sorted Matrix](https://leetcode.com/problems/count-negative-numbers-in-a-sorted-matrix/)
