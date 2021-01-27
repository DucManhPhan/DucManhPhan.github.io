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

```java
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
```

Constraints:
- 1 <= name.length <= 1000
- 1 <= typed.length <= 1000
- The characters of name and typed are lowercase letters.

<br>

## Using brute force algorithm

Below is the source code this algorithm:

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

There are some edge cases in this problem:
1. When accessing all elements of **name** String completely, stop this working.

    For example:

    ```java
    String name = "alex";
    String typed = "aaleexa";
    ```

    After getting through all elements of **name** String, the ending a character in **typed** String will be isolated.

    So, it is a sign to return **false** for client.

2. The number of duplicated element in name String isn't greater than these ones of typed String.

    For example:

    ```java
    String name = "saeed";
    String typed = "ssaaedd";
    ```

    It is easy to find that the number of **e** character in **name** String is 2, the number of **e** character in **typed** String is 1. So, we can return **false**.

    Therefore, in the below source code, we will use two variables, such as **nDuplicatedName** and **nDuplicatedTyped**, to identify the number of duplicated elements in the **name** and **typed** String.

```java
class Solution {
    public boolean isLongPressedName(String name, String typed) {
        int pName = 0;
        int pTyped = 0;

        char[] names = name.toCharArray();
        char[] typeds = typed.toCharArray();

        while (pName < names.length && pTyped < typeds.length) {    // (1)
            int nDuplicatedName = 1;    // (2)
            while (pName + 1 < names.length && names[pName] == names[pName + 1]) {
                pName = pName + 1;
                ++nDuplicatedName;
            }

            
            char cName = names[pName];
            char cTyped = typeds[pTyped];

            if (cName != cTyped) {
                return false;
            }

            int nDuplicatedTyped = 0;
            while (cName == cTyped) {
                ++pTyped;
                ++nDuplicatedTyped;
                if (pTyped < typeds.length) {
                    cTyped = typeds[pTyped];
                } else {
                    break;
                }
            }

            if (nDuplicatedName > nDuplicatedTyped) {
                return false;
            }

            ++pName;
        }

        if (pName == names.length && pTyped == typeds.length) {
            return true;
        }

        return false;
    }
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(1)

    In the above solution, we use **toCharArray()** method of String class, then it will create a new array. To reduce using extra space, we can use **charAt()** method to access the index of a character.

<br>

## Wrapping up

- Understanding about the two-pointers technique.

<br>

Refer:

[https://leetcode.com/problems/long-pressed-name/](https://leetcode.com/problems/long-pressed-name/)