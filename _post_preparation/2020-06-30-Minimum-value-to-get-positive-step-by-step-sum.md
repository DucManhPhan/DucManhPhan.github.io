---
layout: post
title: Minimum value to get positive step by step sum
bigimg: /img/image-header/yourself.jpeg
tags: [Prefix Sum, Binary Search]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm](#using-brute-force-algorithm)
- [Using prefix sum technique](#using-prefix-sum-technique)
- [Using binary search algorithm](#using-binary-search-algorithm)
- [Using Kadane algorithm](#using-kadane-algorithm)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given an array of integers nums, you start with an initial positive value ```startValue```.

In each iteration, you calculate the step by step sum of ```startValue``` plus elements in nums (from left to right).

Return the minimum positive value of ```startValue``` such that the step by step sum is never less than 1.

```
Example 1:
Input: nums = [-3,2,-3,4,2]
Output: 5
Explanation: If you choose startValue = 4, in the third iteration your step by step sum is less than 1.
                step by step sum
                startValue = 4 | startValue = 5 | nums
                  (4 -3 ) = 1  | (5 -3 ) = 2    |  -3
                  (1 +2 ) = 3  | (2 +2 ) = 4    |   2
                  (3 -3 ) = 0  | (4 -3 ) = 1    |  -3
                  (0 +4 ) = 4  | (1 +4 ) = 5    |   4
                  (4 +2 ) = 6  | (5 +2 ) = 7    |   2

Example 2:
Input: nums = [1,2]
Output: 1
Explanation: Minimum start value should be positive.

Example 3:
Input: nums = [1,-2,-3]
Output: 5

Constraints:
1 <= nums.length <= 100
-100 <= nums[i] <= 100
```

<br>

## Using brute force algorithm

From the requirements, we can find that the step by step sum of the **startValue** and all elements of an array is never less than 1.

So, we will choose the initial value of **startValue** = 1.

For each sum of **startValue** and elements of an array is less than 1, exit the loop. Otherwise, immediately return the value of **startValue**.

```java 
public int minStartValue(int[] nums) {
    int minStartValue = 1;

    while (true) {
        int startValue = minStartValue;
        boolean isMinValue = true;
        for (int i = 0; i < nums.length; ++i) {
            startValue += nums[i];
            if (startValue < 1) {
                isMinValue = false;
                break;
            }
        }

        if (isMinValue) {
            return minStartValue;
        }

        ++minStartValue;
    }
}
```


<br>

## Using prefix sum technique

Before jump directly into source code of this section, we need to read an article about [Prefix sum](https://ducmanhphan.github.io/2019-06-30-Prefix-sum/).

The idea here is that we will calculate the sum of elements at specific index, then we will find the minimum sum in prefix sum array. 

And the minimum value of start value that satisfies **start value + minimum sum = 1**.

```java
public int minStartValue(int[] nums) {
    int[] prefixSum = new int[nums.length];
    prefixSum[0] = nums[0];
    int minSum = prefixSum[0];

    for (int i = 1; i < nums.length; ++i) {
        prefixSum[i] += prefixSum[i - 1] + nums[i];
        minSum = Math.min(minSum, prefixSum[i]);
    }

    return 1 - minSum < 1 ? 1 : 1 - minSum;
}
```



<br>

## Using binary search algorithm

Our idea is that we need to find the value of **startValue** variable from 1 to N. It means that its value is belong to a sorted array. So we can use Binary Search for this problem.

```java

```


<br>

## Using Kadane algorithm


```java

```


<br>

## Wrapping up

- Identify some particular traits to apply algorithms, techniques such as prefix sum, binary search, kadane algorithm. 

<br>

Refer:

[https://leetcode.com/problems/minimum-value-to-get-positive-step-by-step-sum/](https://leetcode.com/problems/minimum-value-to-get-positive-step-by-step-sum/)