---
layout: post
title: Leetcode 448 - Find All Numbers Disappeared in an Array
bigimg: /img/image-header/yourself.jpeg
tags: [Array]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Cyclic Sort](#using-cyclic-sort)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given an array nums of `n` integers where `nums[i]` is in the range `[1, n]`, return an array of all the integers in the range `[1, n]` that do not appear in nums.

- Example 1:

    - Input: nums = `[4,3,2,7,8,2,3,1]`
    - Output: `[5,6]`

- Example 2:

    - Input: nums = `[1,1]`
    - Output: `[2]`

- Constraints:

    - `n == nums.length`
    - `1 <= n <= 105`
    - `1 <= nums[i] <= n`

Follow up: Could you do it without extra space and in `O(n)` runtime? You may assume the returned list does not count as extra space.


<br>

## Using Cyclic Sort

To know more other ways to solve this issue, we can refer to the following article [Leetcode 268 - Missing Number](https://ducmanhphan.github.io/2023-01-15-leetcode-268-missing-number/).

Currently, we will apply the Cyclic Sort. Then, iterate each element in an array to check the difference between its value and its index.

Below is the source code of this solution:

```Java
class Solution {
    public List<Integer> findDisappearedNumbers(int[] nums) {
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

        List<Integer> missingNumbers = new ArrayList<>();
        for (int i = 0; i < size; ++i) {
            if (nums[i] != i + 1) {
                missingNumbers.add(i + 1);
            }
        }

        return missingNumbers;
    }

    private static void swap(int[] nums, int i, int j) {
        int tmp = nums[i];
        nums[i] = nums[j];
        nums[j] = tmp;
    }

}
```

The complexity of this solution is:
- Time complexity: O(n)
- Space complexity: O(1)


<br>

## Wrapping up




<br>

Refer:

[448. Find All Numbers Disappeared in an Array](https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/)
