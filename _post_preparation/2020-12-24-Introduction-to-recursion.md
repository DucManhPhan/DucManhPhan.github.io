---
layout: post
title: Introduction to Recursion
bigimg: /img/image-header/home-office-2.jpg
tags: [Algorithm]
---

In this article, we will learn about Recursion. It is important topic to learn another techniques such as Dynamic Programming, Divide and Conquer, ...

Let's get started.

<br>

## Table of Contents
- [Introduction to Recursion](#introduction-to-recursion)
- [Principle of Recursion](#principle-of-recursion)
- [Recurrence Relation](#recurrence-relation)
- [Some types of Recursion](#some-types-of-recursion)
- [Some steps for identifying recursion problem](#some-steps-for-identifying-recursion-problem)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to Recursion

Recursion is an approach to solving problems using a function that calls itself as a subroutine.

You might wonder how we can implement a function that calls itself. The trick is that each time a recursive function calls itself, it reduces the given problem into subproblems. The recursion call continues until it reaches a point where the subproblem can be solved without further recursion.

A recursive function should have the following properties so that it does not result in an infinite loop:
- A simple base case (or cases) — a terminating scenario that does not use recursion to produce an answer.
- A set of rules, also known as recurrence relation that reduces all other cases towards the base case.

Note that there could be multiple places where the function may call itself.

<br>

## Recurrence Relation

There are two important things that one needs to figure out before implementing a recursive function:
- recurrence relation: the relationship between the result of a problem and the result of its subproblems.

- base case: the case where one can compute the answer directly without any further recursion calls. 

    Sometimes, the base cases are also called bottom cases, since they are often the cases where the problem has been reduced to the minimal scale, i.e. the bottom, if we consider that dividing the problem into subproblems is in a top-down manner.

Once we figure out the above two elements, to implement a recursive function we simply call the function itself according to the recurrence relation until we reach the base case.


<br>

## Some types of Recursion





<br>

## Some steps for identifying recursion problem

1. Understanding about our problem

    We need to answer some questions before jumping into solve it.
    - What is the intention of our problem?
    
        - Find/Search some properties such as find the minimum/maximum elements, find the triplet sum that is equal to zero, ...

        - Calculation such as find the subset with size = k of an array that have maximum value, ... Normally, it's relevant to the subset's calculation.

    - What is the constraint to the problem?

        - Data type such as the range of integer, character but it's only ASCII, or upper case, or normal case, ...

        - The number of elements.

        - Maximum time to process, based on it, we can select the suitable algorithm to solve it.

2. Trying with small or medium test case size

    Due to identify the problem that has overlapping problem, we need to trying medium test case size.

3. Identify the expression of recursion

    With our small test cases, we can find the relationship between the bigger problems and the small problems.

    For example, we will encounter climbing stairs problem.

    ```javascript
    You are climbing a stair case. It takes n steps to reach to the top.
    Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
    ```

    With steps n = 2, we have:

    ```java
    2 = 1 + 1
      = 2 + 0
    ```

    Then we have 2 ways to reach to the top for n = 2.

    With steps n = 3, we have:

    ```java
    3 = 1 + 1 + 1
      = 1 + 2
      = 2 + 1
    ```

    Then we have 3 ways to reach to the top for n = 3.

    With steps n = 4, we have:

    ```java
    4 = 1 + 1 + 1 + 1
      = 1 + 2 + 1
      = 1 + 1 + 2
      = 2 + 1 + 1
      = 2 + 2
    ```

    Then we have 5 ways to reach to the top for n = 4.

    So, we have an expression: ```climbingStairs(4) = climbingStairs(3) + climbingStairs(2)```.

    Generally, we have the formular of recursion is:

    ```java
    // base case
    climbingStairs(0) = 1;
    climbingStairs(1) = 1;

    // the formular of recursion
    climbingStairs(n) = climbingStairs(n - 1) + climbingStairs(n - 2)
    ```

4. Coding

    Based on the formular of recursion, we can easily write the function for it with two case:
    - recurrence relation 
    - base case

5. Optimize source code of recursion

    In some platform such as Hackerrank or Leetcode, they will limit the time to process. So, we can use memoization to reduce this time complexity.

    But in order to use memoization, we can identify our problem has overlapping property in it.

<br>

## How to calculate the time complexity of Recursion

Below is the formular to calculat the time complexity of Recursion:

```
Given a recursion algorithm, its time complexity O(T) is typically the product of the number of recursion invocations (denoted as R) and the time complexity of calculation (denoted as O(s)) that incurs along with each recursion call:

        O(T) = R ∗ O(s)
```

For example:
- Print a string in reverse order.

    A recurrence relation to solve the problem can be expressed as follows:

    ```printReverse(str) = printReverse(str[1...n]) + print(str[0])```

    where ```str[1...n]``` is the substring of the input string str, without the leading character ```str[0]```.

    As we can see, the function would be recursively invoked n times, where n is the size of the input string. At the end of each recursion, we simply print the leading character, therefore the time complexity of this particular operation is constant, i.e. O(1).

    To sum up, the overall time complexity of our recursive function ```printReverse(str)``` would be ```O(printReverse) = n * O(1) = O(n)```.

- Fibonacci numbers

    The formular of recursion for Fibonacci numbers is: ```f(n) = f(n-1) + f(n-2)```.

    In this case, it is better resort to the execution tree, which is a tree that is used to denote the execution flow of a recursive function in particular. Each node in the tree represents an invocation of the recursive function. Therefore, the total number of nodes in the tree corresponds to the number of recursion calls during the execution.

    ![](../img/Algorithm/recursion/fibonacci-number.png)

    In a full binary tree with n levels, the total number of nodes would be **2^n - 1**. Therefore, the upper bound (though not tight) for the number of recursion in **f(n)** would be **2^n -1**, as well. As a result, we can estimate that the time complexity for **f(n)** would be **O(2^n)**.


<br>

## How to calculate the space complexity of Recursion

There are mainly two parts of the space consumption that one should bear in mind when calculating the space complexity of a recursive algorithm:
- **recursion related** 
- **non-recursion related space**

1. Recursion related space

    


2. Non-recursion related space





<br>

## Wrapping up






<br>

Refer:

[https://leetcode.com/explore](https://leetcode.com/explore)