---
layout: post
title: Happy Number
bigimg: /img/image-header/yourself.jpeg
tags: [Slow-Fast Pointers]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution](#solution)
- [Using HashSet data structure](#using-hashset-data-structure)
- [Using slow-fast pointers technique](#using-slow-fast-pointers-technique)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Write an algorithm to determine if a number n is "happy".

A happy number is a number defined by the following process: Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1. Those numbers for which this process ends in 1 are happy numbers.

Return True if n is a happy number, and False if not.

For example:

```java
Input: 19
Output: true
Explanation: 
12 + 92 = 82
82 + 22 = 68
62 + 82 = 100
12 + 02 + 02 = 1
```

<br>

## Solution

In the above statements, we can find that this process will loops endlessly in a cycle which does not include 1. So what does it mean?

For example, with n = 12.

```java
1. 1^2 + 2^2 = 1 + 4 = 5
2. 5^2 = 25
3. 2^2 + 5^2 = 4 + 25 = 29
4. 2^2 + 9^2 = 4 + 81 = 85
5. 8^2 + 5^2 = 64 + 25 = 89 (***)
6. 8^2 + 9^2 = 64 + 81 = 145
7. 1^2 + 4^2 + 5^2 = 1 + 16 + 25 = 42
8. 4^2 + 2^2 = 16 + 4 = 20
9. 2^2 + 0^2 = 4 + 0 = 4
10. 4^2 = 16
11. 1^2 + 6^2 = 1 + 36 = 37
12. 3^2 + 7^2 = 9 + 49 = 58
13. 5^2 + 8^2 = 25 + 64 = 89    (***)
```

In this example, we can find that the value in the steps 5th and 13th is the same. It means that the square numbers in some loop will be the same. It makes our loop endlessly.

```89 -> 145 -> 42 -> 20 -> 4 -> 16 -> 37 -> 58 -> 89```

Our solution is to identify the point that it loops again. So we can have two ideas for this solution.
- use **HashSet** or other data structure to identify the same element that is inserted into it.

    **HashSet** is a collection that contains no duplicate elements.

    Some implementations of **Set** interface that we need to take care:
    - **HashSet**, which stores its elements in a hash table, is the best-performing implementation; however it makes no guarantees concerning the order of iteration.
    
    - **TreeSet**, which stores its elements in a red-black tree, orders its elements based on their values; it is substantially slower than HashSet. 
    
    - **LinkedHashSet**, which is implemented as a hash table with a linked list running through it, orders its elements based on the order in which they were inserted into the set (insertion-order).
    
        **LinkedHashSet** spares its clients from the unspecified, generally chaotic ordering provided by HashSet at a cost that is only slightly higher.

- use slow-fast pointer technique.

<br>

## Using HashSet data structure

Below is the source code that implements using HashSet.

```java
public boolean isHappy(int n) {
    if (n < 0) {
        return false;
    }
    
    Set<Integer> distinctElements = new HashSet<>();
    while (n != 1) {
        int squareSum = findSquareSum(n);
        if (distinctElements.contains(squareSum)) {
            return false;
        }
        
        distinctElements.add(squareSum);
        n = squareSum;
    }

    return true;
}

public int findSquareSum(int n) {
    int squareSum = 0;
    int modulo = 0;
    while (n != 0) {
        modulo = n % 10;
        squareSum += modulo * modulo;
        n = n / 10;
    }
    
    return squareSum;
}
```

<br>

## Using slow-fast pointers technique

Below is the source code of slow-fast pointer technique

```java
public boolean isHappy(int num) {
    int slow = num;
    int fast = num;

    do {
      slow = findSquareSum(slow); // move one step
      fast = findSquareSum(findSquareSum(fast)); // move two steps
    } while (slow != fast); // found the cycle

    return slow == 1; // see if the cycle is stuck on the number '1'
  }

private int findSquareSum(int num) {
    int sum = 0;
    int digit;

    while (num > 0) {
      digit = num % 10;
      sum += digit * digit;
      num /= 10;
    }

    return sum;
}
```



<br>

## Wrapping up

- To check the circle of the linked list or array, or the repeating numbers, we can use HashSet, or Slow-Fast pointers technique.



<br>

Refer:

[https://leetcode.com/explore/challenge/card/30-day-leetcoding-challenge/528/week-1/3284/](https://leetcode.com/explore/challenge/card/30-day-leetcoding-challenge/528/week-1/3284/)
