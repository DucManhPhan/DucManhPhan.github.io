---
layout: post
title: Valid Palindrome
bigimg: /img/path.jpg
tags: [Two-Pointers]
---



<br>

## Table of contents





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

## Using brute force algorithm





<br>

## Using Two-Pointers technique


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



<br>

## Wrapping up

- Understanding the traits that we can apply two pointers technique.





<br>

Refer:

[https://leetcode.com/explore/challenge/card/august-leetcoding-challenge/549/week-1-august-1st-august-7th/3411/](https://leetcode.com/explore/challenge/card/august-leetcoding-challenge/549/week-1-august-1st-august-7th/3411/)