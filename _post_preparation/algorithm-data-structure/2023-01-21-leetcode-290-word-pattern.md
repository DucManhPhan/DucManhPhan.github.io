---
layout: post
title: Leetcode 290 - Word Pattern
bigimg: /img/image-header/yourself.jpeg
tags: [Array]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Analysis of this problem](#analysis-of-this-problem)
- []()
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a `pattern` and a string `s`, find if `s` follows the same pattern.

Here follow means a full match, such that there is a bijection between a letter in `pattern` and a non-empty word in `s`.

- Example 1:

    - Input: pattern = "abba", s = "dog cat cat dog"
    - Output: true

- Example 2:

    - Input: pattern = "abba", s = "dog cat cat fish"
    - Output: false

- Example 3:

    - Input: pattern = "aaaa", s = "dog cat cat dog"
    - Output: false

- Constraints:

    - `1 <= pattern.length <= 300`
    - pattern contains only lower-case English letters.
    - `1 <= s.length <= 3000`
    - `s` contains only lowercase English letters and spaces `' '`.
    - `s` does not contain any leading or trailing spaces.
    - All the words in `s` are separated by a single space.


<br>

## Analysis of this problem

Currently, our problem is about validating the mapping between each character in `pattern` string and a word in string `s` based on the concept bijection.

For example, we have string `pattern` = "abba", string `s` = "dog cat cat fish". The one side is that from `a` character, we have: "dog". And the reversed side is from "dog", we have: `a` character. But at the moment, "fish" string will be converted to `a` character. It is not correct. Our function should return `false`.

From the above points, there are two approaches for it:
- Using two Hash Maps to express the bijection concept.

    - Firstly, we need to check the one side, assuming that we have a character, we need to check the corresponding string exists in the remaining Hash Map or not.

    - Secondly, do the same thing but from string in `s`.

- Using only one Hash Map - from a character to a string.

    The another issue happened here is that when we need to check the case of a character based on the string.

    For example: pattern = "abba", s = "dog dog dog dog".

    To solve this issue, follow the below way:
    - Using two Set data structures for both `pattern` and `s`.

    The other improved version for this solution is to use alphabetical array that contains 26 characters in ASCII.


<br>

## Solution 1

Below is the source code that applied for first approach in [Analysis of this problem](#analysis-of-this-problem).

```Java
public class Solution {

    public boolean wordPattern(String pattern, String s) {
        Map<Character, String> charToWord = new HashMap<>();
        Map<String, Character> wordToChar = new HashMap<>();

        char[] chars = pattern.toCharArray();
        String[] words = s.split(" ");

        if (chars.length != words.length) {
            return false;
        }

        int i = 0;
        for (String word : words) {
            char c = chars[i];
            if (charToWord.containsKey(c) && !word.equals(charToWord.get(c))) {
                return false;
            } else if (wordToChar.containsKey(word) && c != wordToChar.get(word)) {
                return false;
            }

            charToWord.put(c, word);
            wordToChar.put(word, c);
            ++i;
        }

        return true;
    }
}
```

Them complexity of this solution:
- Time complexity: O(n) with n is the length of pattern.
- Space complexity: O(n)


<br>

## Solution 2

Below is the source code that applied for second approach in [Analysis of this problem](#analysis-of-this-problem).

```Java
class Solution {
    public boolean wordPattern(String pattern, String s) {
        Map<Character, String> mapper = new HashMap<>();
        Character[] characters = pattern.chars()
                                        .mapToObj(c -> (char) c)
                                        .toArray(Character[]::new);
        String[] words = s.split(" ");

        if (invalidLength(characters, words)) {
            return false;
        }

        int commonLength = characters.length;
        for (int i = 0; i < commonLength; ++i) {
            char c = characters[i];
            String word = words[i];

            if (mapper.containsKey(c)) {
                String tmp = mapper.get(c);
                if (!word.equals(tmp)) {
                    return false;
                }
            }

            mapper.put(c, word);
        }

        return true;
    }

    private boolean invalidLength(Character[] charsPattern, String[] words) {
        if (charsPattern.length != words.length) {
            return true;
        }

        Set<Character> charsSet = new HashSet<>();
        Collections.addAll(charsSet, charsPattern);

        Set<String> wordsSet = new HashSet<>(Arrays.asList(words));
        return charsSet.size() != wordsSet.size();
    }
}
```

Them complexity of this solution:
- Time complexity: O(n) with n is the length of pattern.
- Space complexity: O(n)

Then, to improve the above solution, we will not use two Set data structures for checking lengths of both strings.

```Java
public class Solution {

    public boolean wordPatternV2(String pattern, String s) {
        Map<Character, String> charToWord = new HashMap<>();
        char[] chars = pattern.toCharArray();
        String[] words = s.split("\\s+");

        if (words.length != pattern.length()) {
            return false;
        }

        int i = 0;
        for (char c : chars) {
            if (charToWord.containsKey(c)) {
                if (!charToWord.get(c).equals(words[i++])) {
                    return false;
                }
            } else {
                if (charToWord.containsValue(words[i])) {
                    return false;
                }

                charToWord.put(c, words[i++]);
            }
        }

        return true;
    }
}
```

Them complexity of this solution:
- Time complexity: O(n^2) with n is the length of pattern.

    Due to using the `containsValue()` method of HashMap, it can run in `O(n)` complexity.

- Space complexity: O(n)

To further optimize our current solution, we will use the alphabetical array.

```Java

```


<br>

## Wrapping up




<br>

Refer:

[]()
