---
layout: post
title: Sliding window technique
bigimg: /img/image-header/home-office-1.jpg
tags: [Sliding Window]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Sliding window techique](#solution-with-sliding-window-techique)
- [Some types of Sliding window technique](#some-types-of-sliding-window-technique)
- [When to use](#when-to-use)
- [Steps to solve Sliding window problem](#steps-to-solve-sliding-window-problem)
- [Examples of Sliding Window technique](#examples-of-sliding-window-technique)
- [Wrapping up](#wrapping-up)

<br>

## Given problem





<br>

## Solution with Sliding window techique






<br>

## Some types of Sliding window technique






<br>

## When to use

- When we usually cope with the problems that are relevant to the range of elements, then we need to calculate some properties on them such as sum, longest, smallest string, ...

- When our need is to have time complexity that is O(n) - linear time.


<br>

## Steps to solve Sliding window problem

1. Determine our problem that is related to the range of elements and some properties of them.

2. Mark **windowStart** variable as a starting point of our window to scan. And **windowEnd** variable will be scan all elements of array.

3. Then, determine our sliding window type is fixed length window or dynamic length window.

4. A condition that we need to increment the **windowStart** variable to point to other element.

    It means that we will remove the elements that do not satisfy in our sliding window's length.

5. Convert all our input data into the other variables.

<br>

## Examples of Sliding Window technique

1. Max Consective Ones

    Given a binary array, find the maximum number of consecutive 1s in this array.

    For example:

    ```java
    Input: [1,1,0,1,1,1]
    Output: 3
    Explanation: The first two digits or the last three digits are consecutive 1s.
        The maximum number of consecutive 1s is 3.
    ```

    - Analysis

        - Currently, we will scan all the consecutive numbers 1s to find the maximum length.
        - Then, based on section [When to use](#when-to-use), we can use sliding window techique to solve this problem.

    - Source code

        ```java
        public int findMaxConsecutiveOnes(int[] nums) {
            int length = nums.length;
            int maxLength = 0;
            int windowStart = 0;    // always point to the index of current element with value 1

            for (int windowEnd = 0; windowEnd < length; ++windowEnd) {
                if (nums[windowEnd] != 1) {
                    windowStart = windowEnd;
                    ++windowStart;
                }

                maxLength = Math.max(maxLength, windowEnd - windowStart + 1);
            }

            return maxLength;
        }
        ```

2. Longest Repeating Character Replacement



3. No repeated characters



<br>

## Wrapping up





<br>

Refer:

[https://medium.com/@zengruiwang/sliding-window-technique-360d840d5740](https://medium.com/@zengruiwang/sliding-window-technique-360d840d5740)

[https://www.geeksforgeeks.org/window-sliding-technique/](https://www.geeksforgeeks.org/window-sliding-technique/)

[https://medium.com/outco/how-to-solve-sliding-window-problems-28d67601a66](https://medium.com/outco/how-to-solve-sliding-window-problems-28d67601a66)

[https://medium.com/outco/the-algorithm-of-an-algorithm-28043fe47b51](https://medium.com/outco/the-algorithm-of-an-algorithm-28043fe47b51)

[https://itnext.io/dynamic-programming-vs-divide-and-conquer-2fea680becbe](https://itnext.io/dynamic-programming-vs-divide-and-conquer-2fea680becbe)

[https://medium.com/outco/how-to-merge-k-sorted-arrays-c35d87aa298e](https://medium.com/outco/how-to-merge-k-sorted-arrays-c35d87aa298e)

[https://medium.com/outco/reversing-a-linked-list-easy-as-1-2-3-560fbffe2088](https://medium.com/outco/reversing-a-linked-list-easy-as-1-2-3-560fbffe2088)

[https://medium.com/outco/3-models-for-better-learning-6f638a066e2e](https://medium.com/outco/3-models-for-better-learning-6f638a066e2e)

[https://medium.com/outco/functional-programming-and-binary-trees-will-they-blend-2419170c317d](https://medium.com/outco/functional-programming-and-binary-trees-will-they-blend-2419170c317d)

[https://medium.com/outco/how-to-implement-memoization-in-3-simple-steps-83758b2439a](https://medium.com/outco/how-to-implement-memoization-in-3-simple-steps-83758b2439a)

[https://medium.com/outco/the-8-layers-of-software-engineering-66b9108dc8e2](https://medium.com/outco/the-8-layers-of-software-engineering-66b9108dc8e2)

[https://www.geeksforgeeks.org/maximize-number-0s-flipping-subarray/?source=post_page](https://www.geeksforgeeks.org/maximize-number-0s-flipping-subarray/?source=post_page)

[https://www.techiedelight.com/sliding-window-problems/](https://www.techiedelight.com/sliding-window-problems/)

<br>

**Exercise**

[https://c0deb0t.wordpress.com/2018/06/20/the-sliding-window-algorithm-and-similar-techniques/ ](https://c0deb0t.wordpress.com/2018/06/20/the-sliding-window-algorithm-and-similar-techniques/ )

[https://c0deb0t.wordpress.com/2018/06/24/dynamic-programming-tricks/](https://c0deb0t.wordpress.com/2018/06/24/dynamic-programming-tricks/)

[https://c0deb0t.wordpress.com/tag/competitive-programming/](https://c0deb0t.wordpress.com/tag/competitive-programming/)

[https://c0deb0t.wordpress.com/tag/algorithms/](https://c0deb0t.wordpress.com/tag/algorithms/)

[https://c0deb0t.wordpress.com/tag/intermediate/](https://c0deb0t.wordpress.com/tag/intermediate/)

[https://c0deb0t.wordpress.com/2018/02/27/all-about-ranges-intervals-part-1/](https://c0deb0t.wordpress.com/2018/02/27/all-about-ranges-intervals-part-1/)

[https://c0deb0t.wordpress.com/2018/03/03/all-about-ranges-intervals-part-2/](https://c0deb0t.wordpress.com/2018/03/03/all-about-ranges-intervals-part-2/)

[https://www.nayuki.io/page/sliding-window-minimum-maximum-algorithm](https://www.nayuki.io/page/sliding-window-minimum-maximum-algorithm)

[https://leetcode.com/problems/minimum-window-substring/](https://leetcode.com/problems/minimum-window-substring/)

[https://www.geeksforgeeks.org/find-the-smallest-window-in-a-string-containing-all-characters-of-another-string/](https://www.geeksforgeeks.org/find-the-smallest-window-in-a-string-containing-all-characters-of-another-string/)

[https://www.geeksforgeeks.org/given-sorted-array-number-x-find-pair-array-whose-sum-closest-x/](https://www.geeksforgeeks.org/given-sorted-array-number-x-find-pair-array-whose-sum-closest-x/)

[https://www.geeksforgeeks.org/given-an-array-a-and-a-number-x-check-for-pair-in-a-with-sum-as-x/](https://www.geeksforgeeks.org/given-an-array-a-and-a-number-x-check-for-pair-in-a-with-sum-as-x/)
