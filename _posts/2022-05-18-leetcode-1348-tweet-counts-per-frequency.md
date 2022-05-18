---
layout: post
title: Leetcode 1348 - Tweet Counts Per Frequency
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search, Tree]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Analyze our problem](#analyze-our-problem)
- [Using Binary Search algorithm](#using-binary-search-algorithm)
- [Using TreeMap data structure](#using-treemap-data-structure)
- [Using TreeSet data structure](#using-treeset-data-structure)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

A social media company is trying to monitor activity on their site by analyzing the number of tweets that occur in select periods of time. These periods can be partitioned into smaller **time chunks** based on a certain frequency (every **minute**, **hour**, or **day**).

For example, the period [10, 10000] (in **seconds**) would be partitioned into the following **time chunks** with these frequencies:
- Every **minute** (60-second chunks): `[10,69], [70,129], [130,189], ..., [9970,10000]`.
- Every **hour** (3600-second chunks): `[10,3609], [3610,7209], [7210,10000]`.
- Every **day** (86400-second chunks): `[10,10000]`

Notice that the last chunk may be shorter than the specified frequency's chunk size and will always end with the end time of the period (10000 in the above example).

Design and implement an API to help the company with their analysis.

Implement the `TweetCounts` class:
- `TweetCounts()`

    Initializes the `TweetCounts` object.

- `void recordTweet(String tweetName, int time)`

    Stores the tweetName at the recorded time (in seconds).

- `List<Integer> getTweetCountsPerFrequency(String freq, String tweetName, int startTime, int endTime)`

    Returns a list of integers representing the number of tweets with `tweetName` in each **time chunk** for the given period of time `[startTime, endTime]` (in **seconds**) and frequency `freq`.
    - `freq` is one of "`minute`", "`hour`", or "`day`" representing a frequency of every **minute**, **hour**, or **day** respectively.

For example:

```
Input
["TweetCounts","recordTweet","recordTweet","recordTweet","getTweetCountsPerFrequency","getTweetCountsPerFrequency","recordTweet","getTweetCountsPerFrequency"]
[[],["tweet3",0],["tweet3",60],["tweet3",10],["minute","tweet3",0,59],["minute","tweet3",0,60],["tweet3",120],["hour","tweet3",0,210]]

Output
[null,null,null,null,[2],[2,1],null,[4]]

Explanation
TweetCounts tweetCounts = new TweetCounts();
tweetCounts.recordTweet("tweet3", 0);                              // New tweet "tweet3" at time 0
tweetCounts.recordTweet("tweet3", 60);                             // New tweet "tweet3" at time 60
tweetCounts.recordTweet("tweet3", 10);                             // New tweet "tweet3" at time 10
tweetCounts.getTweetCountsPerFrequency("minute", "tweet3", 0, 59); // return [2]; chunk [0,59] had 2 tweets
tweetCounts.getTweetCountsPerFrequency("minute", "tweet3", 0, 60); // return [2,1]; chunk [0,59] had 2 tweets, chunk [60,60] had 1 tweet
tweetCounts.recordTweet("tweet3", 120);                            // New tweet "tweet3" at time 120
tweetCounts.getTweetCountsPerFrequency("hour", "tweet3", 0, 210);  // return [4]; chunk [0,210] had 4 tweets
```

Constraints:
- `0 <= time, startTime, endTime <= 109`
- `0 <= endTime - startTime <= 104`
- There will be at most `10^4` calls **in total** to `recordTweet` and `getTweetCountsPerFrequency`.


<br>

## Analyze our problem

In this problem, we have `recordTweet()` and `getTweetCountsPerFrequency()` methods.
- The `recordTweet()` method will save the `tweetName` and `time` of this tweet.

- The `getTweetCountsPerFrequency()` method will check that for each `tweetName`, how many tweets per frequency.

To improve the write operations in `recordTweet()` method, we can use some suitable data structure:
- HashMap data structure

    In the `getTweetCountsPerFrequency()` method, we will get a set of times per tweet to produce the frequency of a tweet per minute, or hour, or day.

- LinkedList data structure

    Normally, we will append a new tweet at the end. So the time complexity of this operation is `O(1)`.

    The drawback of this data structure is that in `getTweetCountsPerFrequency()` method, we will get frequency of a tweet. So using Linked List data structure can take `O(n)`.

    So we will not use the LinkedList data structure here.

- In the previous lines, we will use HashMap data structure to map between `tweetName` and its a set of `time`s. So which data structure will be used to contain these times?

    There are two data structures here:
    - With the time complexity of write operation, read operation that is O(logn), we can use TreeMap, TreeSet data structure.

    - With the time complexity of write operation - O(n), read operation - O(logn), we can use ArrayList data structure that is sorted.

        In the `recordTweet()` method, we will use Binary Search algorithm to find which position will be inserted. Then, insert the `time` that is corresponding to `tweetName` into that position.


<br>

## Using Binary Search algorithm

Below is the solution that use Binary Search algorithm.

```java
class TweetCounts {

    private Map<String, List<Integer>> tweetInfos;

    private Map<String, Integer> freqs;
    
    public TweetCounts() {
        this.tweetInfos = new HashMap<>();

        this.freqs = new HashMap<>();
        this.freqs.put("minute", 60);
        this.freqs.put("hour", 3600);
        this.freqs.put("day", 86400);
    }
    
    public void recordTweet(String tweetName, int time) {
        List<Integer> currentTimesPerTweet = this.tweetInfos.computeIfAbsent(tweetName, t -> new ArrayList<>());

        int idx = this.lowerBound(currentTimesPerTweet, time);
        currentTimesPerTweet.add(idx, time);
    }
    
    public List<Integer> getTweetCountsPerFrequency(String freq, String tweetName, int startTime, int endTime) {
        List<Integer> timesPerTweet = this.tweetInfos.get(tweetName);
        int startIdx = this.lowerBound(timesPerTweet, startTime);
        int endIdx = this.upperBound(timesPerTweet, endTime);

        int duration = this.freqs.get(freq);
        int outputSize = ((endTime - startTime) / duration) + 1;
        int[] res = new int[outputSize];

        for (int i = startIdx; i < endIdx; ++i) {
            int tmpResIdx = (timesPerTweet.get(i) - startTime) / duration;
            res[tmpResIdx] += 1;
        }

        List<Integer> output = new ArrayList<>();
        for (int tmp : res) {
            output.add(tmp);
        }

        return output;
    }
    
    /**
    * Find the first element that is greater than or equal to target
    *
    * @param timesPerTweet
    * @param currentTime
    * @return
    */
    private int lowerBound(List<Integer> timesPerTweet, int currentTime) {
        int blue = -1;
        int red = timesPerTweet.size();

        while (blue + 1 != red) {
            int mid = blue + (red - blue) / 2;

            int midTime = timesPerTweet.get(mid);
            if (midTime < currentTime) {
                blue = mid;
            } else {
                red = mid;
            }
        }

        if (red < timesPerTweet.size() && timesPerTweet.get(red) >= currentTime) {
            return red;
        }

        return timesPerTweet.size();
    }

    /**
    * Find the first element that is greater than target
    *
    * @param timesPerTweet
    * @param currentTime
    * @return
    */
    private int upperBound(List<Integer> timesPerTweet, int currentTime) {
        int blue = -1;
        int red = timesPerTweet.size();

        while (blue + 1 != red) {
            int mid = blue + (red - blue) / 2;

            int midTime = timesPerTweet.get(mid);
            if (midTime <= currentTime) {
                blue = mid;
            } else  {
                red = mid;
            }
        }

        if (red < timesPerTweet.size() && timesPerTweet.get(red) > currentTime) {
            return red;
        }

        return timesPerTweet.size();
    }
}
```

In this implementation, we will define the custom implementation of `upper_bound()` and `lower_bound()` methods in C++.


<br>

## Using TreeMap data structure

```java
public class TweetCounts {

    private Map<String, TreeMap<Integer, Integer>> map;

    private Map<String, Integer> freqMap;

    public TweetCounts() {
        this.map = new HashMap<>();

        this.freqMap = new HashMap<>();
        this.freqMap.put("minute", 60);
        this.freqMap.put("hour", 3600);
        this.freqMap.put("day", 86400);
    }

    public void recordTweet(String tweetName, int time) {
        if (!this.map.containsKey(tweetName)) {
            this.map.put(tweetName, new TreeMap<>());
        }

        TreeMap<Integer, Integer> tweetMap = this.map.get(tweetName);
        tweetMap.put(time, tweetMap.getOrDefault(time, 0) + 1);
    }

    public List<Integer> getTweetCountsPerFrequency(String freq, String tweetName, int startTime, int endTime) {
        if (!this.map.containsKey(tweetName)) {
            return null;
        }

        List<Integer> res = new LinkedList<>();
        int interval = this.freqMap.get(freq);
        int size = ((endTime - startTime) / interval) + 1;
        int[] buckets = new int[size];

        TreeMap<Integer, Integer> tweetMap = this.map.get(tweetName);
        for (Map.Entry<Integer, Integer> entry : tweetMap.subMap(startTime, endTime + 1).entrySet()) {
            int idx = (entry.getKey() - startTime) / interval;
            buckets[idx] += entry.getValue();
        }

        for (int num : buckets) {
            res.add(num);
        }

        return res;
    }
}
```


<br>

## Using TreeSet data structure

```java
public class TweetCounts {

    private Map<String, TreeSet<Integer>> map = new HashMap<>();

    private Map<String, Integer> meta = new HashMap<>();

    public TweetCounts() {
        this.meta.put("minute", 60);
        this.meta.put("hour", 3600);
        this.meta.put("day", 86400);
    }

    public void recordTweet(String tweetName, int time) {
        this.map.computeIfAbsent(tweetName, t -> new TreeSet<Integer>()).add(time);
    }

    public List<Integer> getTweetCountsPerFrequency(String freq, String tweetName, int startTime, int endTime) {
        TreeSet<Integer> subset = (TreeSet<Integer>) map.getOrDefault(tweetName, new TreeSet<Integer>())
                                                        .subSet(startTime, true, endTime, true);
        List<Integer> out = new ArrayList<>();
        int chunk = this.meta.get(freq);

        for (int i = startTime; i <= endTime; i = i + chunk) {
            final int iEndRange = Math.min(i + chunk - 1, endTime);
            out.add(subset.subSet(i, true, iEndRange, true)
                          .size());
        }

        return out;
    }
}
```


<br>

## Wrapping up




<br>

Refer:

[1348. Tweet Counts Per Frequency](https://leetcode.com/problems/tweet-counts-per-frequency/)