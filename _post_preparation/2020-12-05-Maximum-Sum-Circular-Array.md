---
layout: post
title: Maximum Sum Circular Array
bigimg: /img/image-header/california.jpg
tags: [Data Structure, Array]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force way](#using-brute-force-way)
- []()
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Using brute force way

To use brute force way, we will scan all cases of subarray from one element to the entire elements.


```java
public static void main(String[] args) {
//        int[] nums = {1,-2,3,-2};
//        int[] nums = {5,-3,5};
//        int[] nums = {3,-1,2,-1};
//        int[] nums = {3,-2,2,-3};
    int[] nums = {-2,-3,-1};
//        int[] nums = {3,1,3,2,6};

    int res = maxSubarraySumCircular(nums);
    System.out.println(res);
}

public static int maxSubarraySumCircular(int[] A) {
    int len = A.length;
    int max = A[0];

    for (int start = 0; start < len; ++start) {
        for (int end = start + 1; end <= len + start; ++end) {
            int sum = 0;
            for (int i = start; i < end; ++i) {
                sum += A[i % len];  // use for circular array
            }

            max = Math.max(max, sum);
        }
    }

    return max;
}
```

The complexity of this brute force:
- Time complexity: O(n^3)
- Space complexity: O(1)

<br>

## 






<br>

## Wrapping up



