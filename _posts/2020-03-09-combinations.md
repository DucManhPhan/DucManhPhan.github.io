---
layout: post
title: Combinations
bigimg: /img/image-header/yourself.jpeg
tags: [Backtracking]
---




<br>

## Table of contents

- [Given problem](#given-problem)
- [Using Backtracking algorithm](#using-backtracking-algorithm)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given two integers n and k, return all possible combinations of k numbers out of 1 2 3 ... n.

Make sure the combinations are sorted.

To elaborate,
- Within every entry, elements should be sorted. [1, 4] is a valid entry while [4, 1] is not.
- Entries should be sorted within themselves.

Example :

```
If n = 4 and k = 2, a solution is:

[
  [1,2],
  [1,3],
  [1,4],
  [2,3],
  [2,4],
  [3,4],
]
```

<br>

## Using Backtracking algorithm


```java
public static List<List<Integer>> combine(int n, int k) {
    List<List<Integer>> res = new ArrayList<>();
    combine(n, k, res, new ArrayList<>(), 1);

    return res;
}

public static void combine(int n, int k, List<List<Integer>> res, List<Integer> values, int idx) {
    if (values.size() == k) {
        res.add(new ArrayList<>(values));
        return;
    }

    for (int i = idx; i <= n; ++i) {
        values.add(i);
        combine(n , k, res, values, i + 1);
        values.remove(values.size() - 1);
    }
}
```

The complexity of this solution:
- Time complexity: O(k * C(k, n))
- Space complexity: O(C(k, n))

<br>

## Wrapping up

- Understanding about the structure of subset problems when using backtracking algorithm.


<br>

Refer:

[https://www.interviewbit.com/problems/combinations/](https://www.interviewbit.com/problems/combinations/)