---
layout: post
title: Leetcode 933 - Number of Recent Calls
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search, Queue]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Queue](#using-queue)
- [Using Binary Search algorithm](#using-binary-search-algorithm)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

You have a `RecentCounter` class which counts the number of recent requests within a certain time frame.

Implement the `RecentCounter` class:
- `RecentCounter()` Initializes the counter with zero recent requests.
- `int ping(int t)` Adds a new request at time t, where t represents some time in milliseconds, and returns the number of requests that has happened in the past `3000` milliseconds (including the new request). Specifically, return the number of requests that have happened in the inclusive range `[t - 3000, t]`.

It is guaranteed that every call to ping uses a strictly larger value of `t` than the previous call.

```
Input
["RecentCounter", "ping", "ping", "ping", "ping"]
[[], [1], [100], [3001], [3002]]
Output
[null, 1, 2, 3, 3]

Explanation
RecentCounter recentCounter = new RecentCounter();
recentCounter.ping(1);     // requests = [1], range is [-2999,1], return 1
recentCounter.ping(100);   // requests = [1, 100], range is [-2900,100], return 2
recentCounter.ping(3001);  // requests = [1, 100, 3001], range is [1,3001], return 3
recentCounter.ping(3002);  // requests = [1, 100, 3001, 3002], range is [2,3002], return 3
```

Constraints:
- `1 <= t <= 109`
- Each test case will call ping with **strictly increasing** values of t.
- At most 104 calls will be made to `ping`.


<br>

## Using Queue

1. Using Queue to contain all data

    ```java
    public static class RecentCounter {

        private final LinkedList<Integer> timeFrames;

        private int count;

        public RecentCounter() {
            this.timeFrames = new LinkedList<>();
        }

        /**
            * This way was Time Limit Exceeded Error.
            *
            * @param t
            * @return
            */
        public int ping(int t) {
            this.timeFrames.offer(t);
            ++this.count;

            int oldestTime = t - 3000;
            if (oldestTime < 0) {
                return this.count;
            }

            int lessElementsCount = 0;
            Iterator<Integer> it = this.timeFrames.iterator();
            while (it.hasNext()) {
                int currentTime = it.next();

                if (currentTime >= oldestTime) {
                    break;
                }

                ++lessElementsCount;
            }

            return this.count - lessElementsCount;
        }
    }
    ```

2. Using Priority Queue

    The drawback of the above solution that use Queue to contain data is that we need to iterate all data. So to reduce this issue, we will use PriorityQueue to remove the elements that have values are less than `t - 3000`.

    By default, PriorityQueue uses Binary Heap to implement and the front element is always the minimum element.

    ```java
    public static class RecentCounter {

        PriorityQueue<Integer> queue;

        public RecentCounter() {
            this.queue = new PriorityQueue<>();
        }

        public int ping(int t) {
            while (!this.queue.isEmpty() && this.queue.peek() < t - 3000) {
                this.queue.poll();
            }

            this.queue.add(t);
            return this.queue.size();
        }
    }
    ```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(n)


<br>

## Using Binary Search algorithm

Because of the increased order of the `requests` array, we can use Binary Search algorithm to find an index of element that is greater or equal to `t - 30000`.

```java
class RecentCounter {

    private List<Integer> timeFrames;
    
    public RecentCounter() {
        this.timeFrames = new ArrayList<>();
    }
    
    public int ping(int t) {
        this.timeFrames.add(t);

        int oldestTime = t - 3000;
        if (oldestTime < 0) {
            return this.timeFrames.size();
        }

        int currentIdx = Collections.binarySearch(this.timeFrames, oldestTime);
        if (currentIdx < 0) {
            currentIdx = -currentIdx - 1;
        }

        return this.timeFrames.size() - currentIdx;
    }
}
```

The complexity of this solution:
- Time complexity: O(log(n)).
- Space complexity: O(n)


<br>

## Wrapping up




<br>

Refer:

[https://leetcode.com/problems/number-of-recent-calls/](https://leetcode.com/problems/number-of-recent-calls/)