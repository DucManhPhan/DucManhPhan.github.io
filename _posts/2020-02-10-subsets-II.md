---
layout: post
title: Subsets II
bigimg: /img/image-header/yourself.jpeg
tags: [Backtracking]
---




<br>

## Table of contents

- [Given problem](#given-problem)
- [Using Backtracking algorithm](#using-backtracking-algorithm)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a collection of integers that might contain duplicates, nums, return all possible subsets (the power set).

Note: The solution set must not contain duplicate subsets.

Example:

```
Input: [1,2,2]
Output:
[
  [2],
  [1],
  [1,2,2],
  [2,2],
  [1,2],
  []
]
```

<br>

## Using Backtracking algorithm

1. The easiest way is that before we push an array into a result array, we will check whether it can be duplicated the other array in result array or not.

    ```java
    public List<List<Integer>> subsetsWithDup(int[] nums) {
        List<List<Integer>> res = new ArrayList<>();
        Arrays.sort(nums);
        subsetsWithDup(nums, res, new ArrayList<>(), 0);
        
        return res;
    }

    public void subsetsWithDup(int[] nums, List<List<Integer>> res, List<Integer> values, int indx) {
        if (!res.contains(values)) {
            res.add(new ArrayList<>(values));
        }
        
        for (int i = indx; i < nums.length; ++i) {
            values.add(nums[i]);
            subsetsWithDup(nums, res, values, i + 1);
            values.remove(values.size() - 1);
        }
    }
    ```

2. Compare elements in the loop

    ```java
    public List<List<Integer>> subsetsWithDup(int[] nums) {
        List<List<Integer>> res = new ArrayList<>();
        Arrays.sort(nums);
        subsetsWithDup(nums, res, new ArrayList<>(), 0);
        
        return res;
    }

    public void subsetsWithDup(int[] nums, List<List<Integer>> res, List<Integer> values, int indx) {
        res.add(new ArrayList<>(values));
        
        for (int i = indx; i < nums.length; ++i) {
            if (i != indx && nums[i] == nums[i - 1]) {  // compare the current element and previous element
                continue;
            }

            values.add(nums[i]);
            subsetsWithDup(nums, res, values, i + 1);
            values.remove(values.size() - 1);
        }
    }
    ```

The complexity of this problem:
- Time complexity: O(n * 2^n)
- Space complexity: O(n * 2^n)

<br>

## Wrapping up

- Understanding basic about the structure of backtracking problem.


<br>

Refer:

[https://leetcode.com/problems/subsets-ii/](https://leetcode.com/problems/subsets-ii/)