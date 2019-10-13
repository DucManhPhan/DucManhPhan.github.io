---
layout: post
title: Understanding about Regular Expression
bigimg: /img/image-header/california.jpg
tags: [Regex]
---

In this article, we will learn about some basic information about regular expression such as character classes, meta sequences, anchor, quantifiers, capturing group, flag and modifiers. ...

It is useful when we want to build complex regex to satisfy our problems.

Let's get started.

<br>

## Table of contents
- [What is Regular Expression](#what-is-regular-expression)
- [Character classes](#character-classes)
- [Meta sequences](#meta-sequences)
- [Anchor](#anchor)
- [Quantifiers](#quantifiers)
- [Capturing group](#capturing-group)
- [Flags/Modifiers](#flags-/-modifiers)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)

<br>

## What is Regular expression
According to [wikipedia.com](https://en.wikipedia.org/wiki/Regular_expression), we have:

```
A regular expression is a sequence of characters that define a search pattern. Usually such patterns are used by string search algorithms for find or find and replace operations on strings, or for input validation.
```


<br>

## Character classes

|          Regex         |                 Meaning                |
| ---------------------- | -------------------------------------- |
| [abc]                  | A single character of: a, b, c         |
| [^abc]                 | A character except: a, b, c            |
| [a-z]                  | A character in the range: a-z          |
| [^a-z]                 | A character not in the range: a-z      |
| [a-zA-Z]               | A character in the range: a-z or A-Z   |


<br>

## Meta sequences

|          Regex         |                 Meaning                |
| ---------------------- | -------------------------------------- |
| .                      | Any single character                   |
| \s                     | Any whitespace character               |
| \S                     | Any non-whitespace character           |
| \d                     | Any digit                              |
| \D                     | Any non-digit                          |
| \w                     | Any word character                     |
\ \W                     | Any non-word character                 |

Note:
- ```\d``` and ```[\d]``` both match a single digit.

- ```\D``` matches any character that is not a digit, and is equivalent to ```[^\d]```.

- ```\w``` matches a single word character. A word character is a character that can occur as part of a word. That includes letters, digits, and the underscore.

    In Java, Javascript, PCRE, and Ruby, ```\w``` is always identical to ```[a-zA-Z0-9_]```.

- ```\s``` matches any whitespace character. This includes spaces, tabs, and line breaks.

    In .NET, Perl, Javascript, ```\s``` also matches any character defined as whitespace by the Unicode standard.

    Javascript uses Unicode for ```\s``` but ASCII for ```\d``` and ```\w```.


<br>

## Anchor

|          Regex         |                 Meaning                |
| ---------------------- | -------------------------------------- |
| \G                     | Start of match                         |
| ^                      | Start of string                        |
| $                      | End of string                          |
| \A                     | Start of string                        |
| \Z                     | End of string                          |
| \z                     | Absolute end of string                 |
| \b                     | A word boundary                        |
| \B                     | Non-word boundary                      | 

Note:
- Anchors do not match any characters. Instead, they match at certain positions, effectively anchoring the regular expression match at those positions.

- The anchor ```\A``` always matches at the very start of the subject text, before the first character. Place ```\A``` at the start of our regex to test whether the subject text begins with the text we want to match.

    Javascript does not support ```\A```.

    Unless we're using Javascript, we recommend that we always use ```\A``` instead of ```^```. The meaning of ```\A``` never changes, avoiding any confusion or mistakes in setting regex options.

- The anchor ```\Z``` and ```\z``` match at the very end of the subject text, after the last character.

    .NET, Java, PCRE, Perl, and Ruby support both ```\Z``` and ```\z```.
    
    Python supports only ```\Z```.

    Javascript does not support ```\Z``` or ```\z``` at all.

    The difference between ```\Z``` and ```\z``` comes into play when the last character in our subject text is a line break.
    - ```\Z``` can match at the very end of the subject text, after the final line break, as well as immediately before that line break.

        The benefit is that we can search for ```omega\Z``` without having to worry about stripping off trailing line break at the end of our subject text.

        When reading a file line by line, some tools include the line break at the end of the line, whereas others don't. ```\Z``` masks this difference.

    - ```\z``` matches only at the very end of the subject text, so it will not match text if a trailing line break follows.

- The token ```\b``` matches at the start or the end of a word. By itself, it results in a zero-length match.

    Strictly speaking, ```\b``` matches in three positions:
    - Before the first character in the subject, if the first character is a word character.
    - After the last character in the subject, if the last character is a word character.
    - Between two characters in the subject, where one is a word character and the other is not a word character.

- The token ```\B``` matches at every position in the subject text where ```\b``` do not match.

    ```\B``` matches at every position that is not at the start or end of a word.

    ```\B``` matches in these five positions:
    - Before the first character in the subject, if the first character is not a word character
    - After the last character in the subject, if the last character is not a word character
    - Between two word characters
    - Between two nonword characters
    - The empty string

<br>

## Quantifiers

|          Regex         |                 Meaning                |
| ---------------------- | -------------------------------------- |
| a?                     | Zero or one of a                       |
| a*                     | Zero or more of a                      |
| a+                     | One or more of a                       |
| a{3}                   | Exactly 3 of a                         |
| a{3,}                  | 3 or more of a                         |
| a{4, 6}                | Between 4 and 6 of a                   |
| .*                     | Greedy quantifier - match zero or more characters except newline |
| a*?                    | Lazy quantifier                        |
| a*+                    | Possessive quantifier                  |

Note:
- Using ```*?``` or ```+?``` quantifier

    They make that operator non-greedy. They will try to match a minimum number of times instead of a maximum number of times.

    For example:

    If we want to get all words in ```{}``` such as ```{hello}{world}``` with ```{(.*)}```.
    
    So, the result is ```hello}{world```, which may be undesirable.

    So, to fix this problem, using the non-greedy ```{(.*?)}``` gives the matches ```hello``` and ```world``` as desired.


<br>

## Capturing group

|          Regex         |                 Meaning                |
| ---------------------- | -------------------------------------- |
| (...)                  | Capture everthing enclosed             |
| (a\|b)                  | Match either a or b                    |
| (?:...)                | Match everything enclosed (non-capturing) |
| (?>...)                | Atomic group (non-capturing)           |
| (?\|...)                | Duplicate subpattern group number      |
| (?'name'...)           | Named capturing group                  |
| (?<name>...)           | Named capturing group                  |
| (?P<name>...)          | Named capturing group                  |
| (?=...)                | Positive lookahead                     |
| (?!...)                | Negative lookahead                     |
| (?<=...)               | Positive lookbehind                    |
| (?<!...)               | Negative lookbehind                    |
| ([a-zA-Z])[0-9]\\1     | Back-reference                         |
| ${groupName} or $groupNumber | Capturing group reference in replacement string |
| 

Note:
- Lookaheads are zero-length assertions, that means they are not included in the match.

    They only assert whether immediate portion ahead of a given input string's current portion is suitable for a match or not.

    For example, in java, we have:

    ```java
    // Positive lookahead
    [a-z](?=bc)

    // Positive lookbehind
    (?<=a>)bc
    ```

- From JDK 7, capturing group can be assigned an explicit name by using the syntax ```(?<name_group>...)```.

    In Java, in order to information that correspond to group, we can use with:

    ```java
    String regex = "(?<name_group>...)";
    ...

    Object data = Matcher.group("name_group");
    ```

    Otherwise, we can use name of group that will be used with back-reference ```\k<name_group>```.

    ```java
    String regex = "<(?<key>)>(?<value>.*)</\\k<key>>";
    ...
    ```

- Capturing group reference in replacement

    ```java
    String regex = "([a-z]{1,1})([0-9]{2,2})";
    Pattern.compile(regex)
           .matcher("z43 t34")
           .replaceAll("$2 $1");     // result: t34 z43
    ```

- Atomic groups do not backtrack once a match is successful. Atomic groups basically discards / forgets the subsequent parts in the group once a token matches.

    It can be applied when our case have some conditions that if one of them is not satisfied, regex do not have to backtrack to the other condition.

    ```java
    Pattern.compile("<(?>image|img)>")
       .matcher("<image")
       .find();//no matches
    ```

<br>

## Flags/Modifiers

|          Regex         |                 Meaning                |
| ---------------------- | -------------------------------------- |
| m                      | Multiline                              |
| i                      | Case insensitive                       |
| x                      | Ignore whitespace                      |
| s                      | single line                            |
| u                      | unicode                                |

Note:
- Case insensitivity

    ```java
    (?i)[A-F0-9]
    ```

    Use for .NET, Java, PCRE, Perl, Python, Ruby.


<br>

## Benefits and Drawbacks
1. Benefits
- Very flexible
- Fast processing
- Language independent
- A lot of work in a single line of code
- Often simpler than "substring + indexes" approach

2. Drawbacks
- Hard to read
- Hard to debug - no information when no match
- Compilation only at runtime
- Typos are very easily made (Ex: forget escape character)

Regular expression, if not written well may perform poorly. They may run slowly, and when they are executed frequently in some code, they may be the source of high CPU utilization. So, we have some techniques to reduce pitfalls:
- Do not forget to escape regex metacharacters outside a character class.

    All the special metacharacters such as ```*```, ```+```, ```?```, ```.```, ```|```, ```(```, ```)```, ```[```, ```{```, ```^```, ```$```, and so on, need to be escaped if the intent is to match them literally.

- Avoid escaping every non-word character

    When we escape every non-word characters, it makes our ode un-readable.

- Avoid unnecessary capturing groups to reduce memory consumption

    If we are not extracting any substring or not using a group in backreferences, then it is better to avoid capturing groups by using one or more of the following ways:
    - use character classes in certain cases

        ```java
        // Before
        (a|e|i|o|u)

        // After
        [aeiou]
        ```

    - use a non-capturing group by placing a ?: at the start of the group

        ```java
        // Before
        (red|blue|white)

        // After
        (?:red|blue|white)
        ```

    - to write a regex to match an integer or decimal number, there is no need to use the following regex:

        ```java
        // Before
        ^(\d*)(\.?)(\d+)$

        // After
        ^\d*\.?d+$
        ```

    - sometimes, a regex may contain multiple problems

        ```java
        // Before
        ^https?\:\/\/(www\.)?example\.com$

        // After
        ^https?://(?:www\.)?example\.com$
        ```

- Do not forget to use the required group around alternation

    The ```^```, ```$```, ```\A```, ```\Z```, ```\z``` anchors and the ```\b``` boundary matcher have a higher precedence than the alternation character, ```|``` (pipe).

    ```java
    // Before
    ^com|org|net$

    // After
    ^(?:com|org|net)$
    ```

- Use predefined character classes instead of longer versions

    - Use ```\d``` instead of ```[0-9]```.
    - Use ```\D``` instead of ```[^0-9]```.
    - Use ```\w``` instead of ```[a-zA-Z_0-9].
    - Use ```\W``` instead of ```[^a-zA-Z_0-9].

- Use the limiting quantifier instead of repeating a character or pattern multiple times

    ```java
    // Before
    // MAC address
    ^[A-F0-9]{2}:[A-F0-9]{2}:[A-F0-9]{2}:[A-F0-9]{2}:[A-F0-9]{2}:[A-F0-9]{2}$

    // After
    ^(?:[A-F\d]{2}:){5}[A-F\d]{2}$
    ```

- Do not use an unescaped hyphen in the middle of a character class

    Most of the special regex metacharacters are treated literally inside the character class and we do not need to escape them inside the character class.

    ```java
    // Before
    [*+-/]

    // After
    [-*+/] 
    [*+/-]
    [*+\-/]
    ```

- The mistake of calling ```matcher.goup()``` without a prior call to ```matcher.find()```, ```matcher.matches()```, or ```matcher.lookingAt()```

    If we call ```matcher.group()``` without calling one of these three methods, then the code will throw a ```java.lang.IllegalStateException``` exception.

- Do not use regular expressions to parse XML / HTML data

    Using regular expressions to parse XML or HTML text is probably the most frequently committed mistake.

    Although regular expressions are very useful, they have their limitations and these limits are usually met when trying to use them for XML or HTML parsing. HTML and XML are not regular languages by nature.

<br>

## Wrapping up



<br>


Refer:

[https://www.logicbig.com/tutorials/core-java-tutorial/java-regular-expressions/regex-possessive-quantifiers.html](https://www.logicbig.com/tutorials/core-java-tutorial/java-regular-expressions/regex-possessive-quantifiers.html)

[https://regex101.com/](https://regex101.com/)

[https://www.slideshare.net/niekschmoller/regex-external](https://www.slideshare.net/niekschmoller/regex-external)