---
layout: post
title: Three sum closet
bigimg: /img/image-header/yourself.jpeg
tags: [Two-Pointers, HashMap]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Two Pointers technique](#using-two-pointers-technique)
- []()
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given an array nums of n integers and an integer target, find three integers in nums such that the sum is closest to target. Return the sum of the three integers. You may assume that each input would have exactly one solution.

```java
Example 1:
    Input: nums = [-1, 2, 1, -4], target = 1
    Output: 2
    Explanation: The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).

Example 2:
    Input: [-3, -1, 1, 2], target = 1
    Output: 0
    Explanation: The triplet [-3, 1, 2] has the closest sum to the target.

Example 3:
    Input: [1, 0, 1, 1], target = 100
    Output: 3
    Explanation: The triplet [1, 1, 1] has the closest sum to the target.

Example 4:
    Input: [1, 2, 4, 8, 16, 32, 64, 128], target = 82
    Output: 82
```

Constraints:
- 3 <= nums.length <= 10^3
- -10^3 <= nums[i] <= 10^3
- -10^4 <= target <= 10^4

<br>

## Using brute force algorithm


```java

```

The complexity of this solution:
- Time complexity: 
- Space complexity: 


<br>

## Using backtracking algorithm


```java

```


The complexity of this solution:
- Time complexity: 
- Space complexity: 

<br>

## Using Two Pointers technique



```java
public static int searchTriplet(int[] nums, int target) {
    int minDistance = Integer.MAX_VALUE;
    Arrays.sort(nums);

    for (int i = 0; i <= nums.length - 3; ++i) {
        int left = i + 1;
        int right = nums.length - 1;

        while (left < right) {
            int diff = target - nums[i] - nums[left] - nums[right];
            if (diff == 0) {
                return target - diff;
            }

            if (Math.abs(diff) < Math.abs(minDistance)) {
                                // || (Math.abs(diff) == Math.abs(minDistance) && diff > minDistance)) {
                minDistance = diff;
            }

            if (diff > 0) { // target > sum
                ++left;
            } else {        // target < sum
                --right;
            }
        }
    }

    return target - minDistance;
}
```

The complexity of this solution:
- Time complexity: O(n^2)
- Space complexity: O(1)

<br>

## Wrapping up




<br>

Refer:

[https://leetcode.com/problems/3sum-closest/](https://leetcode.com/problems/3sum-closest/)