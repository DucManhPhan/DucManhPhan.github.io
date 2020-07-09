---
layout: post
title: Quick Find
bigimg: /img/image-header/california.jpg
tags: [Union-Find]
---

In this tutorial, we will find out about quick find - one of implementations in Union-Find. And understanding Quick Find has advantages and disadvantages that will make us confidence to implement.

<br>

## Table of contents
- [Introduction to Quick Find](#introduction-to-quick-find)
- [Source code](#source-code)
- [Drawbacks of Quick Find](#drawbacks-of-quick-find)
- [Application of Quick Find](#application-of-quick-find)

<br>

## Introduction to Quick Find
A disjoint-set is a data structure that keeps track of a set of elements partitioned into a number of disjoint (non-overlapping) subsets. A Union-Find algorithm is an algorithm that performs two useful operations on such a data structure:

- Find: Determine which subset a particular elements is in. This can be used for determining if two elements are in the same subset.
- Union: Join two subsets into a single subset.

And Quick Find is one of the implementations of Union-Find algorithm.

<br>

## Source code
- Data structure
    - Maintain array id[] with name for each component.
    - If p and q are connected, then same id.
    - Initialize id[i] = i.

- Find operation: check if p and q have the same id.

- Union operation: to merge components containing p and q, change all entries whose id equals id[p] and id[q]. So, we have a problem: many values can be changed.

- Analysis: 
    - Find operation takes a constant number of operations.
    - Union operation takes time proportional to N. This is very slow.

```java
public class QuickFindUF {
    private int[] id;
    
    // set id of each object to itself (N array access)
    public QuickFindUF(int N) {
        id = new int[N];
        for (int i = 0; i < N; ++i) {
            id[i] = i;
        }
    }
    
    int find(int i) {
        return id[i];
    }

    // check whether p and q are in the same
    // component (2 array access)
    public boolean connected(int p, int q) {
        return id[p] == id[q];
    }
    
    // change all entries with id[p] to id[q]
    // (at most 2N + 2 array access
    public void union(int p, int q) {
        int pid = id[p];
        int qid = id[q];
        
        for (int i = 0; i < id.length; ++i) {
            if (id[i] == pid) {
                id[i] = qid;
            }
        }
    }
}

```


<br>

## Drawbacks of Quick Find
- Cost model: number of array access (for read and write)

    |   algorithm    |  initialize  | union  |  find   |
    | -------------- | ------------ | ------ | ------- |
    | quick-find     | N            | N      | 1       |

- Quick find defect: Union operation is too expensive

    Takes N^2 array accesses to process sequence of N union commands on N objects.

    In particular, if we just have N union commands on N objects which is not unreasonable. They're either connected or not when that will take quadratic time in squared time. It's much to slow. And we can not accept quadratic time algorithms for large problems. The reason is they do not scale.

<br>

Thanks for your reading.

