---
layout: post
title: Long Pressed Name
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

Your friend is typing his name into a keyboard.  Sometimes, when typing a character c, the key might get long pressed, and the character will be typed 1 or more times.

You examine the typed characters of the keyboard.  Return True if it is possible that it was your friends name, with some characters (possibly none) being long pressed.

```
Example 1:
    Input: name = "alex", typed = "aaleex"
    Output: true
    Explanation: 'a' and 'e' in 'alex' were long pressed.

Example 2:
    Input: name = "saeed", typed = "ssaaedd"
    Output: false
    Explanation: 'e' must have been pressed twice, but it wasn't in the typed output.

Example 3:
    Input: name = "leelee", typed = "lleeelee"
    Output: true

Example 4:
    Input: name = "laiden", typed = "laiden"
    Output: true
    Explanation: It's not necessary to long press any character.
 

Constraints:
    1 <= name.length <= 1000
    1 <= typed.length <= 1000
    The characters of name and typed are lowercase letters.
```


<br>

## Using brute force algorithm


```java
public boolean isLongPressedName(String name, String typed) {
    NumChar[] numNameChars = new NumChar[1000];
    NumChar[] numTypedChars = new NumChar[1000];

    int countNameChars = countChars(name, numNameChars);
    int countTypedChars = countChars(typed, numTypedChars);

    if (countNameChars != countTypedChars) {
        return false;
    }

    for (int i = 0; i < countNameChars + 1; ++i) {
        if (numNameChars[i].c != numTypedChars[i].c
                        || numNameChars[i].num > numTypedChars[i].num) {
            return false;
        }
    }

    return true;
}

private int countChars(String name, NumChar[] numNameChars) {
    int count = 0;

    for (int iName = 0; iName < name.length(); ++iName) {
        char nameChar = name.charAt(iName);

        if (numNameChars[count] == null) {
            NumChar tmp = new NumChar();
            numNameChars[count] = tmp;
        }

        numNameChars[count].c = nameChar;
        ++numNameChars[count].num;

        if (iName < name.length() - 1) {
            nameChar = name.charAt(iName + 1);
            if (nameChar != numNameChars[count].c) {
                ++count;
            }
        }
    }

    return count;
}

class NumChar {
    char c = 0;
    int num = 0;
}
```

The complexity of this algorithm:
- Time complexity: O(n)
- Space complexity: O(1000)


<br>

## Using two pointers technique





<br>

## Wrapping up




<br>

Refer:

[https://leetcode.com/problems/long-pressed-name/](https://leetcode.com/problems/long-pressed-name/)