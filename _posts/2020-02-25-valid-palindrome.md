---
layout: post
title: Valid Palindrome
bigimg: /img/path.jpg
tags: [Two-Pointers]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using recursive version](#using-recursive-version)
- [Using Two-Pointers technique](#using-two-pointers-technique)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.

Note: For the purpose of this problem, we define empty string as valid palindrome.

```
Example 1:
    Input: "A man, a plan, a canal: Panama"
    Output: true

Example 2:
    Input: "race a car"
    Output: false
```

Constraints:
- s consists only of printable ASCII characters.

<br>

## Using recursive version


```java
public static boolean isPalindrome0(String s) {
    int left = 0;
    int right = s.length() - 1;

    return isPalindrome0(s, left, right);
}

public static boolean isPalindrome0(String s, int left, int right) {
    if (left >= right) {
        return true;
    }

    while (!Character.isLetterOrDigit(s.charAt(left))) {
        ++left;
    }

    while (!Character.isLetterOrDigit(s.charAt(right))) {
        --right;
    }

    if (Character.toLowerCase(s.charAt(left)) != Character.toLowerCase(s.charAt(right))) {
        return false;
    }

    return isPalindrome0(s, ++left, --right);
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(n)


<br>

## Using Two-Pointers technique

Based on the definition of palindrome string, so we can use two pointers technique to solve it.

```java
public boolean isPalindrome(String s) {
    int left = 0;
    int right = s.length() - 1;
    
    while (left < right) {
        char leftChar = s.charAt(left);
        char rightChar = s.charAt(right);
        
        if (!Character.isLetterOrDigit(leftChar)) {
            ++left;
            continue;
        }
        
        if (!Character.isLetterOrDigit(rightChar)) {
            --right;
            continue;
        }
        
        if (Character.toLowerCase(leftChar) != Character.toLowerCase(rightChar)) {
            return false;
        } else {
            ++left;
            --right;
        }
    }
    
    return true;
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(1)


<br>

## Wrapping up

- Understanding the traits that we can apply two pointers technique.


<br>

Refer:

[https://leetcode.com/explore/challenge/card/august-leetcoding-challenge/549/week-1-august-1st-august-7th/3411/](https://leetcode.com/explore/challenge/card/august-leetcoding-challenge/549/week-1-august-1st-august-7th/3411/)