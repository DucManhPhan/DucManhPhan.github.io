---
layout: post
title: Search insert position
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Binary Search algorithm](#using-binary-search-algorithm)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a sorted array and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

You may assume no duplicates in the array.

Below is an test case for this problem.

```java
Example 1:

Input: [1,3,5,6], 5
Output: 2
Example 2:

Input: [1,3,5,6], 2
Output: 1
Example 3:

Input: [1,3,5,6], 7
Output: 4
Example 4:

Input: [1,3,5,6], 0
Output: 0
```

<br>

## Using Binary Search algorithm

Our array is sorted, so we can apply Binary Search algorithm to deal with it.

Below is the source code that using Binary Search algorithm.

```java
public int searchInsert(int[] nums, int target) {
    int left = 0;
    int right = nums.length - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (nums[mid] == target) {
            return mid;
        } else if (nums[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return left;
}
```

The complexity of this way:
- Time complexity: O(log(n))
- Space complexity: O(1)

<br>

## Wrapping up

- Apply Binary Search algorithm when we have sorted array.

