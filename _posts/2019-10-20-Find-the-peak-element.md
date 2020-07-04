---
layout: post
title: Find the peak element
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search, Array]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution](#solution)
- [Using brute-force way](#using-brute-force-way)
- [Using binary search](#using-binary-search)
- [Wrapping up](#wrapping-up)



<br>

## Given problem

Below is the description of our problem:

```
A peak element is an element that is greater than its neighbors.

Given an input array nums, where nums[i] ≠ nums[i+1], find a peak element and return its index.

The array may contain multiple peaks, in that case return the index to any one of the peaks is fine.

You may imagine that nums[-1] = nums[n] = -∞.

Example 1:
    Input: nums = [1,2,3,1]
    Output: 2
    Explanation: 3 is a peak element and your function should return the index number 2.

Example 2:
    Input: nums = [1,2,1,3,5,6,4]
    Output: 1 or 5 
    Explanation: Your function can return either index number 1 where the peak element is 2, 
                or index number 5 where the peak element is 6.
```

<br>

## Solution

In the above section, we have the definition of the peak element:

```
A peak element is an element that is greater than its neighbors.
```

So, it means that:

```
nums[i - 1] < nums[i] > nums[i + 1] for 0 <= i <= N - 1
nums[i - 1] < nums[i] if i = N - 1
nums[i] > nums[i + 1] if i = 0
```

In this our case, we can find that **nums[i]** and **nums[i + 1]** is not equal, and to get the peak element of this array, we only compare between **nums[i]** and **nums[i + 1]**.

If we care an element **nums[i - 1]**, then we always check multiple conditions for that. And checking element **nums[i - 1]** and **nums[i]** is redundancy. Because checking elements **nums[i]** and **nums[i + 1]** makes us know the relationship between **nums[i]** and **nums[i - 1]** in the loop of an array.

<br>

## Using brute-force way


```java
public static int findPeakElementBruteForce(int[] nums) {
    List<Integer> peaks = new ArrayList<>();
    peaks.add(nums[nums.length - 1]);

    for (int i = 0; i < nums.length - 1; ++i) {
        if (nums[i] > nums[i + 1]) {
            peaks.add(nums[i]);
        }
    }

    return peaks.get(peaks.size() - 1);
}
```

The complexity of this solution:
- Time complexity: O(n).
- Space complexity: O(1).

<br>

## Using binary search

Below is the source code about iterative version and recursive version.

- The iterative version

    ```java
    public static int findPeakElement(int[] nums) {
        int left = 0, right = nums.length - 1;

        while (left < right) {
            int mid = (left + right) / 2;
            if (nums[mid] > nums[mid + 1])
                right = mid;
            else
                left = mid + 1;
        }

        return left;
    }
    ```

    The complexity of this solution:
    - Time complexity: O(log(n)).
    - Space complexity: O(1).

- The recursive version

    ```java
    public int findPeakElement(int[] nums) {
        return search(nums, 0, nums.length - 1);
    }
    public int search(int[] nums, int l, int r) {
        if (l == r)
            return l;
        int mid = (l + r) / 2;
        if (nums[mid] > nums[mid + 1])
            return search(nums, l, mid);
        return search(nums, mid + 1, r);
    }
    ```

    The complexity of solution:
    - Time complexity: O(log(n)).
    - Space complexity: O(log(n)).

<br>

## Wrapping up

- Understanding this variant of Binary Search when comparing two adjacency elements.

<br>

Refer:

[https://www.tutorialcup.com/interview/array/peak-element.htm](https://www.tutorialcup.com/interview/array/peak-element.htm)

[https://www.programcreek.com/2014/02/leetcode-find-peak-element/](https://www.programcreek.com/2014/02/leetcode-find-peak-element/)

[https://www.techiedelight.com/find-peak-element-array/](https://www.techiedelight.com/find-peak-element-array/)