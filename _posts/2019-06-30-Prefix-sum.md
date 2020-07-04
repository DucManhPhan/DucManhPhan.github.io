---
layout: post
title: Prefix sum
bigimg: /img/image-header/yourself.jpeg
tags: [Prefix Sum]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using prefix sum algorithm](#using-prefix-sum-algorithm)
- [When to use](#when-to-use)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Supposed we have an array like that:

```java
int[] nums = {3, 4, 2, 6, 8, 9}
```

We need to calculate the sum of the subarray from:
- 0 --> 2
- 2 --> 4
- 1 --> 3
- ...


<br>

## Using brute force algorithm

The normal way to deal with it is that we will iterate all elements from i index to j index. Then, we will calculate the sum of this subarray.

Below is the source code of this algorithm.

```java
public static int bruteForceSumSubarray(int[] nums, int start, int end) {
    if (nums == null) {
        return 0;
    }

    int sum = 0;
    for (int i = start; i <= end; ++i) {
        sum += nums[i];
    }

    return sum;
}
```

When we have m queries, the time complexity of this algorithm:
- Time complexity: O(n * m), n is the size of array
- Space complexity: O(1)


<br>

## Using prefix sum algorithm

The idea of prefix sum technique is that it describes a way to pre-compute the cummulative sum for each value in a sequence. So they can be used later for a faster calculation of the total between the given indexes.

Supposed we have an array like that:

```java
int[] nums = {3, 4, 2, 6, 8, 9}
```

Our problem is that we need to calculate a new array ```prefixSum``` that satisfies some properties:

```javascript
prefixSum[0] = nums[0]
prefixSum[1] = prefixSum[0] + nums[1]
prefixSum[2] = prefixSum[1] + nums[2]

...

prefixSum[i] = prefixSum[i - 1] + nums[i]
```

Below is the source code of prefix sum algorithm.

```java
public static void main(String[] args) {
    int[] nums = {3, 4, 2, 6, 8, 9};
    int[] prefixSum = new int[nums.length];

    calculatePrefixSum(nums, prefixSum);
    IntStream.of(prefixSum).forEach(item -> System.out.print(item + " --> "));
    System.out.println(" null ");
}

public static void calculatePrefixSum(int[] nums, int[] prefixSum) {
    if (nums == null || prefixSum == null) {
        return;
    }

    int length = nums.length;
    if (length == 0) {
        return;
    }

    prefixSum[0] = nums[0];
    for (int i = 1; i < length; ++i) {
        prefixSum[i] = prefixSum[i - 1] + nums[i];
    }
}

public static int sumSubarrayWithPrefixSum(int[] prefixSum, int start, int end) {
    int previousSum = start == 0 ? 0 : prefixSum[start - 1];
    return prefixSum[end] - previousSum;
}
```

The complexity of this algorithm:
- Time complexity: O(n + m)
- Space complexity: O(n)


<br>

## When to use

- When we have multiple queries for our array.



<br>

## Wrapping up

- This prefix sum algorithm applied in Counting sort.


<br>

Refer:

[https://www.cs.cmu.edu/~guyb/papers/Ble93.pdf](https://www.cs.cmu.edu/~guyb/papers/Ble93.pdf)

[https://codility.com/media/train/3-PrefixSums.pdf](https://codility.com/media/train/3-PrefixSums.pdf)