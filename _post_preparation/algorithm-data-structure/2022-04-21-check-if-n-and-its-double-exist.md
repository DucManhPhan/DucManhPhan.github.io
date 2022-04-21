---
layout: post
title: Two sum
bigimg: /img/image-header/yourself.jpeg
tags: [Two-Pointers, HashMap]
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
