---
layout: post
title: Leetcode 400 - Nth Digit
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm](#using-brute-force-algorithm)
- [Using Binary Search algorithm](#using-binary-search-algorithm)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Find the nth digit of the infinite integer sequence 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, ...

Note:
n is positive and will fit within the range of a 32-bit signed integer (n < 231).

```java
Example 1:
    Input: 3
    Output: 3

Example 2:
    Input: 11
    Output: 0
    Explanation:
        The 11th digit of the sequence 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, ... is a 0, which is part of the number 10.
```


<br>

## Using brute force algorithm

We always to start with the brute force algorithm to iterate all cases of this problem.

```java
class Solution {
    public int findNthDigit(int n) {
        int currentLength = 0;

        for (int i = 1; i < Integer.MAX_VALUE; ++i) {
            String value = String.valueOf(i);

            if (currentLength + value.length() >= n) {
                int len = 0;
                while (len < value.length()) {
                    ++currentLength;
                    if (currentLength == n) {
                        return Character.digit(value.charAt(len), 10);
                    }

                    ++len;
                }
            }

            currentLength += value.length();
        }

        return -1;
    }
}
```

Using this solution, LeetCode platform throws Time Limit Exceed cases. So we need to find the other solution.

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(1)

<br>

## Using Binary Search algorithm

To optimize this problem, we can use the Binary Search algorithm because with this problem, there are some reasons that we need to take care:
- 
- 
- 

```java

```

The complexity of this solution:
- Time complexity: 
- Space complexity: 


<br>

## Wrapping up

- Understanding how to use Binary Search algorithm to deal with our problems.


<br>

Refer:

[https://leetcode.com/problems/nth-digit/](https://leetcode.com/problems/nth-digit/)
