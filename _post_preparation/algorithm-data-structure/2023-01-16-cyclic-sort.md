---
layout: post
title: Cyclic sort
bigimg: /img/image-header/yourself.jpeg
tags: [Algorithm, Sorting]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of Cyclic Sort](#solution-of-cyclic-sort)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution of Cyclic Sort


```Java
public static void cyclicSort(int[] nums) {
    int start = 0;

    while (start < nums.length) {
        int current = nums[start] - 1;

        if (nums[start] != nums[current]) {
            swap(nums, start, current);
        } else {
            ++start;
        }
    }
}

private static void swap(int[] nums, int x, int y) {
    int tmp = nums[x];
    nums[x] = nums[y];
    nums[y] = tmp;
}

public static void main(String[] args) {
            int[] nums = {3, 1, 5, 4, 2};
//        int[] nums = {2, 6, 4, 3, 1, 5};
//        int[] nums = {1, 5, 6, 4, 3, 2};

        cyclicSort(nums);
        System.out.println(Arrays.toString(nums));
}
```

The complexity of this Cyclic Sort:
- Time complexity: O(n)
- Space complexity: O(1)


<br>

## When to use

- 
- 
- 


<br>

## Benefits and Drawbacks

1. Benefits


2. Drawbacks


<br>

## Wrapping up




<br>

Refer:

[]()