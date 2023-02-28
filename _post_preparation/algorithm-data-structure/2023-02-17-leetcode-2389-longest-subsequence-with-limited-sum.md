---
layout: post
title: Leetcode 2389 - Longest Subsequence With Limited Sum
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Backtracking algorithm](#using-backtracking-algorithm)
- [Using Binary Search algorithm](#using-binary-search-algorithm)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

You are given an integer array `nums` of length `n`, and an integer array queries of length `m`.

Return an array answer of length `m` where `answer[i]` is the maximum size of a subsequence that you can take from `nums` such that the sum of its elements is less than or equal to `queries[i]`.

A subsequence is an array that can be derived from another array by deleting some or no elements without changing the order of the remaining elements.

Example 1:
- Input: `nums = [4,5,2,1]`, `queries = [3,10,21]`
- Output: `[2,3,4]`
- Explanation: We answer the queries as follows:

    - The subsequence `[2,1]` has a sum less than or equal to 3. It can be proven that 2 is the maximum size of such a subsequence, so `answer[0] = 2`.
    - The subsequence `[4,5,1]` has a sum less than or equal to 10. It can be proven that 3 is the maximum size of such a subsequence, so `answer[1] = 3`.
    - The subsequence `[4,5,2,1]` has a sum less than or equal to 21. It can be proven that 4 is the maximum size of such a subsequence, so `answer[2] = 4`.

Example 2:
- Input: `nums = [2,3,4,5]`, `queries = [1]`
- Output: `[0]`
- Explanation: The empty subsequence is the only subsequence that has a sum less than or equal to 1, so `answer[0] = 0`.

Constraints:
- `n == nums.length`
- `m == queries.length`
- `1 <= n, m <= 1000`
- `1 <= nums[i], queries[i] <= 106`


<br>

## Using Backtracking algorithm

Obviously, we will start working on this problem by using backtracking algorithm to get all cases of subsequences.

Below is the source code for this solution:

```Java
class Solution {
    public int[] answerQueries(int[] nums, int[] queries) {
        List<Integer> subsequences = new ArrayList<>();
        int[] res = new int[queries.length];

        maxLengthOfSubsequences(nums, queries, 0, res, subsequences);
        return res;
    }

    private void maxLengthOfSubsequences(int[] nums, int[] queries, int idx, int[] res, List<Integer> subsequences) {
        if (idx >= nums.length) {
            saveMaxLength(queries, res, subsequences);
            return;
        }

        if (subsequences.size() != 0) {
            saveMaxLength(queries, res, subsequences);
        }

        for (int i = idx; i < nums.length; ++i) {
            subsequences.add(nums[i]);
            maxLengthOfSubsequences(nums, queries, i + 1, res, subsequences);
            subsequences.remove(subsequences.size() - 1);
        }
    }

    private void saveMaxLength(int[] queries, int[] res, List<Integer> subsequences) {
        int currentSum = subsequences.stream()
                              .reduce(0, Integer::sum);

        int i = 0;
        for (int val : queries) {
            if (currentSum <= val) {
                res[i] = Math.max(res[i], subsequences.size());
            }

            ++i;
        }
    }
}
```

The complexity of this solution:
- Time complexity: 

    When running this solution on LeetCode, we run into the Time Limit Exceed issue. We need to try the other ways.

- Space complexity: 


<br>

## Using Binary Search algorithm





<br>

## Wrapping up




<br>

Refer:

[2389. Longest Subsequence With Limited Sum](https://leetcode.com/problems/longest-subsequence-with-limited-sum/)
