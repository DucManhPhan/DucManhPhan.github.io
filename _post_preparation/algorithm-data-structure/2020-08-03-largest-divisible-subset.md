---
layout: post
title: Largest Divisible Subset
bigimg: /img/image-header/yourself.jpeg
tags: [Dynamic Programming]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Bottom up Dynamic Programming](#using-bottom-up-dynamic-programming)
- []()
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Given a set of distinct positive integers nums, return the largest subset answer such that every pair (**answer[i]**, **answer[j]**) of elements in this subset satisfies:

```answer[i] % answer[j] == 0```, or ```answer[j] % answer[i] == 0```

If there are multiple solutions, return any of them.

```java
Example 1:
Input: nums = [1,2,3]
Output: [1,2]
Explanation: [1,3] is also accepted.

Example 2:
Input: nums = [1,2,4,8]
Output: [1,2,4,8]
```

Constraints:
- 1 <= nums.length <= 1000
- 1 <= nums[i] <= 2 * 109
- All the integers in nums are unique.

<br>

## Using Bottom up Dynamic Programming

This problem is as same as the Longest Increase Subsequence problem. The difference is that a condition that we need to calculate the max length of the subsequence.

Below is our source code that use Bottom-Up Dynamic programming.

```java
class Solution {
    public List<Integer> largestDivisibleSubset(int[] nums) {
        int[] len = new int[nums.length];
        int[] tracker = new int[nums.length];

        tracker[0] = -1;
        len[0] = 1;

        Arrays.sort(nums);

        for (int i = 1; i < nums.length; ++i) {
            int maxLen = 1;
            int maxIdx = -1;

            for (int j = i - 1; j >= 0; --j) {
                if (nums[i] % nums[j] == 0 && maxLen < len[j] + 1) {
                    maxLen = len[j] + 1;
                    maxIdx = j;
                }
            }

            len[i] = maxLen;
            tracker[i] = maxIdx;
        }

        int maxLength = Arrays.stream(len).max().getAsInt();
        Integer[] res = new Integer[maxLength];
        int maxLengthIdx = IntStream.range(0, len.length)
                                    .reduce((i, j) -> len[i] > len[j] ? i : j)
                                    .getAsInt();
        int curIdx = 0;

        while (maxLengthIdx != -1) {
            res[curIdx] = nums[maxLengthIdx];
            maxLengthIdx = tracker[maxLengthIdx];
            ++curIdx;
        }

        return Arrays.asList(res);
    }
}
```

The complexity of this solution:
- Time complexity:
- Space complexity:

To deal with this problem by using Recursion of Optimal Substructre, or Top-Down Dynamic Programming, we can refer [Longest Increase Subsequence](https://ducmanhphan.github.io/2021-01-25-longest-increase-subsequence/).

<br>

## 





<br>

## Wrapping up




<br>

Refer:

[https://leetcode.com/problems/largest-divisible-subset/](https://leetcode.com/problems/largest-divisible-subset/)