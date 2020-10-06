---
layout: post
title: Detect Flag
bigimg: /img/image-header/yourself.jpeg
tags: [Algorithm]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm ](#using-brute-force-algorithm)
- [Improve the brute force algorithm](#improve-the-brute-force-algorithm)
- [Using regex pattern](#using-regex-pattern)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a word, you need to judge whether the usage of capitals in it is right or not.

We define the usage of capitals in a word to be right when one of the following cases holds:
- All letters in this word are capitals, like "USA".
- All letters in this word are not capitals, like "leetcode".
- Only the first letter in this word is capital, like "Google".
- Otherwise, we define that this word doesn't use capitals in a right way.

For example, we have some test cases.

```
Example 1:
    Input: "USA"
    Output: True
 

Example 2:
    Input: "FlaG"
    Output: False

Example 3:
    Input: "google"
    Output: true

Example 4:
    Input: "Google"
    Output: true

Example 5:
    Input: "FFFf"
    Output: false

```


<br>

## Using brute force algorithm 

With the brute force algorithm's idea, we need to process all cases that we have.

```java
public boolean detectCapitalUse(String word) {
    int n = word.length();

    boolean match1 = true, match2 = true, match3 = true;

    // case 1: All capital
    for (int i = 0; i < n; i++) {
        if (!Character.isUpperCase(word.charAt(i))) {
            match1 = false;
            break;
        }
    }
    if (match1) {
        return true;
    }

    // case 2: All not capital
    for (int i = 0; i < n; i++) {
        if (!Character.isLowerCase(word.charAt(i))) {
            match2 = false;
            break;
        }
    }
    if (match2) {
        return true;
    }

    // case 3: All not capital except first
    if (!Character.isUpperCase(word.charAt(0))) {
        match3 = false;
    }
    if (match3) {
        for (int i = 1; i < n; i++) {
            if (!Character.isLowerCase(word.charAt(i))) {
                match3 = false;
                break;
            }
        }
    }
    if (match3) {
        return true;
    }

    // if not matching
    return false;
}
```


<br>

## Improve the brute force algorithm

From our problem, we have some test cases such as:
- All letters are upper cases.
- A first letter is upper case, but the remaining letters are lower cases.
- All letters are lower cases.

So we can easily find that our problem have two cases, the first letter in a word is upper case or not. In a case that the first letter is upper case, there are two small case: all remaining letters are upper cases or not.

Then, we have two boolean variables to represent these states. Below is the source code of this problem.

```java
/**
    * Using improved version of the brute force algorithm
    *
    * @param word
    * @return
    */
public static boolean detectCapitalUse(String word) {
    if (word == null || "".equals(word)) {
        return false;
    }

    boolean isCapitalFirstChar = false;
    Boolean isAnotherCapitalChar = null;
    if (Character.isUpperCase(word.charAt(0))) {
        isCapitalFirstChar = true;
    }

    for (int i = 1; i < word.length(); ++i) {
        char tmp = word.charAt(i);
        if (Character.isUpperCase(tmp)) {
            if (isCapitalFirstChar && (isAnotherCapitalChar != null) && !isAnotherCapitalChar) {
                return false;
            }

            isAnotherCapitalChar = true;
        } else {
            if (isAnotherCapitalChar != null && isAnotherCapitalChar) {
                return false;
            }

            isAnotherCapitalChar = false;
        }

        if (!isCapitalFirstChar && isAnotherCapitalChar) {
            return false;
        }
    }

    return true;
}
```

<br>

## Using regex pattern

The regex pattern of this problem is **[A−Z]∗∣.[a−z]∗**.

```java
public boolean detectCapitalUse(String word) {
    return word.matches("[A-Z]*|.[a-z]*");
}
```

To test this regex, we need to vist the website [regex101.com](https://regex101.com/).

<br>

## Wrapping up




<br>

Refer:

[https://leetcode.com/problems/detect-capital/](https://leetcode.com/problems/detect-capital/)