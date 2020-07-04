---
layout: post
title: Letter Combinations of a Phone Number
bigimg: /img/image-header/yourself.jpeg
tags: [Backtracking, Queue]
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

```java
public static List<String> letterCombinations(String digits) {
    return letterCombinationsII(digits, 0);
}

public static List<String> letterCombinations(String digits, int index) {
    List<String> list = new ArrayList<>();
    String chars = numToCharacters.get(digits.charAt(index));

    // base case - get all characters at the last index
    if (index == digits.length() - 1) {
        for (int i = 0; i < chars.length(); ++i) {
            list.add("" + chars.charAt(i));
        }

        return list;
    }

    List<String> subList = letterCombinationsII(digits, index + 1);
    for (int i = 0; i < chars.length(); ++i) {
        char c = chars.charAt(i);
        for (String tmp : subList) {
            list.add(c + tmp);
        }
    }

    return list;
}
```


<br>

## Using iteration version

In this section, we will use Queue to solve it.

For example, we can get the input string is ```23```.

```java

2 --> {a, b, c}

3 --> {d, e, f}

```

Then, each elements of {a, b, c} will go with each element of {d, e, f}. It means that:

```java
a + {d, e, f} = {ad, ae, af}

b + {d, e, f} = {bd, be, bf}

c + {d, e, f} = {cd, ce, cf}

```

Therefore, to use iterative version, we need to use a data structure that maintains the order of elements, and we only need to get operation in the start index.

--> We will use Queue data structure.

1. First way, we will use null to seperate between each character of loops.

    ```java
    2 -> {a, b, c}

    3 -> {d, e, f}

    - Initial queue:

        queue: {}

    - First loop:

        // add null to seperate characters of the second loop
        queue: {null, c, b, a}

    - Second loop:

        queue: {null, cf, ce, cd, bf, be, bd, af, ae, ad}

    ```

    ```java
    public static List<String> letterCombinations(String digits) {
        Queue<String> queue = new LinkedList<>();
        boolean isFirstDigit = true;

        for (char c : digits.toCharArray()) {
            String charsOfDigit = numToCharacters.get(c);

            if (isFirstDigit) {
                charsOfDigit.chars()
                        .mapToObj(ch -> (char)ch)
                        .forEach(ch -> queue.add(String.valueOf(ch)));
                isFirstDigit = false;
                queue.add(null);
                continue;
            }

            while (!queue.isEmpty() && !isFirstDigit) {
                String str = queue.remove();
                if (str == null) {
                    break;
                }

                for (char tmp : charsOfDigit.toCharArray()) {
                    queue.add(str + tmp);
                }
            }

            // mark the end of characters when iterate each digit
            queue.add(null);
        }

        return queue.stream()
                    .filter(str -> str != null)
                    .collect(Collectors.toList());
    }
    ```

2. Second way

    In our first way, we use **null** to seperate the characters of multiple combinations. And finally, we will iterate all null values, it is redundancy.

    To improve the performance of the first way, we can do like the below code.

    ```java
    public static List<String> letterCombinations2(String digits) {
        LinkedList<String> out_arr = new LinkedList();
        if(digits.length() == 0) return out_arr;
        out_arr.add("");
        String[] char_map = new String[]{
                "0",
                "1",
                "abc",
                "def",
                "ghi",
                "jkl",
                "mno",
                "pqrs",
                "tuv",
                "wxyz"
        };

        for(int i = 0; i < digits.length(); i++) {
            int index = Character.getNumericValue(digits.charAt(i));
            while(out_arr.peek().length() == i) {
                String permutation = out_arr.remove();
                for(char c : char_map[index].toCharArray()){
                    out_arr.add(permutation + c);
                }
            }
        }

        return out_arr;
    }
    ```

    We use the size of each combination between characters to get characters in a queue.

<br>

## Wrapping up

- Understanding about the structure of Backtracking algorithm

- Identify the problems that can be applied Queue data structure.

<br>

Refer:

[https://www.interviewbit.com/problems/letter-phone/](https://www.interviewbit.com/problems/letter-phone/)