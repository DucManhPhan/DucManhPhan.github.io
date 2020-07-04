---
layout: post
title: Max consecutive Ones II
bigimg: /img/image-header/yourself.jpeg
tags: [Array, Sliding Window]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm](#using-brute-force-algorithm)
- [Using Sliding window algorithm](#using-sliding-window-algorithm)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a binary array, find the maximum number of consecutive 1s in this array if you can flip at most one 0.

```
Example 1:
Input: [1,0,1,1,0]
Output: 4
Explanation: Flip the first zero will get the the maximum number of consecutive 1s.
    After flipping, the maximum number of consecutive 1s is 4.
```

Some constraints:
- The input array will only contain 0 and 1.
- The length of input array is a positive integer and will not exceed 10,000

Follow up:
What if the input numbers come in one by one as an infinite stream? In other words, you can't store all numbers coming from the stream as it's too large to hold in memory. Could you solve it efficiently?

<br>

## Using brute force algorithm

1. Use two loop to scan all elements

    Our brute force algorithm of this problem will be followed by some steps:
    - In outer loop, set the start index for inner loop.
    - In inner loop, from the start index of outer loop, iterate elements to the last element.

        Check each element is equal to 1, increase the length of the consecutive 1s.

        When encountering the 0, decrease the number of 0. If the number of 0 is less than 1, get out of the inner loop.

        Comparing between the current length of the consecutive 1s with the maximum length 1s.

    Below is the source code of the brute force algorithm.

    ```java
    public static int findMaxConsecutiveOnes(int[] nums) {
        int max = Integer.MIN_VALUE;

        for (int i = 0; i < nums.length; ++i) {
            int length = 0;
            int k = 1;  // the number of 0s
            for (int j = i; j < nums.length; ++j) {
                if (nums[j] == 1) {
                    ++length;
                } else {
                    --k;
                    if (k == 0) {
                        ++length;
                    } else {
                        break;
                    }
                }
            }

            max = Math.max(max, length);
        }

        return max;
    }
    ```

    The complexity of this problem:
    - Time complexity: O(n^2)
    - Space complexity: O(1)

2. Use an array to mark all indexes of 0 elements

    - After identifying all indexes of 0 elements, we will iterate this array, and replace the value of that position to 1.

    - Then, each loop, count the maximum consecutive 1s.

    ```java
    public int findMaxConsecutiveOnes(int[] nums) {
        int len = nums.length;
        List<Integer> zeroIdx = new ArrayList<>();
        for (int i = 0; i < len; i++) {
            if (nums[i] == 0) zeroIdx.add(i);
        }

        if (zeroIdx.isEmpty()) {
            return getMaxUtil(nums);
        }

        int result = 0;
        for (Integer i : zeroIdx) {
            nums[i] = 1;
            result = Math.max(result, getMaxUtil(nums));
            nums[i] = 0;
        }

        return result;
    }

    public int getMaxUtil(int[] nums) {
        int max = 0;
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 1) {
                count++;
            } else {
                max = Math.max(max, count);
                count = 0;
            }
        }
        return Math.max(max, count);
    }
    ```

    The complexity of this way:
    - Time complexity: O(n^2)
    - Space complexity: O(n)

<br>

## Using Sliding window algorithm

To optimize the brute force algorithm, we can use sliding window algorithm to solve it.

```java
public int findMaxConsecutiveOnes(int[] nums) {
    int maxLength = 0;
    int windowStart = 0;
    int maxFlipOperations = 1;
    int maxConsecutive1s = 0;

    for (int windowEnd = 0; windowEnd < nums.length; ++windowEnd) {
        if (nums[windowEnd] == 1) {
            ++maxConsecutive1s;
        }

        if (windowEnd - windowStart + 1 - maxConsecutive1s > maxFlipOperations) {
            if (nums[windowStart] == 1) {
                --maxConsecutive1s;
            }

            ++windowStart;
        }

        maxLength = Math.max(maxLength, windowEnd - windowStart + 1);
    }

    return maxLength;
}
```

The complexity of this way:
- Time complexity: O(n)
- Space complexity: O(1)

<br>

## Wrapping up

- Always starting from the brute force algorithm, then identify the bottleneck, optimize it.

- With the problem that is to get the specific property of the subarray, we can use Sliding Window algorithm to solve it.

<br>

Refer:

[https://leetcode.com/problems/max-consecutive-ones-ii/](https://leetcode.com/problems/max-consecutive-ones-ii/)