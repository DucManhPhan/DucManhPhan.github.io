---
layout: post
title: How to apply Catalan number into solving problems
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Algorithm]
---




<br>

## Table of contents
- [Introduction to catalan number](#introduction-to-catalan-number)
- [Applications of catalan number](#applications-of-catalan-number)
- [Solving the parentheses problem](#solving-the-parentheses-problem)


<br>

## Introduction to catalan number
Catalan numbers are defined using the fomula:

![Catalan number](../img/Algorithm/catalan-number/catalan-number-1.png)

Or we can define them with recursive version:

![Catalan number with recursion](../img/Algorithm/catalan-number/catalan-number-2.png)

<br>

## Applications of catalan number
- Number of possible Binary Search Trees with n keys.

- Number of expressions containing n pairs of parentheses which are correctly matched.

- Number of ways a convex polygon of n + 2 sides can split into triangles by connecting vertices.

    ![Convex polygon](../img/Algorithm/catalan-number/convex-catalan.jpg)

- Number of full binary trees (A rooted binary tree is full if every vertex has either two children or no children) with n + 1 nodes.

- Number of different unlabeled binary trees can be there with n nodes.

- The number of paths with 2n steps on a rectangular grid from bottom left, Ex: (n - 1, 0), to top right, Ex: (0, n - 1) that do not cross above the main diagonal.

    ![](../img/Algorithm/catalan-number/path-main-diagonal.jpg)

- Number of ways to insert n pairs of parentheses in a word of n + 1 letters. 

    For example:
    - n = 2: ((ab)c), (a(bc))
    - n = 3: ((ab)(cd)), (((ab)c)d), ((a(bc))d), (a((bc)d)), (a(b(cd))).

- Number of ways to form a **mountain ranges** with n upstrokes and n down-strokes that all stay above the original line. The mountain range interpretation is that the mountains will never go below the horizon.

    ![](../img/Algorithm/catalan-number/Mountain_Ranges-copy.jpg)

- Number of permutations of {1, ..., n} that avoid the pattern 123 (or any of the other patterns of length 3); that is the number of permutations with no three-term increasing subsequence.

    For example: 
    - n = 3: these permutations are 132, 213, 231, 312 and 321.

    - n = 4: these permutations are 1432, 2143, 2413, 2431, 3142, 3214, 3241, 3412, 3421, 4132, 4213, 4231, 4312 and 4321.

<br>

## Solving the parentheses problem



<br>

Refer:

[https://www.w3schools.com/css/css3_flexbox.asp](https://www.w3schools.com/css/css3_flexbox.asp)

