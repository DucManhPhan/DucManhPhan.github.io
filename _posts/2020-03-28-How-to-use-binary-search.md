---
layout: post
title: How to use binary search
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search]
---

## Table of contents
- [Given problem](#given-problem)
- [Solution of Binary Search](#solution-of-binary-search)
- [When to use](#when-to-use)
- [Source code](#source-code)
- [Some variants of Binary Search](#some-variants-of-binary-search)
- [Some examples that uses Binary Search](#some-examples-that-uses-binary-search)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Assuming that we encounter the problem such as:

```
Given a sorted (in ascending order) integer array nums of n elements and a target value, write a function to search target in nums. If target exists, then return its index, otherwise return -1.

Example: 
Input: nums = [-1,0,3,5,9,12], target = 9
Output: 4
```

How can we solve this problem in the logarithmic time?

<br>

## Sequential search

The brute force way to solve an above problem is that we will use the linear search.

```java
public int search(int[] nums, int target) {
    int len = nums.length;

    for (int i = 0; i < len; ++i) {
        if (nums[i] == target) {
            return i;
        }
    }

    return -1;  // not found
}
```

In this way, we have the complexity:
- Time complexity: O(n)
- Space complexity: O(1)

<br>

## Quick Sequential search

In the sequential search way, we can find that it has two branch conditions such as a condition in **for** loop, and a remained condition in **if** statement.

So, we can optimize these by only using one condition.

```java
public int search(int[] nums, int target) {
    int end = nums.length - 1;
    int last = nums[end];
    nums[end] = target;

    int index = 0;
    while (nums[index] != target) {
        ++index;
    }

    nums[end] = last;
    if (index < end) {
        return index;
    } else if (last == target) {
        return end;
    }

    return -1;
}
```

<br>

## Solution of Binary Search

To reduce the time complexity of linear search, we will base on the condition of this array is the sorted array. We will use Binary Search to deal with it.

```java
public int search(int[] nums, int target) {
    int left = 0;
    int right = nums.length - 1;
    
    while (left <= right) {
        int mid = left + (right - left) / 2;
        
        if (nums[mid] == target) {
            return mid;
        } else if (target < nums[mid]) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    
    return -1;
}
```

In this way, we have the complexity:
- Time complexity: O(log(n))
- Space complexity: O(1)

Some steps to solve problems with Binary Search:
- Pre-processing - Sort if collection is unsorted.

- Binary Search - Using a loop or recursion to divide search space in half after each comparison.

- Post-processing - Determine viable candidates in the remaining space.


<br>

## When to use

- When we have to search an element in a collection.

    If our collection is unordered, we can always sort it first before applying Binary Search.

- When we are given a sorted Array or LinkedList or Matrix, and we are asked to find a certain element, the best algorithm we can use is the Binary Search.

- Binary search is not about sorted array or recursion, which are all very superficial. The essence of binary search is to reduce time complexity by eliminating half of the candidates.

- When we have some trends such as an increased part or an decreased part of an array.

<br>

## Source code

1. Iterative version

    ```java 
    public static int binarySearch(int[] arr, int k) {
        int left = 0;
        int right = arr.length - 1;

        while (left <= right) {
            // int mid = left + (right - left) / 2;
            int mid = (left + right) >>> 1;

            if (arr[mid] == k) {
                return mid;
            } else if (k < arr[mid]) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        
        return -1;
    }
    ```


2. Recursive version

    ```java
    public static int binarySearch(int[] arr, int k, int left, int right) {
        if (left > right) {
            return -1;
        }

        // int mid = left + (right - left) / 2;
        int mid = (left + right) >>> 1;
        if (arr[mid] == k) {
            return mid;
        } else if (k < arr[mid]) {
            return binarySearchRecursive(arr, k, left, mid - 1);
        } else {
            return binarySearchRecursive(arr, k, mid + 1, right);
        }
    }
    ```

3. Stride version

    Another way to implement binary search is to go through the array from left to right making jumps.
    - The initial jump length is n/2.
    - The jump length is halved on each round: first n/4, then n/8, then n/16, ... until finally the length is 1
    - On each round, we make jumps until we would end up outside the array or in an element whose value exceeds the target value.
    - After the jumps, either the desired element has been  found or we know that it does not appear in the array.

    ```java
    public static int binarySearch(int[] arr, int k) {
        int pos = 0;
        int sz = arr.length;

        for (int stride = sz / 2; stride >= 1; stride /= 2) {
            while (pos + stride < sz && a[pos + stride] <= k) {
                pos += stride;
            }
        }

        if (a[pos] == k) return pos;
        return -1;
    }
    ```

Note:
- With ```int mid = (right + left) / 2;```, if right and left variable is large, then the expression of ```right + left``` can be overflow.

    So, we can have some solutions for this problem:
    - Use ```int mid = left + ((right - left) / 2);```.
    - Use ```int mid = (left + right) >>> 1;```. This way is only suitable for Java developer.
    - With C/C++ developer, we can use ```mid = ((unsigned int)left + (unsigned int)right)) >> 1;```.

<br>

## Some variants of Binary Search

1. Comparing elements directly with specific condition

    In this way, we will use the common format of Binary Search with source code:

    ```java
    int binarySearch(int[] nums, int target){
        if(nums == null || nums.length == 0) {
            return -1;
        }

        int left = 0;
        int right = nums.length - 1;
        while(left <= right){
            int mid = left + (right - left) / 2;

            if(nums[mid] == target) {
                return mid;
            } else if(nums[mid] < target) {
                left = mid + 1;
            } else { 
                right = mid - 1;
            }
        }

        // End Condition: left > right, exactly right + 1 == left
        // No more candidate
        return -1;
    }
    ```

    Some features of this variant:
    - Most basic and elementary form of Binary Search
    - Search Condition can be determined without comparing to the element's neighbors (or use specific elements around it)
    - No post-processing required because at each step, you are checking to see if the element has been found. If you reach the end, then you know the element is not found
    
    Some points in source code to identify:
    - Initial Condition: ```left = 0, right = length-1```
    - Termination: ```left > right```
    - Searching Left: ```right = mid-1```
    - Searching Right: ```left = mid+1```

2. Comparing an element with the its immediate right neighbor's index in the array

    ```java
    int binarySearch(int[] nums, int target){
        if(nums == null || nums.length == 0)
            return -1;

        int left = 0, right = nums.length;
        while(left < right){
            int mid = left + (right - left) / 2;
            if(nums[mid] == target){ return mid; }
            else if(nums[mid] < target) { left = mid + 1; }
            else { right = mid; }
        }

        // Post-processing:
        // End Condition: left == right
        // 1 more candidate
        if(left != nums.length && nums[left] == target) return left;
        return -1;
    }
    ```

    Some features of this variant:
    - An advanced way to implement Binary Search.
    - Search Condition needs to access element's immediate right neighbor
    - Use element's right neighbor to determine if condition is met and decide whether to go left or right
    - Gurantees Search Space is at least 2 in size at each step
    - Post-processing required. Loop/Recursion ends when you have 1 element left. Need to assess if the remaining element meets the condition.

    Some points in source code to identify:
    - Initial Condition: ```left = 0, right = length```
    - Termination: ```left == right```
    - Searching Left: ```right = mid```
    - Searching Right: ```left = mid+1```

3. Comparing an element with  its immediate left and right neighbor's index in the array

    ```java
    int binarySearch(int[] nums, int target) {
        if (nums == null || nums.length == 0)
            return -1;

        int left = 0, right = nums.length - 1;
        while (left + 1 < right){
            // Prevent (left + right) overflow
            int mid = left + (right - left) / 2;
            if (nums[mid] == target) {
                return mid;
            } else if (nums[mid] < target) {
                left = mid;
            } else {
                right = mid;
            }
        }

        // Post-processing:
        // End Condition: left + 1 == right
        // 2 more candidates
        if(nums[left] == target) return left;
        if(nums[right] == target) return right;
        return -1;
    }
    ```

    Some features of this variant:
    - An alternative way to implement Binary Search
    - Search Condition needs to access element's immediate left and right neighbors
    - Use element's neighbors to determine if condition is met and decide whether to go left or right
    - Gurantees Search Space is at least 3 in size at each step
    - Post-processing required. Loop/Recursion ends when you have 2 elements left. Need to assess if the remaining elements meet the condition.

    Some points in source code to identify:
    - Initial Condition: ```left = 0, right = length-1```
    - Termination: ```left + 1 == right```
    - Searching Left: ```right = mid```
    - Searching Right: ```left = mid```

<br>

## Some examples that uses Binary Search

- [Am I A Fibonacci Number](http://www.codechef.com/problems/AMIFIB) (Simple)

- [Codeforces:Eugeny and Play List](http://codeforces.com/problemset/problem/302/B) (Easy)

- [Codeforces:Primes on Interval](http://codeforces.com/problemset/problem/237/C) (Medium)

- [VNOI examples](http://vnspoj.blogspot.com/p/blog-page_49.html)


<br>

## Wrapping up
- Understanding about what the problem is that we can apply Binary Search.

- Use smoothly some variants of Binary Search.

<br>

Refer:

[https://leetcode.com/explore/learn/card/binary-search](https://leetcode.com/explore/learn/card/binary-search)

[Guide to competitive programming: Learning and improving algorithms through concepts]()