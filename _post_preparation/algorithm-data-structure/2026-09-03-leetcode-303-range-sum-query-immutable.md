---
layout: post
title: 
bigimg: /img/image-header/yourself.jpeg
tags: []
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using For Loop](#using-for-loop)
- [Using Prefix Sum](#using-prefix-sum)
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

## Using For Loop

For the first approach, we will rely on the steps of its description.

```Java
class NumArray {

    private int[] nums;

    public NumArray(int[] nums) {
        this.nums = nums;
    }

    public int sumRange(int left, int right) {
        if (left < 0 || right >= nums.length || left > right) {
            return -1;
        }

        int result = 0;
        for (int i = left; i <= right; ++i) {
            result += nums[i];
        }

        System.out.println("Sum range from " + left + " to " + right + ": " + result);
        return result;
    }
}
```

The complexities of this way:

- Time complexity: $O(m \times n)$.

    - `m` is the number of queries.
    - `n` is the length of the array.

- Space complexity: $O(1)$.


<br>

## Using Prefix Sum

To speed up [the previous solution](#using-for-loop) that is using For Loop, we need to eliminate the redundant sum in each loop by using the prefix sum array.

```Java
class NumArray {

    private int[] nums;
    private int[] prefixSum;

    public NumArray(int[] nums) {
        this.nums = nums;
        this.prefixSum = this.calculatePrefixSum();
    }
    
    public int sumRange(int left, int right) {
        if (left < 0 || right >= this.nums.length || left > right) {
            return -1;
        }

        return this.prefixSum[right + 1] - this.prefixSum[left];
    }

    private int[] calculatePrefixSum() {
        int[] prefixSum = new int[this.nums.length + 1];
        prefixSum[0] = 0;

        for (int i = 0; i < nums.length; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        return prefixSum;
    }
}
```

The complexities of this way:

- Time complexity: $O(m + n)$.

    - `m` is the number of queries.
    - `n` is the length of the array.

- Space complexity: $O(n + 1)$.


<br>

## Wrapping up




<br>

Refer:

[303. Range Sum Query - Immutable](https://leetcode.com/problems/range-sum-query-immutable/description/)