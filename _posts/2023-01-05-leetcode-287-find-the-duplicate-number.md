---
layout: post
title: Leetcode 287 - Find The Duplicate Number
bigimg: /img/image-header/yourself.jpeg
tags: [Array]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Cyclic Sort](#using-cyclic-sort)
- [Using marker points](#using-marker-points)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given an array of integers `nums` containing `n + 1` integers where each integer is in the range `[1, n]` inclusive.

There is only one repeated number in `nums`, return this repeated number.

You must solve the problem without modifying the array `nums` and uses only constant extra space.

- Example 1

    - Input: nums = `[1,3,4,2,2]`
    - Output: 2

- Example 2

    - Input: nums = `[3,1,3,4,2]`
    - Output: 3

- Constraints:

    - `1 <= n <= 105`
    - `nums.length == n + 1`
    - `1 <= nums[i] <= n`
    - All the integers in nums appear only once except for precisely one integer which appears two or more times.

- Follow up:

    - How can we prove that at least one duplicate number must exist in nums?
    - Can you solve the problem in linear runtime complexity?


<br>

## Using Cyclic Sort

Currently, we will use cyclic sort to solve this issue.

```Java
class Solution {
    public int findDuplicate(int[] nums) {
        int size = nums.length;
        int start = 0;

        while (start < size) {
            int current = nums[start] - 1;

            if (nums[start] != nums[current]) {
                swap(nums, start, current);
            } else {
                ++start;
            }
        }

        for (int i = 0; i < size; ++i) {
            if (nums[i] != i + 1) {
                return nums[i];
            }
        }

        return size;
    }

    private void swap(int[] nums, int i, int j) {
        int tmp = nums[i];
        nums[i] = nums[j];
        nums[j] = tmp;
    }
}
```

But we can improve it by only need to check on the first loop, instead of using a new loop.

```Java
class Solution {
    public int findDuplicate(int[] nums) {
        int size = nums.length;
        int start = 0;

        while (start < size) {
            int current = nums[start] - 1;

            if (nums[start] != start + 1) {
                if (nums[start] != nums[current]) {
                    swap(nums, start, current);
                } else {
                    return nums[start];
                }
            } else {
                ++start;
            }
        }

        return -1;
    }

    private void swap(int[] nums, int i, int j) {
        int tmp = nums[i];
        nums[i] = nums[j];
        nums[j] = tmp;
    }
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(1)


<br>

## Using marker points

In this solution, we will mark the value at `nums[i] - 1` position as its negative value. If we encounter the duplicated element, the value at `nums[i] - 1` position will be less than 0. Then, we can break our loop, simply because there's only one duplicated element from our problem.

Below is the source code of this solution:

```Java
class Solution {
    public int findDuplicate(int[] nums) {
        int duplicate = -1;

        for (int i = 0; i < nums.length; ++i) {
            int val = (nums[i] < 0 ? -nums[i] : nums[i]);
            if (nums[val - 1] >= 0) {
                nums[val - 1] = -nums[val - 1];
            } else {
                duplicate = val;
                break;
            }
        }

        for (int i = 0; i < nums.length; ++i) {
            if (nums[i] < 0) {
                nums[i] = -nums[i];
            }
        }

        return duplicate;
    }
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(1)


<br>

## Wrapping up




<br>

Refer:

[287. Find the Duplicate Number](https://leetcode.com/problems/find-the-duplicate-number)