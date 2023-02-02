---
layout: post
title: Leetcode 441 - Arranging Coins
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

You have `n` coins and you want to build a staircase with these coins. The staircase consists of `k` rows where the ith row has exactly `i` coins. The last row of the staircase may be incomplete.

Given the integer `n`, return the number of complete rows of the staircase you will build.

Example 1:
- Input: n = 5
- Output: 2
- Explanation: Because the 3rd row is incomplete, we return 2.

Example 2:
- Input: n = 8
- Output: 3
- Explanation: Because the 4th row is incomplete, we return 3.

Constraints:
- 1 <= n <= 2^31 - 1


<br>

## Using brute force algorithm

With this problem, we only need to calculate the number of rows that contains the full coins. If the specific row includes the number coins that is less than the default coin of that row, break it.

```Java
class Solution {
    public int arrangeCoins(int n) {
        if (n == 1) {
            return n;
        }

        int coin = 1;
        int remaining = n;

        while (remaining >= 0) {
            if (remaining < coin) {
                return --coin;
            }

            remaining -= coin;
            ++coin;
        }

        return -1;
    }
}
```

The complexity of this solution:
- Time complexity: `O(n)`.
- Space complexity: `O(1)`.


<br>

## Using Binary Search algorithm

1. Reproduce the staircase array that contains `k` coins on `kth` row. Using Binary Search on this array.

    The easiest way to improve the performance of brute-force algorithm is to we create the original stair case. And we will use Binary Search algorithm on this array. It increases the time complexity from `O(n)` to `O(log_2(n))`.

    Note that our stair case array follow the monotonic function. It means that our array can contain the express upward trend or downward trend in a segment of elements. Based on this property, we are able to use Binary Search algorithm.

    ```Java
    class Solution {
        public int arrangeCoins(int n) {
            if (n == 1) {
                return n;
            }

            List<Integer> stairCase = this.buildStairCase(n);

            int left = 0;
            int right = stairCase.size();

            while (left + 1 < right) {
                int mid = left + (right - left) / 2;

                if (mid > 0 && stairCase.get(mid - 1) < stairCase.get(mid)) {
                    left = mid;
                } else {
                    right = mid;
                }
            }

            if (left == 0 || stairCase.get(left - 1) < stairCase.get(left)) {
                return left + 1;
            }      

            return stairCase.size();
        }

        private List<Integer> buildStairCase(int n) {
            List<Integer> stairCase = new ArrayList<>();

            int coin = 1;
            int remaining = n;

            while (remaining > 0) {
                if (remaining < coin) {
                    coin = remaining;
                }

                stairCase.add(coin);

                remaining -= coin;
                coin++;
            }

            return stairCase;
        }
    }
    ```

    The complexity of this solution is:
    - Time complexity: `O(log_2(stair_case_array_length))`.
    - Space complexity: `O(stair_case_array_length)`.

2. Only using Binary Search.

    The downside of the above solution is that the space complexity is `O(n)`. So our current question is "Are we able to use Binary Search without using stair case array?"

    The answer is yes.
    
    Below is some crucial points that we need to point out when using the third invariant of Binary Search.
    - Initial condition: `left = 0`, `right = n`.
    - Terminatated condition: `left + 1 = right`.

        We should remember the meaning of `left` and `right` pointers:
        - The `left` will always point to the maximum element that is less than the `target` or monotic function `f(mid) < target`.
        - The `right` will always point to the minimum element that is greater than the `target` or monotic function `f(mid) > target`.

        In the current problem, our monotonic function is the function that calculate the number of coins at the current position --> `[mid * (mid + 1)] / 2`.

    - Searching left side: `right = mid`.
    - Searching right side: `left = mid`.

    Then, we have our source code.

    ```Java
    class Solution {
        public int arrangeCoins(int n) {
            if (n == 1) {
                return n;
            }

            int left = 0;
            int right = n;

            while (left + 1 < right) {
                int mid = left + (right - left) / 2;
                long coins = ((long)(mid + 1) * mid) / 2;

                if (coins == n) {
                    return mid;
                }

                if (coins < n) {
                    left = mid;
                } else {
                    right = mid;
                }
            }

            return left;
        }
    }
    ```

    The complexity of this solution:
    - Time complexity: `O(log_2(n))`.
    - Space complexity: `O(1)`.


<br>

## Wrapping up




<br>

Refer:

[441. Arranging Coins](https://leetcode.com/problems/arranging-coins/description/)
