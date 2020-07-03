---
layout: post
title: Letter Combinations of a Phone Number
bigimg: /img/image-header/yourself.jpeg
tags: [Backtracking]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using backtracking algorithm](#using-backtracking-algorithm)
- [Using recursion version](#using-recursion-version)
- [Using iteration version](#using-iteration-version)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent.

A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.

![](../img/Algorithm/backtracking/letter-phone.png)

```java
Example:

Input: "23"
Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
```

The digit 0 maps to 0 itself.

The digit 1 maps to 1 itself.

<br>

## Using backtracking algorithm

The step of this way:
- Get all corresponding characters of the numeric value.
- With each above character, go to the all corresponding characters of the next numeric value.


```java
public static List<String> letterCombinations(String digits) {
    List<String> res = new ArrayList<>();
    letterCombinations(digits, res, 0, digits.length(), new ArrayList<>());

    return res;
}

public static void letterCombinations(String digits, List<String> res, int start, int size, List<Character> values) {
    if (start > size) {
        return;
    }

    if (start == size) {
        res.add(values.stream().map(String::valueOf).collect(Collectors.joining()));
        return;
    }

    String correspondingChars = numToCharacters.get(digits.charAt(start));
    for (char c : correspondingChars.toCharArray()) {
        values.add(c);
        letterCombinations(digits, res, start + 1, size, values);
        values.remove(values.size() - 1);
    }
}
```

The complexity of this solution:
- Time complexity: 
- Space complexity:

<br>

## Using recursion version

Assuming that we calculated all strings from the **start + 1** index to **end** index, then:
- iterate these strings
- append all characters of the **start** index to the **first position** of these calculated strings.

https://leetcode.com/problems/letter-combinations-of-a-phone-number/discuss/716485/Java-0ms


<br>

## Using iteration version

https://leetcode.com/problems/letter-combinations-of-a-phone-number/discuss/567842/Java-Queue-FIFO-Solution


<br>

## Wrapping up




<br>

Refer:

[https://www.interviewbit.com/problems/letter-phone/](https://www.interviewbit.com/problems/letter-phone/)