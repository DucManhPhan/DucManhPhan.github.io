---
layout: post
title: Leetcode 540 - Single Element in a Sorted Array
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute-force algorithm](#using-brute-force-algorithm)
- [Using XOR bitwise operator](#using-xor-bitwise-operator)
- [Using Binary Search algorithm](#using-binary-search-algorithm)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

You are given a sorted array consisting of only integers where every element appears exactly twice, except for one element which appears exactly once.

Return the single element that appears only once.

Your solution must run in `O(log n)` time and `O(1)` space.

Example 1:
- Input: nums = `[1,1,2,3,3,4,4,8,8]`
- Output: 2

Example 2:
- Input: nums = `[3,3,7,7,10,11,11]`
- Output: 10

Constraints:
- `1 <= nums.length <= 105`
- `0 <= nums[i] <= 105`


<br>

## Using brute-force algorithm






<br>

## Using XOR bitwise operator

When reading the problem statement, the property of elements is that each element appears twice. To take advantage of this property, we can use XOR bitwise operator for all elements. Just because applying two same elements with XOR operator will be 0.

To understand why we have this property, we need to look at the formulation:
- 1 + 1 = 0
- 0 + 0 = 0
- 0 + 1 = 1
- 1 + 0 = 1

For example: 3 = 1100 => 1100 + 1100 = 0000

Below is our source code:

```Java
class Solution {
    public int singleNonDuplicate(int[] nums) {
        int singleNum = 0;
        for (int i : nums) {
            singleNum ^= i;
        }
        
        return singleNum;
    }
}
```

The complexity of this solution is:
- Time complexity: `O(n)`.
- Space complexity: `O(1)`.


<br>

## Using Binary Search algorithm





<br>

## Wrapping up




<br>

Refer:

[540. Single Element in a Sorted Array](https://leetcode.com/problems/single-element-in-a-sorted-array/description/)
