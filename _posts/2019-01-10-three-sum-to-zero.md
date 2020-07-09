---
layout: post
title: Three sum to Zero
bigimg: /img/image-header/yourself.jpeg
tags: [Two-Pointers, Hash-Map]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm](#using-brute-force-algorithm)
- [Using hashmap data structure](#using-hashmap-data-structure)
- [Using two pointers technique](#using-two-pointers-technique)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given an array of unsorted numbers, find all unique triplets in it that add up to zero.

```
Example 1:
    Input: [-3, 0, 1, 2, -1, 1, -2]
    Output: [-3, 1, 2], [-2, 0, 2], [-2, 1, 1], [-1, 0, 1]
    Explanation: There are four unique triplets whose sum is equal to zero.

Example 2:
    Input: [-5, 2, -1, -2, 3]
    Output: [[-5, 2, 3], [-2, -1, 3]]
    Explanation: There are two unique triplets whose sum is equal to zero.
```


<br>

## Using brute force algorithm

In the brute force algorithm, we will use three loops to get all cases of subarrays with size = 3.

Below is the source code of this algorithm.

```java
public static List<List<Integer>> searchTriplets(int[] arr) {
    List<List<Integer>> triplets = new ArrayList<>();

    for (int i = 0; i < arr.length - 2; ++i) {
        for (int j = i + 1; j < arr.length - 1; ++j) {
            for (int k = j + 1; k < arr.length; ++k) {
                List<Integer> res = new ArrayList<>();
                if (arr[i] + arr[j] + arr[k] == 0) {
                    res.add(arr[i]);
                    res.add(arr[j]);
                    res.add(arr[k]);

                    triplets.add(res);
                }
            }
        }
    }

    return triplets;
}
```

The complexity of this solution:
- Time complexity: O(n^3)
- Space complexity: O(1)


<br>

## Using hashmap data structure

Before jumping into this solution, we need to refer the two sum problem. Then, continue applying hashmap data structure, we will need to sort an array.

Finally, we will consider the three sum problem is the expansion way of the two sum problem.

```java
public static List<List<Integer>> searchTriplets(int[] arr) {
    List<List<Integer>> triplets = new ArrayList<>();
    Arrays.sort(arr);

    for (int i = 0; i < arr.length; ++i) {
        if (i > 0 && arr[i] == arr[i - 1]) {
            continue;
        }

        searchPair(arr, -arr[i], i + 1, triplets);
    }

    return triplets;
}

private static void searchPair(int[] arr, int targetSum, int left, List<List<Integer>> triplets) {
    Map<Integer, Integer> valueIndexMap = new HashMap<>();

    for (int i = left; i < arr.length; ++i) {
        if (valueIndexMap.containsKey(targetSum - arr[i])) {
            List<Integer> tmp = new ArrayList<>(Arrays.asList(-targetSum, arr[i], targetSum - arr[i]));
            if (triplets.size() > 0 && tmp.equals(triplets.get(triplets.size() - 1))) {
                continue;
            }

            triplets.add(tmp);
        }

        valueIndexMap.put(arr[i], i);
    }
}
```

The complexity of this solution:
- Time complexity: O(n^2)
- Space complexity: O(n)


<br>

## Using two pointers technique

To apply the two pointers technique, we also need to sort an array. Then, we will find two values that satisfies their sum is equal to the choosen element's value.

```java
public static List<List<Integer>> searchTriplets(int[] nums) {
    if (nums == null) {
        return null;
    }

    Arrays.sort(nums);
    List<List<Integer>> res = new ArrayList<List<Integer>>();

    for (int i = 0; i < nums.length - 2; i++) {
        int begin = i + 1;
        int end = nums.length - 1;

        while (begin < end) {
            if (nums[begin] + nums[end] == -nums[i]) {
                List<Integer> arr = new ArrayList<Integer>(Arrays.asList(nums[i], nums[end], nums[begin]));
                res.add(arr);

                ++begin;
                --end;
            } else if (nums[begin] + nums[end] < -nums[i]) {
                begin++;
            } else {
                end--;
            }
        }
    }

    return res;
}
```

The complexity of this solution:
- Time complexity: O(nlogn + n^2) --> O(n^2)
- Space complexity: O(n)


<br>

## Wrapping up

- To apply the two pointers technique, we need an array is sorted or the relationship between the elements's value at index = begin or end that satisfies any conditions.
