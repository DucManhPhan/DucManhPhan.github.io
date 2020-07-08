---
layout: post
title: Three sum to Zero
bigimg: /img/image-header/yourself.jpeg
tags: [Two-Pointers, Hash-Map]
---




<br>

## Table of contents





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
public static List<List<Integer>> searchTripletsNormal(int[] arr) {
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

```java


```

The complexity of this solution:
- Time complexity: O(n^2)
- Space complexity: O(n)


<br>

## Wrapping up




<br>

Refer:

[]()