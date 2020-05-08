---
layout: post
title: Some ways to use brute force algorithm
bigimg: /img/image-header/yourself.jpeg
tags: [Algorithm]
---




<br>

## Table of contents
- [Introduction to brute force algorithm](#introduction-to-brute-force-algorithm)
- [Brute-force algorithm with search element in array](#brute-force-algorithm-with-search-element-in-array)
- [Brute force algorithm with Bubble Sort](#brute-force-algorithm-with-bubble-sort)
- [Brute force algorithm with subarray sum](#brute-force-algorithm-with-subarray-sum)
- [Brute force algorithm with palindrome string](brute-force-algorithm-with-palindrome-string)
- [When to use](#when-to-use)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to brute force algorithm

Brute force algorithm is an algorithm that goes straight forward, through all cases to get suitable solutions.

For example, we have a dictionary, and we want to find a word in it. With brute force algorithm, we will go with the natural order - from A to Z of this dictionary. If this word starts with z character, it takes so much time to find it.


<br>

## Brute-force algorithm with search element in array

To search element in an array, we will apply brute force algorithm by scanning all array's elements.

```java
/**
 * Using linear search to scan all elements
 *
 * @param: nums - an array to be scanned
 * @param: target
 * @return: an index of target element, or if not found, return -1
 */
public int find(int[] nums, int target) {
    int len = nums.length;
    for (int i = 0; i < len; ++i) {
        if (nums[i] == target) {
            return i;
        }
    }

    return -1;
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(1)

To optimize the time complexity of the above solution, we will use the lef-right algorithm.

```java
/**
 * Using two pointer to scan an array
 *
 * @param: nums - an array to be scanned
 * @param: target
 * @return: an index of target element, or if not found, return -1
 */
public int find(int[] nums, int target) {
    int len = nums.length;
    int left = 0;
    int right = len - 1;

    while (left <= right) {
        if (nums[left] == target) return nums[left];
        if (nums[right] == target) return nums[right];

        ++left;
        --right;
    }

    return -1;
}
```

The complexity of this optimal solution:
- Time complexity: O(n/2)
- Space complexity: O(1)

<br>

## Brute force algorithm with Bubble Sort

To apply brute force in sorting element in an array, we can do like the above:

```java
public void sort(int[] nums) {
    int len = nums.length;

    for (int i = 0; i < len; ++i) {
        for (int j = 0; j < len - i - 1; ++j) {
            if (nums[j] > nums[j + 1]) {
                int tmp = nums[j];
                nums[j] = nums[j + 1];
                nums[j + 1] = tmp;
            }
        }
    }
}
```

The complexity of this bubble sort is:
- Time complexity: O(n^2)
- Space complexity: O(1)

The problem of an above solution is that it sorts an array even if an array is sorted, the swapping operation is redundancy.

So, to optimize an above solution, we can use boolean isSwapped to check whether an array is sorted or not.

```java
public void sort(int[] nums) {
    int len = nums.length;
    boolean isSwapped;

    for (int i = 0; i < len; ++i) {
        isSwapped = false;
        for (int j = 0; j < len - i - 1; ++j) {
            if (nums[j] > nums[j + 1]) {
                int tmp = nums[j];
                nums[j] = nums[j + 1];
                nums[j + 1] = tmp;

                isSwapped = true;
            }
        }

        if (!isSwapped) {
            break;
        }
    }
}
```

<br>

## Brute force algorithm with subarray sum





<br>

## Brute force algorithm with palindrome string





<br>

## When to use




<br>

## Benefits and Drawbacks

1. Benefits

    - simple to implement

2. Drawbacks

    - Normally, it's not efficiency


<br>

## Wrapping up




<br>

Refer:

