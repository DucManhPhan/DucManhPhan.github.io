---
layout: post
title: Leetcode 2089 - Find Target Indices After Sorting Array
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute-force](#using-brute-force)
- [Using Binary Search algorithm](#using-binary-search-algorithm)
- [Using the characteristics of problem](#using-the-characteristics-of-problem)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

You are given a 0-indexed integer array `nums` and a target element `target`.

A target index is an index `i` such that `nums[i] == target`.

Return a list of the target indices of nums after sorting `nums` in non-decreasing order. If there are no target indices, return an empty list. The returned list must be sorted in increasing order.

Example 1:
- Input: `nums = [1,2,5,2,3]`, target = 2
- Output: `[1,2]`
- Explanation: After sorting, nums is `[1,2,2,3,5]`. The indices where `nums[i] == 2` are 1 and 2.

Example 2:
- Input: `nums = [1,2,5,2,3]`, target = 3
- Output: `[3]`
- Explanation: After sorting, nums is `[1,2,2,3,5]`. The index where `nums[i] == 3` is 3.

Example 3:
- Input: `nums = [1,2,5,2,3]`, target = 5
- Output: `[4]`
- Explanation: After sorting, nums is `[1,2,2,3,5]`. The index where `nums[i] == 5` is 4.

Constraints:
- `1 <= nums.length <= 100`
- `1 <= nums[i], target <= 100`


<br>

## Using brute-force

Our steps to deal with this problem are:
1. Sort the current array.
2. Find elements that are equal to the `target`.

    - First way, iterate all elements of the array.

        In this section, we will use this way.

    - Second way, using binary search algorithm to find the upper bound and lower bound of the target. Then, iterate from lower bound to upper bound to get indices.

```Java
class Solution {

    public List<Integer> targetIndices(int[] nums, int target) {
        Arrays.sort(nums);

        ArrayList<Integer> indices = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == target) {
                indices.add(i);
            }
        }

        return indices;
    }
}
```

The complexity of this solution is:
- Time complexity: `O(nlogn)`.
- Space complexity: `O(n)`.


<br>

## Using Binary Search algorithm

```Java
class Solution {
    public List<Integer> targetIndices(int[] nums, int target) {
        Arrays.sort(nums);
        System.out.println(Arrays.toString(nums));

        List<Integer> indices = new ArrayList<>();

        int lowerPoint = lowerBound(nums, target);
        if (lowerPoint == -1) {
            return indices;
        }

        int upperPoint = upperBound(nums, target);
        IntStream.rangeClosed(lowerPoint, upperPoint)
                 .forEach(idx -> indices.add(idx));

        return indices;
    }

    private static int lowerBound(int[] nums, int target) {
        int left = 0;
        int right = nums.length;

        while (left + 1 < right) {
            int mid = left + (right - left) / 2;

            if (nums[mid] >= target) {
                right = mid;
            } else {
                left = mid;
            }
        }

        if (nums[left] == target) {
            return left;
        }

        if (right < nums.length && nums[right] == target) {
            return right;
        }

        return -1;
    }

    private static int upperBound(int[] nums, int target) {
        int left = 0;
        int right = nums.length;

        while (left + 1 < right) {
            int mid = left + (right - left) / 2;

            if (nums[mid] <= target) {
                left = mid;
            } else {
                right = mid;
            }
        }

        if (nums[left] == target) {
            return left;
        }

        if (right < nums.length && nums[right] == target) {
            return right;
        }

        return -1;
    }
}
```

The complexity of this solution is:
- Time complexity: `O(nlogn)`.

    - The time complexity of sorting algorithm is O(nlogn).
    - The time complexity of binary search algorithm is O(logn).

- Space complexity: `O(n)`.


<br>

## Using the characteristics of problem

In this way, we will make the most of the characteristics of this problem. To understand it, we need to state our problem again:

```
Find the indices of elements that are equal to target after sorting.
```

Definitely, after sorting the arrary, we only need to take care the last index of element that is less than `target`. Then, the elements' index that are equal to the target will be increased by 1 based on that element.

```
.. idx_less_element target ..
```

Therefore, we will use two variable to indicate them.
- `count`: how many elements that are equal to `target`.
- `lessThan`: how many elements that are less than `target`.

Below is our source code for this problem:

```Java
public class Solution {
    public static List<Integer> targetIndicesV2(int[] nums, int target) {
        List<Integer> indices = new ArrayList<>();

        int count = 0;
        int lessThan = 0;

        for (int n : nums) {
            if (n == target) {
                count++;
                continue;
            }

            if (n < target) {
                lessThan++;
            }
        }

        for (int i = 0; i < count; ++i) {
            indices.add(lessThan++);
        }

        return indices;
    }
}
```

The complexity of this solution is:
- Time complexity: `O(n)`.
- Space complexity: `O(n)`.


<br>

## Wrapping up

- The first step is that try to simulate the problem.


<br>

Refer:

[2089. Find Target Indices After Sorting Array](https://leetcode.com/problems/find-target-indices-after-sorting-array/)
