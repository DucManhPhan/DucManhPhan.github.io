---
layout: post
title: Leetcode 441 - Arranging Coins
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm](#using-brute-force-algorithm)
- [Using Binary Search algorithm](#using-binary-search-algorithm)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Using brute force algorithm

With this problem, we only need to calculate the number of rows that contains the full coins. If the specific row includes the number coins that is less than the default coin of that row, break it.

```Java
class Solution {
    public int arrangeCoins(int n) {
        if (n == 1) {
            return n;
        }

        int coin = 1;
        int remaining = n;

        while (remaining >= 0) {
            if (remaining < coin) {
                return --coin;
            }

            remaining -= coin;
            ++coin;
        }

        return -1;
    }
}
```

The complexity of this solution:
- Time complexity: `O(n)`.
- Space complexity: `O(1)`.


<br>

## Using Binary Search algorithm

0. Idea



1. Reproduce the staircase array that contains `k` coins on `kth` row. Using Binary Search on this array.



2. Only using Binary Search.




<br>

## Wrapping up




<br>

Refer:

[441. Arranging Coins](https://leetcode.com/problems/arranging-coins/description/)
