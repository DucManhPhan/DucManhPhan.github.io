---
layout: post
title: Leetcode 1346 - Check If N and its Double Exists
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search, HashMap]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Brute-force solution](#using-brute-force-solution)
- [Using Binary Search algorithm](#using-binary-search-algorithm)
- [Using other solutions](#using-other-solutions)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given an array arr of integers, check if there exists two integers `N` and `M` such that `N` is the double of `M` ( i.e. `N = 2 * M`).

More formally check if there exists two indices `i` and `j` such that :
- `i != j`
- `0 <= i, j < arr.length`
- `arr[i] == 2 * arr[j]`

```
Example 1:
Input: arr = [10,2,5,3]
Output: true
Explanation: N = 10 is the double of M = 5,that is, 10 = 2 * 5.
Example 2:

Input: arr = [7,1,14,11]
Output: true
Explanation: N = 14 is the double of M = 7,that is, 14 = 2 * 7.
Example 3:

Input: arr = [3,1,7,11]
Output: false
Explanation: In this case does not exist N and M, such that N = 2 * M.
```

Constraints:
- `2 <= arr.length <= 500`
- `-10^3 <= arr[i] <= 10^3`


<br>

## Using Brute-force solution

According to the requirements above, we can see that we need to find the two elements `N` and `M`. Then, we can use brute-force algorithm with two loops to iterate all elements in that array.

```java
public static boolean checkIfExist(int[] arr) {
    int length = arr.length;

    for (int i = 0; i < length; ++i) {
        for (int j = 0; j < length; ++j) {
            if (i != j) {
                if (arr[i] == 2 * arr[j]) {
                    return true;
                }
            }
        }
    }

    return false;
}
```

The complexity of this solution:
- Time complexity: O(n^2)
- Space complexity: O(1)


<br>

## Using Binary Search algorithm

To solve this problem, we will need to sort this array firstly. Then, we will use Binary Search algorithm to search each element in this array.

```java
class Solution {
    public boolean checkIfExist(int[] arr) {
        if (arr == null || arr.length < 2) {
            return false;
        }
        
        Arrays.sort(arr);
        
        for (int i = 0; i < arr.length; ++i) {
            int currentValue = arr[i];
            int idx = Arrays.binarySearch(arr, 2 * currentValue);
            if (idx >= 0 && idx != i) {
                return true;
            }
        }
        
        return false;
    }
}
```

In this solution, we will use `Arrays.binarySearch()` method to search it.
- If an element is existed in the array, this method will return the index of this element.
- Otherwise, it will return `(-(insertion point) - 1)`. The insertion point is defined as the point at which the key would be inserted into the array.

    Note that this guarantees that the return value will be >= 0 if and only if the key is found.

The complexity of this solution:
- Time complexity: O(nlogn)
- Space complexity: O(1)


<br>

## Using other solutions

If we look carefully at this problem, we can see this problem is the same as the Two Sum problem. Then, below is a solution that using HashSet data structure.

```java
public boolean checkIfExist(int[] arr) {
    Arrays.sort(arr);
    Set<Integer> data = new HashSet<>();

    for (int i = 0; i < arr.length; ++i) {
        int currentValue = arr[i];

        if (i > 0 && currentValue != 0 && currentValue == arr[i - 1]) {
            continue;
        }

        if (data.contains(2 * currentValue) || data.contains(currentValue)) {
            return true;
        }

        data.add(currentValue);
        data.add(2 * currentValue);
    }

    return false;
}
```

The complexity of this solution:
- Time complexity: O(nlogn)
- Space complexity: O(n)


<br>

## Wrapping up




<br>

Refer:

[1346. Check If N and Its Double Exist](https://leetcode.com/problems/check-if-n-and-its-double-exist/)

[https://docs.oracle.com/javase/7/docs/api/java/util/Arrays.html#binarySearch(int[],%20int)](https://docs.oracle.com/javase/7/docs/api/java/util/Arrays.html#binarySearch(int[],%20int))
