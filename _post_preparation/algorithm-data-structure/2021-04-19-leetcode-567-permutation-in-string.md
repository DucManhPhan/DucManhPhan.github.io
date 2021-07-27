---
layout: post
title: LeetCode - 567 - Permutation in String
bigimg: /img/image-header/yourself.jpeg
tags: [Two-Pointers]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm]()
- [Using the two-pointers technique](#using-the-two-pointers-technique)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given two strings s1 and s2, write a function to return true if s2 contains the permutation of s1. In other words, one of the first string's permutations is the substring of the second string.

```java
Example 1:
    Input: s1 = "ab" s2 = "eidbaooo"
    Output: True
    Explanation: s2 contains one permutation of s1 ("ba").

Example 2:
    Input:s1= "ab" s2 = "eidboaoo"
    Output: False
```

Constraints:
- The input strings only contain lower case letters.
- The length of both given strings is in range [1, 10,000].

<br>

## Using brute force algorithm

In this way, we will iterate all substrings that is created from **s2** String. Then, we will compare with **s1** String by using map data structure.

```java
class Solution {
    public boolean checkInclusion(String s1, String s2) {
        int lengthS1 = s1.length();
        int lengthS2 = s2.length();
        
        for (int i = 0; i <= lengthS2 - lengthS1; ++i) {
            String sub = s2.substring(i, i + lengthS1);
            boolean isPermutation = isPermutation(s1, sub);
            if (isPermutation) return true;
        }
        
        return false;
    }
    
    public boolean isPermutation(String s1, String s2) {
        int[] count = new int[26];
        
        for (char c : s2.toCharArray()) count[c - 'a']++;
        for (char c : s1.toCharArray()) count[c - 'a']--;
        
        for (int i : count) {
            if (i < 0) {
                return false;
            }
        }
        
        return true;
    }
}
```



<br>

## Using the two-pointers technique


```java

```


<br>

## Wrapping up

- Understanding about the two-pointers technique.

<br>

Refer:

[https://leetcode.com/problems/permutation-in-string/](https://leetcode.com/problems/permutation-in-string/)