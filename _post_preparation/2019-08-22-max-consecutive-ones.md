---
layout: post
title: Max consecutive Ones 
bigimg: /img/image-header/unsplash.jpg
tags: [Sliding Window]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm](#using-brute-force-algorithm)
- [Using Sliding Window technique](#using-sliding-window-technique)
- [Wrappng up](#wrapping-up)


<br>

## Given problem

Given a binary array, find the maximum number of consecutive 1s in this array.

```
Example 1:
    Input: [1,1,0,1,1,1]
    Output: 3

Explanation:
        The first two digits or the last three digits are consecutive 1s.
        The maximum number of consecutive 1s is 3.

```

Note:
- The input array will only contain 0 and 1.
- The length of input array is a positive integer and will not exceed 10,000



<br>

## Using brute force algorithm





<br>

## Using Sliding Window technique


    ```java
    public int findMaxConsecutiveOnes(int[] nums) {
        int length = nums.length;
        int maxLength = 0;
        int windowStart = 0;    // always point to the index of current element with value 1

        for (int windowEnd = 0; windowEnd < length; ++windowEnd) {
            if (nums[windowEnd] != 1) {
                windowStart = windowEnd;
                ++windowStart;
            }

            maxLength = Math.max(maxLength, windowEnd - windowStart + 1);
        }

        return maxLength;
    }
    ```



<br>

## Wrapping up






<br>

Refer:


[https://leetcode.com/problems/max-consecutive-ones/](https://leetcode.com/problems/max-consecutive-ones/)
