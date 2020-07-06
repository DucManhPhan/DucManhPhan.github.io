---
layout: post
title: Maximum of all subarrays of size k
bigimg: /img/image-header/factory.jpg
tags: [Sliding Window, Deque]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm](#using-brute-force-algorithm)
- [Using Sliding Window technique](#using-sliding-window-technique)
- [Using Deque solution](#using-deque-solution)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Given an array nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position. Return the max sliding window.

```
Example:

Input: nums = [1,3,-1,-3,5,3,6,7], and k = 3
Output: [3,3,5,5,6,7] 
Explanation: 

Window position                Max
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7
 
Constraints:

1 <= nums.length <= 10^5
-10^4 <= nums[i] <= 10^4
1 <= k <= nums.length
```

<br>

## Using brute force algorithm

Below is the source code of using brute force algorithm.

```java
public static int[] maxSlidingWindow(int[] nums, int k) {
    int[] maxElems = new int[nums.length - k + 1];
    int count = 0;

    for (int i = 0; i < nums.length - k + 1; ++i) {
        int max = Integer.MIN_VALUE;
        for (int j = i; j < i + k; ++j) {
            max = Math.max(max, nums[j]);
        }

        maxElems[count++] = max;
    }

    return maxElems;
}
```

The complelxity of this soluttion:
- Time complelxity: O(n * k)
- Space complexity: O(n - k + 1)


<br>

## Using Sliding Window technique

Because we always maintains the maximum element of subarray with size = k, regardless of removing or adding a new element, so we will use max heap data structure to deal with it. Then combine between sliding window technique and priority queue, we will have the below code.

```java
public int[] maxSlidingWindow(int[] nums, int k) {
    int windowStart = 0;
    int max = Integer.MIN_VALUE;
    int[] maxElems = new int[nums.length - k + 1];
    int count = 0;

    PriorityQueue<Integer> priorityQueue = new PriorityQueue<>(nums.length, Collections.reverseOrder());

    for (int windowEnd = 0; windowEnd < nums.length; ++windowEnd) {
        int item = nums[windowEnd];
        int steps = windowEnd - windowStart + 1;
        priorityQueue.add(item);

        if (steps <= k) {
            max = priorityQueue.peek();
        }

        if (steps == k) {
            maxElems[count++] = max;

            // remove the element at windowStart index
            priorityQueue.remove(nums[windowStart]);
            ++windowStart;
        }
    }

    return maxElems;
}
```

But we still encounter the Time Limit Exceeded error. What is our problem?

We are using the built-in Priority Queue in Java. Then we need to see the definition of remove() method.

```java
public boolean remove(Object o) {
    int i = indexOf(o);
    if (i == -1) {
        return false;
    } else {
        removeAt(i);
        return true;
    }
}

private int indexOf(Object o) {
    if (o != null) {
        final Object[] es = queue;
        for (int i = 0, n = size; i < n; i++) {
            if (o.equals(es[i])) return i;
        }
    }

    return -1;
}
```

So the time complexity of this solution uses Priority Queue is O(n * k).

Note:
- With Priority Queue, we can construct it by using.

    ```java
    // contains index of elements
    PriorityQueue<Integer> queue = new PriorityQueue<>((i1, i2) -> (nums[i1] - nums[i2]));
    ```

<br>

## Using Deque solution

To improve the performance of solution that uses Sliding Window technique, we will deque to do it.
- When we increment the elements of deque, we need to check whether this subarray that satisfies size = k or not. If not, we will remove the elements at the head of deque.
- Each element will be compared with the elements at the end of deque, if it is greater than deque's elements, we will remove elements at the end of deque.

```java
public static int[] maxSlidingWindow(int[] nums, int k) {
    int len = nums.length;
    if (len == 0 || k == 0) {
        return new int[0];
    }

    int[] result = new int[len - k + 1];
    Deque<Integer> deque = new ArrayDeque<>();

    for (int i = 0; i < len; ++i) {
        // remove indices that are out of bound - subarray with size = k
        while (deque.size() > 0 && deque.peekFirst() <= i - k) {
            deque.pollFirst();
        }

        // remove indices whose corresponding values are less than nums[i]
        while (deque.size() > 0 && nums[deque.peekLast()] < nums[i]) {
            deque.pollLast();
        }

        // add nums[i]
        deque.offerLast(i);

        if (i >= k - 1) {
            result[i - k + 1] = nums[deque.peekFirst()];
        }
    }

    return result;
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(k)

<br>

## Wrapping up

- Understanding about the structure of sliding window technique and uses deque data structure.


<br>

Refer: 

[https://leetcode.com/problems/sliding-window-maximum/](https://leetcode.com/problems/sliding-window-maximum/)