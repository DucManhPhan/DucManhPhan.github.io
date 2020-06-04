---
layout: post
title: Search for a range
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search, Array]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force way](#using-brute-force-way)
- [Using binary search](#using-binary-search)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given an array of integers ```nums``` sorted in ascending order, find the starting and ending position of a given ```target``` value.

Your algorithm's runtime complexity must be in the order of ```O(log n)```.

If the ```target``` is not found in the array, return ```[-1, -1]```.

```
Example 1:

Input: nums = [5,7,7,8,8,10], target = 8
Output: [3,4]
Example 2:

Input: nums = [5,7,7,8,8,10], target = 6
Output: [-1,-1]
```

<br>

## Using brute force way

Normally, we need to find the first and last position of the target value in an array. So to find them, we can use linear search for two case:
- To find the first position, search from the left to right.
- To find the last position, search from the right to left.

When we encounter the target value for the first time, stop processing.

Below is the source code this brute force solution.

```java
public int[] searchRange(int[] nums, int target) {
    int lower = lowerBound(nums, target);
    int upper = upperBound(nums, target);

    return new int[]{lower, upper};
}

private int lowerBound(int[] nums, int target) {
    int res = -1;
    for (int i = 0; i < nums.length; ++i) {
        if (nums[i] == target) {
            res = i;
            break;
        }
    }

    return res;
}

private int upperBound(int[] nums, int target) {
    int res = -1;
    for (int i = nums.length - 1; i >= 0; --i) {
        if (nums[i] == target) {
            res = i;
            break;
        }
    }

    return res;
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(1)

<br>

## Using binary search

Before reading about the source code, we can reference the article [How to use binary search](https://ducmanhphan.github.io/2020-03-28-How-to-use-binary-search/) to answer the question What is template I, II, III of binary search.

1. Using Template I of Binary Search

    ```java
    public int[] searchRange(int[] nums, int target) {
        int lower = search(nums, target, false);
        int upper = search(nums, target, true);
        
        return new int[]{lower, upper};
    }
    
    private int search(int[] nums, int target, boolean isUpperBound) {
        int left = 0;
        int right = nums.length - 1;
        int res = -1;
        
        while (left <= right) {
            int mid = left + (right - left)/2;
            
            if (nums[mid] == target) {
                res = mid;
                
                if (isUpperBound) {
                    left = mid + 1;    
                } else {
                    right = mid - 1;    
                }                
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        
        return res;
    }
    ```

2. Using Template II of Binary Search

    ```java
    private int search(int[] nums, int target, boolean isLowerBound) {
        int left = 0;
        int right = nums.length;

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] > target || (isLowerBound && target == nums[mid])) {
                right = mid;
            }
            else {
                left = mid + 1;
            }
        }

        return lo;
    }

    public int[] searchRange(int[] nums, int target) {
        int[] targetRange = {-1, -1};

        int leftIdx = extremeInsertionIndex(nums, target, true);
        if (leftIdx == nums.length || nums[leftIdx] != target) {
            return targetRange;
        }

        targetRange[0] = leftIdx;
        targetRange[1] = extremeInsertionIndex(nums, target, false) - 1;

        return targetRange;
    }
    ``

The complexity of this solution:
- Time complexity: O(log(n)).
- Space complexity: O(1).

<br>

## Wrapping up

- Understanding how to use some templates of Binary Search.
