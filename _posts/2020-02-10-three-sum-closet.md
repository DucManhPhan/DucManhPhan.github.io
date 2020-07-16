---
layout: post
title: Three sum closet
bigimg: /img/image-header/yourself.jpeg
tags: [Two-Pointers]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm](#using-brute-force-algorithm)
- [Using backtracking algorithm](#using-backtracking-algorithm)
- [Using Two Pointers technique](#using-two-pointers-technique)
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

In this way, we will use three loop to check sum of three elements.

```java
public static int searchTriplet(int[] arr, int targetSum) {
    int minDistance = Integer.MAX_VALUE;
    for (int i = 0; i < arr.length; ++i) {
        for (int j = i + 1; j < arr.length; ++j) {
            for (int k = j + 1; k < arr.length; ++k) {
                int diff = targetSum - arr[i] - arr[j] - arr[k];
                if (diff == 0) {
                    return targetSum;
                }

                if (Math.abs(diff) < Math.abs(minDistance)) {
                    minDistance = diff;
                }
            }
        }
    }

    return targetSum - minDistance;
}
```

The complexity of this solution:
- Time complexity: O(n^3)
- Space complexity: O(1)


<br>

## Using backtracking algorithm

The idea of this solution is as same as the brute force algorithm that we want to iterate all cases of subarray with 3 elements. Then we will check the difference between a target sum and a current three sum.

```java
public static int searchTriplet(int[] arr, int targetSum) {
    searchTriplet(arr, targetSum, 0, 0, new ArrayList<>());

    return targetSum - smallestDistance;
}

public static void searchTriplet(int[] arr, int targetSum, int sum, int num, List<Integer> triplets) {
    if (triplets.size() == 3) {
        int diff = targetSum - sum;
        if (Math.abs(diff) < Math.abs(smallestDistance)) {
            smallestDistance = diff;
        }

        return;
    }

    for (int i = num; i < arr.length; ++i) {
        triplets.add(arr[i]);
        searchTriplet(arr, targetSum, sum + arr[i], i + 1, triplets);
        triplets.remove(triplets.size() - 1);
    }
}
```


The complexity of this solution:
- Time complexity: O(n * C(k, n))
- Space complexity: O(k)

<br>

## Using Two Pointers technique

This problem is an extension of the problem [Two Sum](). Then, we can apply Two-Pointers technique with **a + b = -c**.

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

- Understanding how to apply the two-pointers technique.


<br>

Refer:

[https://leetcode.com/problems/3sum-closest/](https://leetcode.com/problems/3sum-closest/)