---
layout: post
title: Combination Sum II
bigimg: /img/image-header/yourself.jpeg
tags: [Backtracking]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using backtracking algorithm](#using-backtracking-algorithm)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a collection of candidate numbers (C) and a target number (T), find all unique combinations in C where the candidate numbers sums to T.

Each number in C may only be used once in the combination.

Note:
- All numbers (including target) will be positive integers.
- Elements in a combination (a1, a2, … , ak) must be in non-descending order. (ie, a1 ≤ a2 ≤ … ≤ ak).
- The solution set must not contain duplicate combinations.

Example :

```java
Given candidate set 10,1,2,7,6,1,5 and target 8,

A solution set is:

[1, 7]
[1, 2, 5]
[2, 6]
[1, 1, 6]
```


<br>

## Using backtracking algorithm

The solution of this problem is as same as the [Combination Sum](https://ducmanhphan.github.io/2020-05-07-combination-sum/) problem. But to remove all duplicate combinations, we need to sort our array at first.


```java
public static List<List<Integer>> combinationSum2(int[] candidates, int target) {
    List<List<Integer>> res = new ArrayList<>();
    Arrays.sort(candidates);
    combinationSum2(candidates, target, res, new ArrayList<>(), 0);

    return res;
}

public static void combinationSum2(int[] candidates, int target, List<List<Integer>> res, List<Integer> values, int idx) {
    if (target < 0) {
        return;
    }

    if (target == 0) {
        res.add(new ArrayList<>(values));
        return;
    }

    for (int i = idx; i < candidates.length; ++i) {
        if (idx != i && candidates[i] == candidates[i - 1]) {
            continue;
        }

        values.add(candidates[i]);
        combinationSum2(candidates, target - candidates[i], res, values, i + 1);
        values.remove(values.size() - 1);
    }
}
```

The complexity of this solution:
- Time complexity: O(n * C(k, n)).


<br>

## Wrapping up

- Understanding about the structure of the backtracking algorithm.


<br>

Refer:

[https://en.wikipedia.org/wiki/External_sorting](https://en.wikipedia.org/wiki/External_sorting)