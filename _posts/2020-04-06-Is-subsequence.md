---
layout: post
title: Is Subsequence
bigimg: /img/image-header/yourself.jpeg
tags: [Dynamic Programming, Two-Pointers]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force solution](#using-brute-force-solution)
- [Using Two Pointer solution](#using-two-pointer-solution)
- [Using DP solution](#using-dp-solution)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a string s and a string t, check if s is subsequence of t.

A subsequence of a string is a new string which is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (ie, "ace" is a subsequence of "abcde" while "aec" is not).

Follow up:
If there are lots of incoming S, say S1, S2, ... , Sk where k >= 1B, and you want to check one by one to see if T has its subsequence. In this scenario, how would you change your code?

For example:

```java
Example 1:
    - Input: s = "abc", t = "ahbgdc"
    - Output: true

Example 2:
    - Input: s = "axc", t = "ahbgdc"
    - Output: false

Constraints:
    - 0 <= s.length <= 100
    - 0 <= t.length <= 10^4
    - Both strings consists only of lowercase characters.
```


<br>

## Using brute force solution

With brute force solution, we will:
- iterate the shorter string with outer loop.
- iterate the longer string with inner loop.
- use a boolean variable to determine an element of the shorter string is belong to the longer string. If not, return false immediately.
- use an integer variable to mark the previous element of the shorter string's index in the longer string.

```java
public boolean isSubsequence(String s, String t) {
    int lent = t.length();
    int lens = s.length();
    int previousIndex = 0;
    boolean found = false;

    for (int i = 0; i < lens; ++i) {
        for (int j = previousIndex; j < lent; ++j) {
            if (t.charAt(j) == s.charAt(i)) {
                previousIndex = j + 1;
                found = true;
                break;
            }
        }

        if (!found) {
            return false;
        } else {
            found = false;
        }
    }

    return true;
}
```

The complexity of this solution:
- Time complexity: O(mn), m is the length of s string, n is the length of t string.
- Space complexity: O(1)


<br>

## Using Two Pointer solution

In a brute-force solution, we use two loops to iterate both strings. But it's redundancy, we can use two-pointers technique to deal with this.

In some common problems, we use two pointers technique in one string or array. But in this case, we will use it in two string or array. So, we need to remember cases that we use propery this technique.

```java
public static boolean isSubsequence(String s, String t) {
    int sLength = s.length();
    int tLength = t.length();
    int sLeftIdx = 0;
    int tLeftIdx = 0;

    while (sLeftIdx < sLength && tLeftIdx < tLength) {
        if (s.charAt(sLeftIdx) == t.charAt(tLeftIdx)) {
            ++sLeftIdx;
        }

        ++tLeftIdx;
    }

    return sLeftIdx == sLength;
}
```

<br>

## Using DP solution

From the requirement, we can find that our solution that satisfies some conditions:
- The order of each character in the shorter string with the longer string.
- All characters of the shorter string are belong to the longer string.


Below is the source code of this solution:

```java

```


<br>

## Wrapping up

- Understanding the two pointers technique to apply for arrays/strings, utilize it when we need to find a set of elements that fulfill certain constraints.


<br>

Refer:

[https://leetcode.com/problems/is-subsequence/](https://leetcode.com/problems/is-subsequence/)