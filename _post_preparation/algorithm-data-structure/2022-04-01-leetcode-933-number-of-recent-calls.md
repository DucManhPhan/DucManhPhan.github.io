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

    https://leetcode.com/problems/number-of-recent-calls/discuss/1647233/Java-Solution-Using-PriorityQueue


<br>

## Using Binary Search algorithm


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



<br>

## Wrapping up




<br>

Refer:

[https://leetcode.com/problems/number-of-recent-calls/](https://leetcode.com/problems/number-of-recent-calls/)