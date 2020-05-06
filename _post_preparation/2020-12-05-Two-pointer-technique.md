---
layout: post
title: Two pointer technique
bigimg: /img/image-header/yourself.jpeg
tags: [Coding Patterns, Algorithm]
---

In this article, we will learn about two pointer technique. Let's get started.

<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of Two pointers technique](#solution-of-two-pointers-technique)
- [When to use](#when-to-use)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution of Two pointers technique



Some types of Two pointers technique:
1. Use the **left** pointer starts from the beginning of an array. Use the **right** pointer starts from the ending of an array.

    The condition to stop the scanning of whole array is **left** > **right**.
    
    So, we have an image that describes our this case.

    ![](../img/Algorithm/two-pointer/left-right-pointers.png)

    Finally, we have some problems of this case to practice.
    - [https://leetcode.com/problems/3sum/](https://leetcode.com/problems/3sum/)

    - [https://leetcode.com/problems/remove-duplicates-from-sorted-array/](https://leetcode.com/problems/remove-duplicates-from-sorted-array/)

    - [https://leetcode.com/problems/reverse-vowels-of-a-string/](https://leetcode.com/problems/reverse-vowels-of-a-string/)

2. Use the **left** pointer as the slow pointer, the **right** pointer as the fast pointer.

    Normally, when the fast pointer go to the end of an array is the stop condition that we need to care about.

    Below is an image that describes how this case works.

    ![](../img/Algorithm/two-pointer/slow-fast-pointers.png)

    Finally, we also have some examples to practice.
    - [https://leetcode.com/problems/linked-list-cycle/](https://leetcode.com/problems/linked-list-cycle/)


<br>

## When to use

- When we have to deal with sorted arrays (or Linked List) and need to find a set of elements that fulfill cretain constraints.

    The set of elements could be a pair, a triplet, or even a subarray.

- With fast/slow pointer approach, it's quite useful when dealing with cyclic Linked List or arrays.

    By moving at different speeds (say, in a cyclic LinkedList), the algorithm proves that the two pointers are bound to meet. The fast pointer should catch the slow pointer once both the pointers are in a cyclic loop.

<br>

## Wrapping up

- Due to our context of this technique is the sorted array or something, so we can use binary search as the brute-force solution when we do not think other solutions.


<br>

Refer:

[https://afteracademy.com/blog/what-is-the-two-pointer-technique](https://afteracademy.com/blog/what-is-the-two-pointer-technique)

[https://leetcode.com/](https://leetcode.com/)