---
layout: post
title: Reading numbers like Vietnamese
bigimg: /img/image-header/yourself.jpeg
tags: [Array]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of this problem](#solution-of-this-problem)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution of this problem


```Java
public class Solution {

    public static void main(String[] args) {
        int[] testcase = {1000000000, 1005, 10500, 10050, 12500, 1234, 1234567, 1, 12, 123, 100, 123456789, 4, 50, 105};
        for (int i : testcase) {
            String res = numberToString(i);
            System.out.println(i + " - " + res);
        }
    }

    public static String numberToString(int a) {
        Map<Character, String> mapIntToChar = new HashMap<>() {{
            put('0', "");
            put('1', "mot ");
            put('2', "hai ");
            put('3', "ba ");
            put('4', "bon ");
            put('5', "nam ");
            put('6', "sau ");
            put('7', "bay ");
            put('8', "tam ");
            put('9', "chin ");
        }};

        Stack<String> stk = new Stack<>();
        String[] values = {" ", " ", "muoi ", "tram ", "nghin ", "", "", "trieu "};
        String nums = Integer.valueOf(a).toString();
        if (nums.length() > 9) {
            return "";
        }

        int count = 0;
        boolean isPreviousNotZeroNumber = false;
        for (int i = nums.length() - 1; i >= 0; --i) {
            StringBuilder sb = new StringBuilder();
            char c = nums.charAt(i);
            ++count;

            getSmallerThousandPart(c, count, sb, nums.length(), isPreviousNotZeroNumber, values, mapIntToChar);
            getLargerThousandPart(c, count, sb, nums.length(), values, mapIntToChar);
            getMillionPart(c, count, sb, nums.length(), values, mapIntToChar);

            stk.push(sb.toString());
            isPreviousNotZeroNumber = c != '0' ? true : false;
        }

        StringBuilder res = new StringBuilder();
        while (!stk.isEmpty()) {
            res.append(stk.pop());
        }

        return res.toString();
    }

    public static void getSmallerThousandPart(char c, int count, StringBuilder number, int len, boolean isPreviousNotZeroNumber, String[] values, Map<Character, String> mapIntToChar) {
        if (count < 4) {    // unit part
            if (count < len && count % 4 == 1 && c == '4') {
                number.append("tu ");
            } else if (count == len && count == 2 && c == '1') {
                // do nothing
            } else {
                number.append(mapIntToChar.get(c));
            }

            if (c == '0') {
                if (isPreviousNotZeroNumber) {
                    number.append("linh ");
                }

                return;
            }

            number.append(values[count % 4]);
        }
    }

    public static void getLargerThousandPart(char c, int count, StringBuilder number, int len, String[] values, Map<Character, String> mapIntToChar) {
        if (count > 3 && count < 7) {   // hundred part
            if (count < len && (count - 3) % 4 == 1 && c == '4') {  // 4 is at unit position
                number.append("tu ");
            } else if (count == len && count == 5 && c == '1') {    // 1 is at thousand part
                // do nothing
            } else {
                number.append(mapIntToChar.get(c));
            }

            if (count == 4) {
                number.append(values[count]);
            } else {
                if (c == '0') {
                    return;
                }

                number.append(values[(count - 3) % 4]);
            }
        }
    }

    public static void getMillionPart(char c, int count, StringBuilder number, int len, String[] values, Map<Character, String> mapIntToChar) {
        if (count > 6) {    // million part
            if (count < len && (count - 6) % 4 == 1 && c == '4') {
                number.append("tu ");
            } else {
                number.append(mapIntToChar.get(c));
            }

            if (count == 7) {
                number.append(values[count]);
            } else {
                if (c == '0') {
                    return;
                }

                number.append(values[(count - 6) % 4]);
            }
        }
    }

}
```


<br>

## Wrapping up



