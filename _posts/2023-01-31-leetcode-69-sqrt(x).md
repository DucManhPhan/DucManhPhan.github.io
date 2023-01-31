---
layout: post
title: Leetcode 69 - Sqrt(x)
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force solution](#using-brute-force-solution)
- [Using binary search](#using-binary-search)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a non-negative integer `x`, return the square root of `x` rounded down to the nearest integer. The returned integer should be non-negative as well.

You must not use any built-in exponent function or operator.

For example, do not use `pow(x, 0.5)` in c++ or `x ** 0.5` in python.

- Example 1

    - Input: x = 4
    - Output: 2
    - Explanation: The square root of 4 is 2, so we return 2.

- Example 2

    - Input: x = 8
    - Output: 2
    - Explanation: The square root of 8 is 2.82842..., and since we round it down to the nearest integer, 2 is returned.

- Constraints:

    - `0 <= x <= 2^31 - 1`


<br>

## Using brute force solution

With this brute force solution, we will iterate all number from 1 to x. Then we will calculate the square of the number. After that, check that square with `x`.

```Java
public class Solution {
    public static int mySqrt(int x) {
        if (x == 0 || x == 1) {
            return x;
        }

        int i = 1;
        long res = 1;

        while (res <= x) {
            ++i;
            res = (long) i * i;
        }

        return i - 1;
    }
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(1)


<br>

## Using binary search

From the brute-force solution, we iterate all the natural numbers from 1 to `x` number. We can consider them as an array. Then, we can apply Binary Search algorithm for this problem.
- When our square is less than `x`, jump to the right side.
- When our square is greater than `x`, jump to the left side.

1. Using first invariant

    ```Java
    class Solution {
        public int mySqrt(int x) {
            if (x < 2) {
                return x;
            }

            int left = 1;
            int right = x / 2;
            int pos = -1;

            while (left <= right) {
                int mid = left + (right - left) / 2;
                long num = (long)mid * mid;

                if (num == x) {
                    return mid;
                }

                if (x < num) {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                    pos = mid;
                }
            }

            return pos;
        }
    }
    ```

2. Using third invariant

    ```Java
    class Solution {
        public int mySqrt(int x) {
            if (x < 2) {
                return x;
            }

            int left = 0;
            int right = x;

            while (left + 1 < right) {
                int mid = left + (right - left) / 2;
                long square = (long) mid * mid;

                if (square == x) {
                    return mid;
                }

                if (x < square) {
                    right = mid;
                } else {
                    left = mid;
                }
            }

            return left;
        }
    }
    ```

    But we can improve the above solution by using the notice: Floor of square root of x cannot be more than x/2 when `x > 1`.

    ```Java
    class Solution {
        public int mySqrt(int x) {
            if (x < 2) {
                return x;
            }

            if (x <= 5) {
                return x/2;
            }

            int left = 0;
            int right = x/2;

            while (left + 1 < right) {
                int mid = left + (right - left) / 2;
                long square = (long) mid * mid;

                if (square == x) {
                    return mid;
                }

                if (x < square) {
                    right = mid;
                } else {
                    left = mid;
                }
            }

            return left;
        }
    }
    ```

The complexity of this solution:
- Time complexity: O(logn)
- Space complexity: O(1)


<br>

## Wrapping up

- Use series of natural numbers as an array to apply Binary Search.

- When applying Binary Search, should notice the conditions to jump the left-hand side or right-hand side.


<br>

Refer:

[69. Sqrt(x)](https://leetcode.com/problems/sqrtx/description/)
