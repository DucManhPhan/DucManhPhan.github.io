---
layout: post
title: Move Zeros
bigimg: /img/image-header/yourself.jpeg
tags: [Two-Pointers]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using extra space way](#using-extra-space-way)
- [Using two-pointers technique](#using-two-pointers-technique)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.

```java
Example:
    Input: [0,1,0,3,12]
    Output: [1,3,12,0,0]
```

Constraints:
- You must do this in-place without making a copy of the array.
- Minimize the total number of operations.

<br>

## Using extra space way

In this way, we will use another array to contain our result by using an additional index.

```java
class Solution {
    public void moveZeroes(int[] nums) {
        int len = nums.length;
        int[] res = new int[len];
        
        for (int i = 0, resIdx = 0; i < len; ++i) {
            if (nums[i] != 0) {
                res[resIdx++] = nums[i];
            }
        }
        
        for (int i = 0; i < len; ++i) {
            nums[i] = res[i];
        }
    }
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(n)

<br>

## Using two-pointers technique

In this section, we will use two pointers:
- the one pointer to indicate the non-zero element.
- the one pointer to indicate the zero element.

The first thing to do is that we always to find exactly the position of these pointers by using while loop. Then, to swap two positions, it needs to satisfy a condition: the non-zero pointer is always greater than the zero pointer. 

```java
class Solution {
    public void moveZeroes(int[] nums) {
        int nonPointer = 0;
        int zeroPointer = 0;

        while (true) {
            while (nonPointer < nums.length && nums[nonPointer] == 0) {
                ++nonPointer;
            }

            while (zeroPointer < nums.length && nums[zeroPointer] != 0) {
                ++zeroPointer;
            }

            if (nonPointer >= nums.length || zeroPointer >= nums.length) {
                return;
            }

            if (nonPointer > zeroPointer) {
                int tmp = nums[nonPointer];
                nums[nonPointer] = nums[zeroPointer];
                nums[zeroPointer] = tmp;
            }
                
            ++nonPointer;
        }
    }
}
```

When we see the above solution, we can feel that it is complicated. So, we will optimize it but the idea is remained.

```java
class Solution {
    public void moveZeroes(int[] nums) {
        int lastNonZeroIdx = 0;

        for (int i = 0; i < nums.length; ++i) {
            if (nums[i] != 0) {
                this.swap(nums[lastNonZeroIdx++], nums[i]);
            }
        }
    }

    private void swap(int[] nums, int i, int j) {
        int tmp = nums[i];
        nums[i] = nums[j];
        nums[j] = tmp;
    }
}
```

Other way:

```java
class Solution {
    public void moveZeroes(int[] nums) {
        int lastNonZeroIdx = 0;

        for (int i = 0; i < nums.length; ++i) {
            if (nums[i] != 0) {
                nums[lastNonZeroIdx++] = nums[i];
            }
        }

        for (int i = lastNonZeroIdx; i < nums.length; ++i) {
            nums[i] = 0;
        }
    }
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(1)

<br>

## Wrapping up

- Understanding about how to use two-pointers technique to apply in an array.

<br>

Refer:

[https://leetcode.com/problems/move-zeroes/](https://leetcode.com/problems/move-zeroes/)
