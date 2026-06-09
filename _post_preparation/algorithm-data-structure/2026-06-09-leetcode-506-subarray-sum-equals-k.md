---
layout: post
title: Leetcode 560 - Subarray Sum Equals K
bigimg: /img/image-header/yourself.jpeg
tags: [Prefix Sum, HashMap]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Brute Force](#using-brute-force)
- [Using Prefix Sum + Hash Map](#using-prefix-sum--hash-map)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given an array of integers nums and an integer k, return the total number of subarrays whose sum equals to k.

A subarray is a contiguous non-empty sequence of elements within an array.

Example 1:

- Input: `nums = [1,1,1]`, `k = 2`.
- Output: 2.

Example 2
- Input: `nums = [1,2,3]`, `k = 3`.
- Output: 2.

Constraints:

- `1 <= nums.length <= 2 * 104`.
- `-1000 <= nums[i] <= 1000`.
- `-107 <= k <= 107`.


<br>

## Using Brute Force

In this way, we will use brute force to iterate the sum of all subarrays. Then we will compare it with `k` to count the number of subarrays.

```Java
class Solution {
    public int subarraySum(int[] nums, int k) {
        int count = 0;

        for (int start = 0; start < nums.length; ++start) {
            for (int end = start + 1; end <= nums.length; ++end) {
                int sum = 0;
                for (int i = start; i < end; ++i) {
                    sum += nums[i];
                }

                if (sum == k) {
                    ++count;
                }
            }
        }

        return count;
    }
}
```

The complexity of this solution:

- Time complexity: $O(n^3)$.
- Space complexity: $O(1)$.

When running this solution on the Leetcode, it encounter TLE:

![](../../img/Algorithm/prefix-sum/prefix-sum-1.png)


<br>

## Using Prefix Sum + Hash Map



```Java

```


<br>

## Wrapping up




<br>

Refer:

[560. Subarray Sum Equals K](https://leetcode.com/problems/subarray-sum-equals-k/)