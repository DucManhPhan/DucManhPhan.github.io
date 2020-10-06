---
layout: post
title: Combination Sum
bigimg: /img/image-header/yourself.jpeg
tags: [Backtracking]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Backtracking algorithm](#using-backtracking-algorithm)
- [Using Unbounded Knapsack version](#using-unbounded-knapsack-version)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a set of candidate numbers (C) and a target number (T), find all unique combinations in C where the candidate numbers sums to T.

The same repeated number may be chosen from C unlimited number of times.

Note:
- All numbers (including target) will be positive integers.
- Elements in a combination (a1, a2, … , ak) must be in non-descending order. (ie, a1 ≤ a2 ≤ … ≤ ak).
- The combinations themselves must be sorted in ascending order.
- CombinationA > CombinationB iff (a1 > b1) OR (a1 = b1 AND a2 > b2) OR … (a1 = b1 AND a2 = b2 AND … ai = bi AND ai+1 > bi+1)
- The solution set must not contain duplicate combinations.

For example:

Given candidate set 2,3,6,7 and target 7, and a solution set is:

```
[2, 2, 3]
[7]
```


<br>

## Using Backtracking algorithm

```java
public static List<List<Integer>> combinationSum(int[] candidates, int target) {
    List<List<Integer>> res = new ArrayList<>();
    combinationSum(candidates, target, 0, res, new ArrayList<>(), 0);

    return res;
}

public static void combinationSum(int[] candidates, int target, int sum, List<List<Integer>> res, List<Integer> values, int idx) {
    if (sum > target) {
        return;
    }

    if (sum == target) {
        res.add(new ArrayList<>(values));
        return;
    }

    for (int i = idx; i < candidates.length; ++i) {
        values.add(candidates[i]);
        combinationSum(candidates, target, sum + candidates[i], res, values, i);
        values.remove(values.size() - 1);
    }
}
```

The complexity of this solution:
- Time complexity: O(2^n)
- Space complexity: O(2^n)


<br>

## Using Unbounded Knapsack version

The idea of this solution is:
- At each element, we can have two cases: add it into our array or not.
- The condition to stop is our sum of elements is equal to the **target**.

```java
public static List<List<Integer>> combinationSum(int[] candidates, int target) {
    List<List<Integer>> res = new ArrayList<>();
    combinationSum(candidates, target, 0, candidates.length, res, new ArrayList<>());
    return res;
}

public static void combinationSum(int[] candidates, int target, int i, int j, List<List<Integer>> res, List<Integer> values){
    if(i >= j || target < 0) return;
    if(target == 0){
        res.add(new ArrayList<>(values));
        return;
    }

    values.add(candidates[i]);
    combinationSum(candidates, target - candidates[i], i, j, res, values); //include item

    values.remove(values.size() - 1);
    combinationSum(candidates, target, i + 1, j, res, values); //dont include item
}
```


<br>

## Wrapping up

- Understanding about the structure of backtracking algorithm.


<br>

Refer:

[https://www.interviewbit.com/problems/combination-sum/](https://www.interviewbit.com/problems/combination-sum/)