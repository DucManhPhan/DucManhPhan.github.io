---
layout: post
title: 
bigimg: /img/image-header/yourself.jpeg
tags: []
---




<br>

## Table of contents
- [Given problem](#given-problem)
- []()
- []()
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given an integer array `nums`, handle multiple queries of the following type:

Calculate the sum of the elements of `nums` between indices `left` and `right` inclusive where `left <= right`.

Implement the `NumArray` class:

- `NumArray(int[] nums)` Initializes the object with the integer array `nums`.
- `int sumRange(int left, int right)` Returns the sum of the elements of `nums` between indices `left` and `right` inclusive (i.e. `nums[left] + nums[left + 1] + ... + nums[right]`).

Example 1:

- Input

    ```
    ["NumArray", "sumRange", "sumRange", "sumRange"]
    [[[-2, 0, 3, -5, 2, -1]], [0, 2], [2, 5], [0, 5]]
    ```

- Output

    ```
    [null, 1, -1, -3]
    ```

- Explanation

    ```
    NumArray numArray = new NumArray([-2, 0, 3, -5, 2, -1]);
    numArray.sumRange(0, 2); // return (-2) + 0 + 3 = 1
    numArray.sumRange(2, 5); // return 3 + (-5) + 2 + (-1) = -1
    numArray.sumRange(0, 5); // return (-2) + 0 + 3 + (-5) + 2 + (-1) = -3
    ```

Constraints:

- $1 \le nums.length \le 10^4$.
- $-10^5 \le nums[i] \le 10^5$
- $0 \le left \le right \lt nums.length$.
- At most $10^4$ calls will be made to `sumRange`.


<br>

## Using Prefix Sum



```Java
class NumArray {

    public NumArray(int[] nums) {
        
    }
    
    public int sumRange(int left, int right) {
        
    }
}
```

The complexities of this way:

- Time complexity:
- Space complexity:


<br>

## 





<br>

## Wrapping up




<br>

Refer:

[303. Range Sum Query - Immutable](https://leetcode.com/problems/range-sum-query-immutable/description/)