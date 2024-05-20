---
layout: post
title: Leetcode 1768 - Merge Strings Alternatively
bigimg: /img/image-header/yourself.jpeg
tags: [Two-Pointers]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm](#using-brute-force-algorithm)
- [Using two pointers technique](#using-two-pointers-technique)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

You are given two strings `word1` and `word2`. Merge the strings by adding letters in alternating order, starting with `word1`. If a string is longer than the other, append the additional letters onto the end of the merged string.

Return the merged string.

```
Example 1:
    Input: word1 = "abc", word2 = "pqr"
    Output: "apbqcr"
    Explanation: The merged string will be merged as so:
    word1:  a   b   c
    word2:    p   q   r
    merged: a p b q c r

Example 2:
    Input: word1 = "ab", word2 = "pqrs"
    Output: "apbqrs"
    Explanation: Notice that as word2 is longer, "rs" is appended to the end.
    word1:  a   b 
    word2:    p   q   r   s
    merged: a p b q   r   s

Example 3:
    Input: word1 = "abcd", word2 = "pq"
    Output: "apbqcd"
    Explanation: Notice that as word1 is longer, "cd" is appended to the end.
    word1:  a   b   c   d
    word2:    p   q 
    merged: a p b q c   d
```

Constraints:
- `1 <= word1.length, word2.length <= 100`
- `word1` and `word2` consist of lowercase English letters.


<br>

## Using brute force algorithm

Basically, the steps will be shown below:
1. Iterate each character of each word. Then put it into the result string.

2. If the remaining word's length is greater than the other's length. Iterate that word and put the remaining characters into the result string.

Below is the source code of this brute-force solution:

```Java
/**
 * Using brute-force solution.
 *
 * Iterate each strings and add them into result string.
 *
 * @param word1
 * @param word2
 * @return
 */
private static String mergeAlternately(String word1, String word2) {
    StringBuffer result = new StringBuffer();
    int minLength = Math.min(word1.length(), word2.length());

    for (int i = 0; i < minLength; ++i) {
        result.append(word1.charAt(i));
        result.append(word2.charAt(i));
    }

    String redundantString = word1.length() > minLength ? word1 : word2;
    for (int i = minLength; i < redundantString.length(); ++i) {
        result.append(redundantString.charAt(i));
    }

    return result.toString();
}
```

The complexity of this algorithm:
- Time complexity: `O(n)` with `n` = the max length of (`word1`, `word2`).
- Space complexity: `O(length of word 1 + length of word2)`.


<br>

## Using two pointers technique

Actually, the above solution is enough. But currently, we want to practice the idea of using two-pointer technique. We will use two pointers on each word. Then iterate each word.

So the source code of this version is:

```Java
/**
 * Using two-pointers technique.
 *
 * @param word1
 * @param word2
 * @return
 */
private static String mergeAlternately(String word1, String word2) {
    int iWord1 = 0;
    int iWord2 = 0;
    int maxLength = Math.max(word1.length(), word2.length());

    StringBuffer result = new StringBuffer();
    while (iWord1 < maxLength || iWord2 < maxLength) {
        if (iWord1 < word1.length()) {
            result.append(word1.charAt(iWord1));
        }

        if (iWord2 < word2.length()) {
            result.append(word2.charAt(iWord2));
        }

        iWord1++;
        iWord2++;
    }

    return result.toString();
}
```

The complexity of this algorithm:
- Time complexity: `O(n)` with `n` = the max length of (`word1`, `word2`).
- Space complexity: `O(length of word 1 + length of word2)`.


<br>

## Wrapping up




<br>

Refer:

[1768. Merge Strings Alternatively](https://leetcode.com/problems/merge-strings-alternately/?envType=study-plan-v2&envId=leetcode-75)
