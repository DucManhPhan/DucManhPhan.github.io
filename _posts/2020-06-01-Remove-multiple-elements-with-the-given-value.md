---
layout: post
title: Remove multiple elements with the given value
bigimg: /img/image-header/yourself.jpeg
tags: [Two-Pointers]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using two-pointers technique](#using-two-pointers-technique)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given an array nums and a value val, remove all instances of that value in-place and return the new length.

Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.

The order of elements can be changed. It doesn't matter what you leave beyond the new length.

For example:

```yaml
Example 1:
    Given nums = [3,2,2,3], val = 3,

    Your function should return length = 2, with the first two elements of nums being 2.

    It doesn't matter what you leave beyond the returned length.

Example 2:
    Given nums = [0,1,2,2,3,0,4,2], val = 2,

    Your function should return length = 5, with the first five elements of nums containing 0, 1, 3, 0, and 4.

    Note that the order of those five elements can be arbitrary.

    It doesn't matter what values are set beyond the returned length.
```


<br>

## Using two-pointers technique

In this problem, we will use two pointers:
- Supposed that slow pointer will point to another array.
- Fast pointer will iterate the current array.
- Each time we find that an element at fast pointer is different than val, we will update the value at the slow pointer.
- Otherwise, increment the fast pointer.

```java
public int removeElement(int[] nums, int val) {
    int slow = -1;
    int fast = 0;
    
    while (fast < nums.length ){
        if (nums[fast] != val) {
            ++slow;
            nums[slow] = nums[fast];
        }
        
        ++fast;
    }
    
    return slow + 1;
}
```

The benefits of this solution:
- Maintain the order of elements after shifting them.
- Shifting elements with in-place way.

The drawbacks of this solution:
- If an array does not contains any elements that is equal to val, it makes assignment operations redundancy.

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(1)

<br>

## Wrapping up

- Understanding some ways of the two-pointers technique that will be applied into an array.


<br>

Refer:

[https://leetcode.com/problems/remove-element/](https://leetcode.com/problems/remove-element/)