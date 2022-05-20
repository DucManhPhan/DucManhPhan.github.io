---
layout: post
title: Leetcode 209 - Minimum Size Subarray Sum
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute-force solution](#using-brute-force-solution)
- [Using Binary Search algorithm with Prefix-sum](#using-binary-search-algorithm-with-prefix-sum)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given an array of positive integers `nums` and a positive integer `target`, return the minimal length of a contiguous subarray `[numsl, numsl+1, ..., numsr-1, numsr]` of which the sum is greater than or equal to `target`. If there is no such subarray, return 0 instead.

For example:
- Example 1:

    ```
    Input: target = 7, nums = [2,3,1,2,4,3]
    Output: 2
    Explanation: The subarray [4,3] has the minimal length under the problem constraint.
    ```

- Example 2:

    ```
    Input: target = 4, nums = [1,4,4]
    Output: 1
    ```

- Example 3:

    ```
    Input: target = 11, nums = [1,1,1,1,1,1,1,1]
    Output: 0
    ```

Constraints:
- `1 <= target <= 109`
- `1 <= nums.length <= 105`
- `1 <= nums[i] <= 105`


<br>

## Using brute-force solution

In this case, we need to iterate all contiguous subarrays in the `nums` array. So below is some steps to iterate all of them.
- Use two loops.

    - The outer loop will be used to mark the beginning of the current subarray.
    - The inner loop will be used to iterate all elements from that index of the outer loop.

        - Calculate sum
        - Then, compare sum with `target`'s value.

So, we have brute-force solution for this problem.

```java
class Solution {
    public int minSubArrayLen(int target, int[] nums) {
        int minSize = Integer.MAX_VALUE;
        int outerIdx = -1;
        int innerIdx = -1;

        for (outerIdx = 0; outerIdx < nums.length; ++outerIdx) {
            int sum = 0;
            for (innerIdx = outerIdx; innerIdx < nums.length; ++innerIdx) {
                sum += nums[innerIdx];

                if (sum >= target) {
                    minSize = Math.min(minSize, innerIdx - outerIdx + 1);
                    break;
                }
            }
        }

        if (minSize == Integer.MAX_VALUE) {
            return 0;
        }

        return minSize;
    }
}
```

The complexity of this solution:
- Time complexity: O(n^2)
- Space complexity: O(1)


<br>

## Using Binary Search algorithm with Prefix-sum


```java
class Solution {
    public int minSubArrayLen(int target, int[] nums) {
        int size = nums.length;
        if (size == 0) {
            return 0;
        }

        int[] sums = new int[size + 1];
        Arrays.fill(sums, 0);

        for (int i = 1; i <= size; ++i) {
            sums[i] = sums[i - 1] + nums[i - 1];
        }

        System.out.println("Sums: " + Arrays.toString(sums));
        int minSubArraySize = Integer.MAX_VALUE;

        for (int i = 1; i <= size; ++i) {
            int value = target + sums[i - 1];
            int idx = lowerBound(sums, value);
            if (idx != -1) {
                minSubArraySize = Math.min(minSubArraySize, idx - i + 1);
            }
        }

        return (minSubArraySize != Integer.MAX_VALUE) ? minSubArraySize : 0;   
    }
    
    private static int lowerBound(int[] prefixSum, int target) {
        int low = -1;
        int high = prefixSum.length;

        while (low + 1 != high) {
            int mid = low + (high - low) / 2;

            if (prefixSum[mid] < target) {
                low = mid;
            } else {
                high = mid;
            }
        }

        if (high < prefixSum.length) {
            return high;
        }

        return -1;
    }
}
```

The complexity of this solution:
- Time complexity: O(nlogn)
- Space complexity: O|(n)


<br>

## Wrapping up




<br>

Refer:

[209. Minimum Size Subarray Sum](https://leetcode.com/problems/minimum-size-subarray-sum/)