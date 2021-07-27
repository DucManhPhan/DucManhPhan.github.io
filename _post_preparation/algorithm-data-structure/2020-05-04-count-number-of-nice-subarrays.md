---
layout: post
title: Count number of nice subarrays
bigimg: /img/path.jpg
tags: [Two-Pointers, Prefix Sum]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm](#using-brute-force-algorithm)
- [Using two-pointers technique](#using-two-pointers-technique)
- [Using prefix sum](#using-prefix-sum)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given an array of integers nums and an integer k. A subarray is called nice if there are k odd numbers on it.

Return the number of nice sub-arrays.

```java
Example 1:
    Input: nums = [1,1,2,1,1], k = 3
    Output: 2
    Explanation: The only sub-arrays with 3 odd numbers are [1,1,2,1] and [1,2,1,1].

Example 2:
    Input: nums = [2,4,6], k = 1
    Output: 0
    Explanation: There is no odd numbers in the array.

Example 3:
    Input: nums = [2,2,2,1,2,2,1,2,2,2], k = 2
    Output: 16

Constraints:
    1 <= nums.length <= 50000
    1 <= nums[i] <= 10^5
    1 <= k <= nums.length
```

<br>

## Using brute force algorithm

Because we need to calculate the odd elements based on **k** value on an array, so we will use **k** as an initial size of the subarray, and increment it step by step.

```java
public int numberOfSubarrays(int[] nums, int k) {
    int numberOfSub = 0;
    for (int sizeSub = k; sizeSub <= nums.length; ++sizeSub) {
        for (int start = 0; start <= nums.length - sizeSub; ++start) {
            int count = k;

            for (int i = start; i < start + sizeSub; ++i) {
                if (nums[i] % 2 == 1) {
                    --count;
                }
            }

            if (count == 0) {
                ++numberOfSub;
            }
        }
    }

    return numberOfSub;
}
```

The complexity of this solution:
- Time complexity: O(n^3)
- Space complexity: O(1)

The maximum length of an array is **5 * 10^4**. So, it is 125 * 10^12 --> the time to execute this solution is approximately 125.000 second --> Time Limit Exceeded.

<br>

## Using two-pointers technique






<br>

## Using prefix sum




<br>

## Wrapping up



<br>

Refer:

[https://leetcode.com/problems/count-number-of-nice-subarrays/](https://leetcode.com/problems/count-number-of-nice-subarrays/)