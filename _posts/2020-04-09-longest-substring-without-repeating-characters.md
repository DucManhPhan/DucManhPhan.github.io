---
layout: post
title: Longest Substring Without Repeating Characters
bigimg: /img/image-header/yourself.jpeg
tags: [Sliding Window]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm](#using-brute-force-algorithm)
- [Using sliding window technique](#using-sliding-window-technique)
- [Wrapping up](#wrapping-up)



<br>

## Given problem

Given a string, find the length of the longest substring without repeating characters.

```java
Example 1:
    Input: "abcabcbb"
    Output: 3 
    Explanation: The answer is "abc", with the length of 3. 

Example 2:
    Input: "bbbbb"
    Output: 1
    Explanation: The answer is "b", with the length of 1.

Example 3:
    Input: "pwwkew"
    Output: 3
    Explanation: The answer is "wke", with the length of 3. 
                 Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
```


<br>

## Using brute force algorithm

Based on that each size runs from 1 to the length of the input string, we will get the corresponding substring. To check whether a substring contains the duplicated characters or not, we will use a char array to count the number of characters.

```java
public static int lengthOfLongestSubstring(String s) {
    int len = s.length();
    int[] ints = new int[26];
    int maxLength = Integer.MIN_VALUE;

    for (int size = 1; size < len; ++size) {
        for (int i = 0; i <= len - size; ++i) {
            boolean isDuplicated = false;
            String substring = s.substring(i, i + size);

            // input data into an ints array
            for (int j = 0; j < substring.length(); ++j) {
                ints[substring.charAt(j) - 'a']++;
            }

            for (int j = 0; j < 26; ++j) {
                if (ints[j] > 1) {
                    isDuplicated = true;
                    break;
                }
            }

            if (!isDuplicated) {
                maxLength = Math.max(maxLength, substring.length());
            }

            Arrays.fill(ints, 0);
        }
    }

    return maxLength;
}
```

The complexity of this solution:
- Time complexity: O(n^3)
- Space complexity: O(26)

<br>

## Using sliding window technique

Because our result string is a substring, it is not a subsequence. So we can use the sliding window technique to overcome this problem.

```java
public int lengthOfLongestSubstring(String s) {
    int windowStart = 0;
    int size = s.length();
    Map<Character, Integer> mpCountCharacters = new HashMap<>();
    int maxLength = 0;

    for (int windowEnd = 0; windowEnd < size; ++windowEnd) {
        char rightChar = s.charAt(windowEnd);
        if (mpCountCharacters.containsKey(rightChar)) {
            windowStart = Math.max(windowStart, mpCountCharacters.get(rightChar) + 1);
        }

        mpCountCharacters.put(rightChar, windowEnd);
        maxLength = Math.max(maxLength, windowEnd - windowStart + 1);
    }

    return maxLength;
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(n)


<br>

## Wrapping up

- Understanding about the requirements and some particular points to use Sliding Window technique.

<br>

Refer:

[https://leetcode.com/problems/longest-substring-without-repeating-characters/](https://leetcode.com/problems/longest-substring-without-repeating-characters/)