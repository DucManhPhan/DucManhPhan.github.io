---
layout: post
title: Some ways to use brute force algorithm
bigimg: /img/image-header/yourself.jpeg
tags: [Algorithm]
---




<br>

## Table of contents
- [Introduction to brute force algorithm](#introduction-to-brute-force-algorithm)
- [Search an element in an array](#search-an-element-in-an-array)
- [Sorting an array](#sorting-an-array)
- [Find the contiguous subarray has largest sum](#find-the-contiguous-subarray-has-largest-sum)
- [Longest palindrome substring](#longest-palindrome-substring)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to brute force algorithm

Brute force algorithm is an algorithm that goes straight forward, through all cases to get suitable solutions.

For example, we have a dictionary, and we want to find a word in it. With brute force algorithm, we will go with the natural order - from A to Z of this dictionary. If this word starts with z character, it takes so much time to find it.

So, in this article, we will learn how to use brute force algorithm for some specific problems.

<br>

## Search an element in an array

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

## Sorting an array

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

## Find the contiguous subarray has largest sum

Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

For example:

```
Input: [-2, 1, -3, 4, -1, 2, 1, -5, 4],
Output: 6
Explanation: [4,-1,2,1] has the largest sum = 6.
```

To apply the brute force algorithm, we need to scan subarray with the dynamic length. It means that:
- the outter loop will be used to set the **start index** of a subarray.
- the inner loop will be used to set the **last index** of a subarray.
- the most inner loop will loop from **start index** to **last index**.

Below is a source code for this problem:

```java
public int maxSubArray(int[] nums) {
    int len = nums.length;
    int max = Integer.MIN_VALUE;

    for (int start = 0; start < len; ++start) {
        for (int end = start + 1; end <= len; ++end) {
            int sum = 0;
            for (int i = start; i < end; ++i) {
                sum += nums[i];
            }

            max = Math.max(max, sum);
        }
    }

    return max;
}
```


<br>

## Longest palindrome substring

Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.

For example:

```
Example 1:
Input: "babad"
Output: "bab"
Note: "aba" is also a valid answer.

Example 2:
Input: "cbbd"
Output: "bb"
```

With this problem, we can use brute force with some ways:
1. scan all substring that we can. We can use the similar idea in the section [Find the contiguous subarray has largest sum](#find-the-contiguous-subarray-has-largest-sum).

    - Based on the start index and last index of substring.

        ```java
        public void subString(String str) {
            int n = str.length();

            for (int start = 0; start < n; ++start) {
                for (int end = start + 1; end <= n; ++end) {
                    String subString = str.substring(start, end);
                    System.out.println(subString);
                }
            }
        }
        ```

    - Based on the length of each substring.

        ```java
        public void subString(String str) {
            int n = str.length();

            for (int len = 1; len <= n; ++len) {
                for (int start = 0; start <= n - len; ++start) {
                    String subString = str.substring(start, start + len);
                    System.out.println(subString);
                }
            }
        }
        ```

    The complexity of this solution:
    - Time complexity: O(n^3)
    - Space complexity: O(1)

    To check the substring is palindromic string, we can refer the other article [Palindrome string]().

2. At each character currently, we will expand both left and right side to check this substring is palindrome or not.

    Below is the source code of this problem.

    ```java
    private static int lo;
    private static int maxLen;

    public static String longestPalindrome(String s) {
    int len = s.length();
        if (len < 2) {
            return s;
        }

        for (int i = 0; i < len - 1; i++) {
            makePalindrome(s, i, i);
            makePalindrome(s, i, i + 1);
        }

        return s.substring(lo, lo + maxLen);
    }

    public static void makePalindrome(String s, int j, int k) {
        while (j >= 0 && k < s.length() && s.charAt(j) == s.charAt(k)) {
            j--;
            k++;
        }

        if (maxLen < k - j - 1) {
            lo = j + 1;
            maxLen = k - j - 1;
        }
    }
    ```

    The complexity of this solution:
    - Time complexity: O(n^2)
    - Space complexity: O(1)

<br>

## When to use

- In interview, we should always start from the brute force algorithm. Then, identify some problems of this solution, and optimize it.

- When we want to find all possible results of this problem.

<br>

## Benefits and Drawbacks

1. Benefits

    - simple to implement

2. Drawbacks

    - Normally, it's not efficiency


<br>

## Wrapping up

- Understanding some above ways to apply brute force in our problem.


<br>

Refer:

[https://medium.com/@chyanpin/solving-leetcodes-longest-palindrome-substring-challenge-60eaffd7929a](https://medium.com/@chyanpin/solving-leetcodes-longest-palindrome-substring-challenge-60eaffd7929a)