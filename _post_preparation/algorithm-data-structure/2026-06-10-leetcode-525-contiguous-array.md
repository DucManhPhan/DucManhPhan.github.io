---
layout: post
title: Leetcode 525 - Contiguous Array
bigimg: /img/image-header/yourself.jpeg
tags: []
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Brute Force](#using-brute-force)
- [Using Prefix Sum](#using-prefix-sum)
- []()
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a binary array `nums`, return the maximum length of a contiguous subarray with an equal number of `0` and `1`.

Example 1:
- Input: `nums = [0,1]`.
- Output: `2`.
- Explanation: `[0, 1]` is the longest contiguous subarray with an equal number of `0` and `1`.

Example 2:
- Input: `nums = [0,1,0]`.
- Output: `2`.
- Explanation: `[0, 1]` (or `[1, 0]`) is a longest contiguous subarray with equal number of `0` and `1`.

Example 3:
- Input: `nums = [0,1,1,1,1,1,0,0,0]`.
- Output: `6`.
- Explanation: `[1,1,1,0,0,0]` is the longest contiguous subarray with equal number of `0` and `1`.

Constraints:

- `1 <= nums.length <= 10^5`.
- `nums[i]` is either `0` or `1`.


<br>

## Using Brute Force






<br>

## Using Prefix Sum

```Java
class Solution {
    public int findMaxLength(int[] nums) {
                for (int i = 0; i < nums.length; ++i) {
            if (nums[i] == 0) {
                nums[i] = -1;
            }
        }

        int[] prefixSum = new int[nums.length + 1];
        for (int i = 0; i < nums.length; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        Map<Integer, Integer> mp = new HashMap<>();
        int maxLength = 0;

        for (int i = 0; i < prefixSum.length; ++i) {
            int currentSum = prefixSum[i];

            if (mp.containsKey(currentSum)) {
                maxLength = Math.max(maxLength, i - mp.get(currentSum));
            }

            mp.putIfAbsent(currentSum, i);
        }

        return maxLength;
    }
}
```



<br>

## Wrapping up




<br>

Refer:

[525. Contiguous Array](https://leetcode.com/problems/contiguous-array/description/)
