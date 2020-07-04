---
layout: post
title: Check whether number if power of two
bigimg: /img/path.jpg
tags: [Bit Manipulation]
---

In this article, we will learn how to check the number is power of two. Let's get started.

<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution for checking number is power of 2](#solution-for-checking-number-is-power-of-2)
- [Divide an integer number to 2](#divide-an-integer-number-to-2)
- [Using log method of Math package](#using-log-method-of-math-package)
- [Based on the property of n and n-1](#based-on-the-property-of-n-and-n-1)

<br>

## Given problem

Below is an description of this problem:

```
Given a positive integer, write a function to find if it is a power of two or not.

Example 1: Input: n = 4
           Output: Yes 

Example 2: Input: n = 7
           Output: No

Example 3: Input: n = 32
           Output: Yes
```

<br>

## Solution for checking number is power of 2

To solve this problem, we have some solutions:
- Divide an integer number to 2. If the remained number is different than 0, then it is not power of 2.

- Using **log()** method of Math package. Carefully, because its data type is double or float, so it can contains number error.

- If n is power of two, then n - 1 that has all unset bits of n becomes set bits of n - 1, vice versa.

    For example: 4 = 100, then 3 = 011

<br>

## Divide an integer number to 2

```java
public boolean isPowerOfTwoUsingIterative(long n) {
    if (n == 0) {
        return false;
    }

    while (n != 1) {
        if (n % 2 != 0) {
            return false;
        }

        n = n / 2;
    }

    return true;
}
```


<br>

## Using log method of Math package

```java
public boolean isPowerOfTwoUsingLogMath(long n) {
    if (n == 0) {
        return false;
    }

    long log2 = log2(n);
    return Math.ceil(log2) == Math.floor(log2);
}

public long log2(long x) {
    return (long) (Math.log(x) / Math.log(2) + 1e-10);
}
```

<br>

## Based on the property of n and n-1

```java
public boolean isPowerOfTwo(int n) {
    return n != 0 && ((n & (n - 1)) == 0);
}
```


