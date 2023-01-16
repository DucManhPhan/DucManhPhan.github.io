---
layout: post
title: LeetCode 268 - Missing Number
bigimg: /img/image-header/yourself.jpeg
tags: [Array]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force solution](#using-brute-force-solution)
- [Using HashMap data structure](#using-hashmap-data-structure)
- [Using Cyclic Sort](#using-cyclic-sort)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given an array nums containing `n` distinct numbers in the range `[0, n]`, return the only number in the range that is missing from the array.

- Example 1:

    - Input: nums = `[3,0,1]`
    - Output: 2
    - Explanation: n = 3 since there are 3 numbers, so all numbers are in the range `[0,3]`. 2 is the missing number in the range since it does not appear in nums.

- Example 2:

    - Input: nums = `[0,1]`
    - Output: 2
    - Explanation: n = 2 since there are 2 numbers, so all numbers are in the range `[0,2]`. 2 is the missing number in the range since it does not appear in nums.

- Example 3:

    - Input: nums = `[9,6,4,2,3,5,7,0,1]`
    - Output: 8
    - Explanation: n = 9 since there are 9 numbers, so all numbers are in the range `[0,9]`. 8 is the missing number in the range since it does not appear in nums.

Then, its constraints:
- `n == nums.length`
- `1 <= n <= 104`
- `0 <= nums[i] <= n`
- All the numbers of nums are unique.


<br>

## Using brute force solution

The steps of this solution are:
1. Sort our `nums` array.
2. Iterate our current `nums` array and check that when the difference between the item's value and its index happen, we need to return its index immediately.

Below is the brute force solution that use Bubble Sort for sorting our `nums` array.

```Java
class Solution {
    public int missingNumber(int[] nums) {
        int size = nums.length;

        // bubble sort
        for (int i = 0; i < size; ++i) {
            for (int j = 0; j < size - i - 1; ++j) {
                if (nums[j] > nums[j + 1]) {
                    swap(nums, j, j + 1);
                }
            }
        }

        // find the first item's value and its index is different
        for (int i = 0; i < size; ++i) {
            if (i != nums[i]) {
                return i;
            }
        }

        return size;
    }

    private void swap(int[] nums, int x, int y) {
        int tmp = nums[x];
        nums[x] = nums[y];
        nums[y] = tmp;
    }
}
```

The complexity of this solution is:
- Time complexity: O(n^2)
- Space complexity: O(1)

To improve this brute force solution, we can improve the performance of the Bubble Sort algorithm by using Quick Sort or Merge Sort. So the time complexity of this solution can be O(n * logn).


<br>

## Using HashMap data structure

Due to the range of our array from 0 to n, we can use additional data structure to contain elements in the current nums array. Then, iterate index from 0 to n, we will find a missing element. Otherwize, we will return the `n + 1` element.

```Java
class Solution {
    public int missingNumber(int[] nums) {
        int size = nums.length;

        Set<Integer> fullNumbers = new HashSet<>();
        IntStream.range(0, size)
                 .forEach(i -> fullNumbers.add(nums[i]));

        for (int i = 0; i < size; ++i) {
            if (!fullNumbers.contains(i)) {
                return i;
            }
        }

        return size;
    }
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(n - 1)


<br>

## Using Cyclic Sort

Below is the solution that use Cyclic Sort:

```Java
class Solution {
    public int missingNumber(int[] nums) {
        int i = 0;

        while (i < nums.length) {
            if (nums[i] < nums.length && nums[i] != nums[nums[i]]) {
                swap(nums, i, nums[i]);
            } else {
                i++;
            }
        }

        for (i = 0; i < nums.length; ++i) {
            if (nums[i] != i) {
                return i;
            }
        }

        return nums.length;
    }

    private void swap(int[] nums, int i, int j) {
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

[268. Missing Number](https://leetcode.com/problems/missing-number/)
