---
layout: post
title: Kadane algorithm
bigimg: /img/image-header/yourself.jpeg
tags: [Algorithm, Array]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm](#using-brute-force-algorithm)
- [Using Kadane algorithm](#using-kadane-algorithm)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Assuming that we have an array like the below:

```
[-2, -3, 4, -1, -2, 1, 5, -3]
```

Our problem is to find the largest sum of the contiguous subarray.

Below is our analysis for this problem:
- Elements can be negative, positive, zero numbers.
- Our subarray is contiguous and it has only one property that is relevant to this subarray: largest sum.

    We can not apply the Sliding Window technique independently to this problem because we do not determine the boundary of this subarray to increase the value of windowStart variable.

- Our subarray is contiguous, so the simple solution is to iterate all the sequence elements. 
- Finally, we have two solution:

    - Using brute force algorithm.
    - Using Kadane algorithm.

<br>

## Using brute force algorithm

To use brute force algorithm for this problem, we can refer this article [https://ducmanhphan.github.io/2020-02-25-Some-ways-to-use-brute-force-algorithm/](https://ducmanhphan.github.io/2020-02-25-Some-ways-to-use-brute-force-algorithm/).

The complexity of this algorithm:
- Time complexity: O(n^3)
- Space complexity: O(1)

<br>

## Using Kadane algorithm

The idea of Kadane algorithm is to keep track of the positive elements and its sum. Then, comparing that sum with the maximum sum of the contiguous elements to get the largest sum. When the current sum of subarray is less than 0, that sum will be equal to 0.

```java
public static int maxSubArray(int[] nums) {
    int len = nums.length;
    int max = Integer.MIN_VALUE;
    int sum = 0;

    for (int i = 0; i < len; ++i) {
        sum += nums[i];
        max = Math.max(max, sum);
        sum = Math.max(sum, 0);
    }

    return max;
}
```

The complexity of this algorithm:
- Time complexity: O(n)
- Space complexity: O(1)


<br>

## Wrapping up

- Understanding about our case to apply Kadane algorithm.

