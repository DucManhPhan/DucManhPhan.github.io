---
layout: post
title: Hacker Rank - Super Reduced String
bigimg: /img/path.jpg
tags: [Stack]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using shift operations in a string](#using-shift-operations-in-a-string)
- [Using delete method of String Builder](#using-delete-method-of-string-builder)
- [Using stack](#using-stack)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Reduce a string of lowercase characters in range ascii['a'..'z']by doing a series of operations. In each operation, select a pair of adjacent letters that match, and delete them.

Delete as many characters as possible using this method and return the resulting string. If the final string is empty, return Empty String

Example 1:
- s = "aab"
- aab shortens to b in one operation: remove the adjacent a characters.

Example 2:
- s = "abba"
- Remove the two 'b' characters leaving 'aa'. Remove the two 'a' characters to leave ''. Return 'Empty String'.

superReducedString has the following parameter(s):
- string s: a string to reduce

Returns:
- string: the reduced string or Empty String

Constraints
- 1 <= length of s <= 100


<br>

## Using shift operations in a string


```java
public class Solution {
    public static String superReducedString(String s) {
        // ...
    }
}
```


The complexity of this solution:
- Time complexity:
- Space complexity: 

<br>

## Using delete method of String Builder


```java
public class Solution {
    public static String superReducedString(String s) {
        StringBuilder sb = new StringBuilder(s);

        for (int i = 1; i < sb.length(); i++) {
            if (sb.charAt(i) == sb.charAt(i - 1)) {
                sb.delete(i - 1, i + 1);
                i = 0;
            }
        }

        if (sb.length() == 0) {
            return "Empty String";
        }

        return sb.toString();
    }
}
```

The complexity of this solution:
- Time complexity: O(n^2)
- Space complexity: O(n)

<br>

## Using stack

When iterating our input parameter string s, we can find that:
- It need to remain the order of characters.
- We always compare the current character with the previous character.

So, choose Stack data structure is suitable for this case.

```java
public class Solution {
    public static String superReducedString(String s) {
        Stack<Character> stk = new Stack<>();
        StringBuilder sb = new StringBuilder();

        for (char c : s.toCharArray()) {
            if (!stk.isEmpty()) {
                char topChar = stk.peek();
                if (topChar == c) {
                    stk.pop();
                } else {
                    stk.push(c);
                }
            } else {
                stk.push(c);
            }
        }

        if (stk.size() == 0) {
            return "Empty String";
        }

        stk.forEach(c -> {
            sb.append(c);
        });

        return sb.toString();
    }
}
```

The complexity of this solution:
- Time complexity: O(n) with n is the length of its string
- Space complexity: O(n)


<br>

## Wrapping up

- Understanding about the way how to use Stack data structure.


<br>

Refer:

[https://www.hackerrank.com/challenges/reduced-string/problem](https://www.hackerrank.com/challenges/reduced-string/problem)