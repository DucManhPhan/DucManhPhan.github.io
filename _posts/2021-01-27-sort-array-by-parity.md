---
layout: post
title: Sort array by parity
bigimg: /img/image-header/yourself.jpeg
tags: [Two-Pointers]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Using recursion way](#using-recursion-way)
- [Using two-pointers technique](#using-two-pointers-technique)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Given an array A of non-negative integers, return an array consisting of all the even elements of A, followed by all the odd elements of A.

You may return any answer array that satisfies this condition.

```java
Example 1:
Input: [3,1,2,4]
Output: [2,4,3,1]
        The outputs [4,2,3,1], [2,4,1,3], and [4,2,1,3] would also be accepted.
```

Constraints:
- 1 <= A.length <= 5000
- 0 <= A[i] <= 5000

<br>

## Using recursion way

```java
public Solution {
    public int[] sortArrayByParityI(int[] A) {
        int len = A.length;

        for (int i = 0; i < len; ++i) {
            this.sortArrayByParityI(A, i, i);
            this.sortArrayByParityI(A, i, i + 1);
        }

        return A;
    }

    public void sortArrayByParityI(int[] A, int i, int j) {
        while (!((i < 0 || i >= A.length) || (j < 0 || j >= A.length))) {
            if (((A[j] & 1) == 0) && ((A[i] & 1) != 0)) {
                int tmp = A[i];
                A[i] = A[j];
                A[j] = tmp;
            }

            --i;
            ++j;
        }
    }
}
```

The complexity of this solution:
- Time complexity: O(n*2^n)
- Space complexity: O(1)

<br>

## Using two-pointers technique

The target of this problem is to seperate obviously the even numbers and odd numbers into two sides of an array. So, to think carefully, we can find it that it is the same as the idea of the two-pointers technique.

Below is the source code of this technique.

```java
class Solution {
    public int[] sortArrayByParity(int[] A) {
        int len = A.length;
        int first = 0;
        int second = len - 1;

        while (first < second) {
            while (first < len && ((A[first] & 1) == 0)) {    // even
                ++first;
            }

            while (second >= 0 && ((A[second] & 1) != 0)) {   // odd
                --second;
            }

            if (first >= len || second < 0 || first >= second) {
                break;
            }

            int tmp = A[first];
            A[first] = A[second];
            A[second] = tmp;

            ++first;
            --second;
        }

        return A;
    }
}
```

Then, we can refactor the above code like the below:

```java
public Solution {
    public int[] sortArrayByParity(int[] A) {
        int left = 0;
        int right = A.length -1;

        while(left < right)
        {
            if(A[left] % 2 == 1 && A[right] % 2 == 0)
            {
                int tmp = A[left];
                A[left] = A[right];
                A[right] = tmp;

                left++;
                right--;
            }

            if(A[left] % 2 == 0) left++;
            if(A[right] % 2 == 1) right--;
        }

        return A;
    }
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(1)

<br>

## Wrapping up

- Understanding about the idea to apply the two-pointers technique. 


<br>

Refer:

[https://leetcode.com/problems/sort-array-by-parity/](https://leetcode.com/problems/sort-array-by-parity/)