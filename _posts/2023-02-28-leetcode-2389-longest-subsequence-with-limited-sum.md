---
layout: post
title: Leetcode 2389 - Longest Subsequence With Limited Sum
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search, Prefix Sum, Queue, Backtracking]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Backtracking algorithm](#using-backtracking-algorithm)
- [Using Binary Search algorithm](#using-binary-search-algorithm)
- [Using Tree Map with Binary Search](#using-tree-map-with-binary-search)
- [Using Priority Queue](#using-priority-queue)
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

This problem relates to the sum of subsequences in an array. And we need to find the maximum size of a subsequence whose sum is less than or equal to the specific element in `queries` array.

Below is our source code:

```Java
class Solution {
    public int[] answerQueries(int[] nums, int[] queries) {
        Arrays.sort(nums);

        // calculate prefix sum array
        int[] prefixSum = new int[nums.length];
        prefixSum[0] = nums[0];

        for (int i = 1; i < nums.length; i++) {
            prefixSum[i] = prefixSum[i - 1] + nums[i];
        }

        // calculate the result array
        int[] res = new int[queries.length];
        int i = 0;
        for (int sum : queries) {
            int pos = upperBound(prefixSum, sum);
            if (pos == -1) {
                res[i++] = 0;
            } else {
                res[i++] = pos + 1;
            }            
        }

        return res;
    }

    /**
     * Find an element's index that is less or equal than target
     */
    private int upperBound(int[] prefixSum, int target) {
        int left = 0;
        int right = prefixSum.length;

        while (left + 1 < right) {
            int mid = left + (right - left) / 2;

            if (prefixSum[mid] == target) {
                return mid;
            }

            if (prefixSum[mid] < target) {
                left = mid;
            } else {
                right = mid;
            }
        }

        if (prefixSum[left] <= target) {
            return left;
        }

        return -1;
    }
}
```

The complexity of this solution is:
- Time complexity: `O(mlogn)` with `m` is the size of `queries` array and `n` is the size of `nums` array.
- Space complexity: `O(m)`.

To further optimize the current solution, we can try the following solution. It takes only 3 ms in LeetCode, while our solution takes 6 ms.

```Java
class Solution {
    public int[] answerQueries(int[] nums, int[] queries) {
        Arrays.sort(nums);

        // calculate the prefix sum in-place
        for (int i = 1; i < nums.length; ++i) {
            nums[i] += nums[i - 1];
        }

        int[] res = new int[queries.length];
        for (int i = 0; i < queries.length; ++i) {
            int j = 0;

            if (queries[i] >= nums[nums.length - 1]) {
                res[i] = nums.length;
            } else {
                while (nums[j] <= queries[i]) {
                    ++j;
                }

                res[i] = j;
            }
        }

        return res;
    }
}
```


<br>

## Using Tree Map with Binary Search

In Java, TreeMap supports the `floorKey()` method that returns the greatest key less than or equal to the given key, or null if there is no such key. This method is suitable for our case when we need to find the element's index in prefix sum array.

Below is our source code:

```Java
class Solution {
    public int[] answerQueries(int[] nums, int[] queries) {
        Arrays.sort(nums);

        int sum = 0;
        TreeMap<Integer, Integer> treeMap = new TreeMap<>();
        treeMap.put(0, 0);

        for (int i = 0; i < nums.length; ++i) {
            sum += nums[i];
            treeMap.put(sum, i + 1);
        }

        int[] res = new int[queries.length];
        for (int i = 0; i < queries.length; ++i) {
            int key = treeMap.floorKey(queries[i]);
            res[i] = treeMap.get(key);
        }

        return res;
    }
}
```


<br>

## Using Priority Queue

Currently, we use Priority Queue to maintain the sum of its elements is always less or equal to an element of `queries` array. When `sum + nums[i] > queries[j]`, we will remove the max element in Priority Queue to satisfy our condition and add the current element to this queue.

Below is our source code:

```Java
class Solution {
    public int[] answerQueriesV1(int[] nums, int[] queries) {
        int[] res = new int[queries.length];
        int k = 0;

        for (int max : queries) {
            PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
            int sum = 0;

            for (int n : nums) {
                if (sum + n > max) {
                    if (!pq.isEmpty() && pq.peek() > n) {
                        sum -= pq.remove();
                        sum += n;
                        pq.add(n);
                    }
                } else {
                    sum += n;
                    pq.add(n);
                }
            }

            res[k++] = pq.size();
        }

        return res;
    }
}
```


<br>

## Wrapping up




<br>

Refer:

[2389. Longest Subsequence With Limited Sum](https://leetcode.com/problems/longest-subsequence-with-limited-sum/)
