---
layout: post
title: Leetcode 153 - Find Minimum in Rotated Sorted Array
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

Suppose an array of length n sorted in ascending order is rotated between 1 and n times. For example, the array nums = [0,1,2,4,5,6,7] might become:
- `[4,5,6,7,0,1,2]` if it was rotated 4 times.
- `[0,1,2,4,5,6,7]` if it was rotated 7 times.

Notice that rotating an array `[a[0], a[1], a[2], ..., a[n-1]]` 1 time results in the array `[a[n-1], a[0], a[1], a[2], ..., a[n-2]]`.

Given the sorted rotated array nums of `unique` elements, return the minimum element of this array.

You must write an algorithm that runs in `O(log n)` time.

Example 1:

Input: nums = [3,4,5,1,2]
Output: 1
Explanation: The original array was [1,2,3,4,5] rotated 3 times.
Example 2:

Input: nums = [4,5,6,7,0,1,2]
Output: 0
Explanation: The original array was [0,1,2,4,5,6,7] and it was rotated 4 times.
Example 3:

Input: nums = [11,13,15,17]
Output: 11
Explanation: The original array was [11,13,15,17] and it was rotated 4 times. 
 

Constraints:
- `n == nums.length`
- `1 <= n <= 5000`
- `-5000 <= nums[i] <= 5000`
- All the integers of nums are `unique`.
- nums is sorted and rotated between 1 and n times.


<br>

## Using Binary Search algorithm

1. Using Template #1

    ```java
    class Solution {
        public int findMin(int[] arr) {
            int len = arr.length;
            int left = 0;
            int right = len - 1;

            while (left <= right) {
                if (arr[left] <= arr[right]) {  // Case 1: sorted array
                    return arr[left];
                }

                int mid = left + (right - left) / 2;
                int next = (mid + 1) % len;
                int prev = (mid + len - 1) % len;
                if (arr[mid] <= arr[next] && arr[mid] <= arr[prev]) {   // Case 2: mid index points to the minimum element
                    return arr[mid];
                } else if (arr[mid] <= arr[right]) {    // Case 4
                    right = mid - 1;
                } else if (arr[mid] >= arr[left]) {     // Case 3
                    left = mid + 1;
                }
            }

            return -1;
        }
    }
    ```

2. Using Template #2

    ```java
    class Solution {
        public int findMin(int[] nums) {
            if (nums == null) {
                return -1;
            }

            int left = 0;
            int right = nums.length - 1;

            while (left < right) {
                int mid = left + (right - left) / 2;

                if (nums[mid] > nums[right]) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }

            return nums[left];
        }
    }
    ```

3. Using Template #3

    ```java
    class Solution {
        public int findMin(int[] nums) {
            int low = 0;
            int high = nums.length - 1;
            
            while (low + 1 < high) {
                int mid = low + (high - low) / 2;
                
                if (nums[mid] > nums[high]) {
                    low = mid;
                } else {
                    high = mid;
                }
            }
            
            return nums[low] < nums[high] ? nums[low] : nums[high];
        }
    }
    ```

The complexity of this solution:
- Time complexity: O(logn)
- Space complexity: O(1)


<br>

## Wrapping up

- Understanding how to use some templates of Binary Search algorithm.


<br>

Refer:

[153. Find Minimum in Rotated Sorted Array](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/)