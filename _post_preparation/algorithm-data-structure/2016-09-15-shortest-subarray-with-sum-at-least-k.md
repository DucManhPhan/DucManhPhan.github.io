---
layout: post
title: Shortest Subarray with Sum at Least K
bigimg: /img/image-header/california.jpg
tags: [Java]
---

It has been 3 years since the last time I practised competitive programming. Despite the passing of time, as long as I love ideas, I love it like an old friend. For many people, trying to solve such problems is mainly coding skills, how to use libraries, data structure. I concern and enjoy how ideas come, and wonder is there any methods, such as mental models, help us in solving this kind of challenges, rather than solutions suddenly appear in mind as lighting a bulb.

Link: https://leetcode.com/problems/shortest-subarray-with-sum-at-least-k/

This problem is a good example for the mentioned situation. Don’t worry if it is marked as hard. It becomes clear soon, follow approaches and explanations below.

<br>

## Table of contents
- [Getting started with the problem](#getting-started-with-the-problem)
- [Solution](#solution)
- [Solving with non-negative array](#solving-with-non-negative-array)
- [Solving the original problem](#solving-the-original-problem)
- [Wrapping up](#wrapping-up)

<br>

## Getting started with the problem

Return the length of the shortest, non-empty, contiguous subarray of A with sum at least K. If there is no non-empty subarray with sum at least K, return -1.

Note:

```
1 <= A.length <= 50000
-10 ^ 5 <= A[i] <= 10 ^ 5
1 <= K <= 10 ^ 9
```

Basically, we can solve this with brute-force idea: visit all pairs (i, j) and check conditions. Let call n is length of A. If calculating sum of each subarray from i to j, the complexity would be O(n^3), while pre-calculating an array of an accumulative sum from the beginning of A, called S, we can easily getting total values of subarray from i to j in O(1), so that the complexity would be O(n^2).


S[t+1] = S[t] + A[t] for all 0 <= t < n.
Subarray from i to j has the length j-i+1 and the sum S[j+1]-S[i].

However, with n <= 50000, it must be O(nlogn) or O(n) to pass this challenge. We have to find better solutions.

Definitely, solutions start from S, the accumulative sum, is better than A, the original array. Re-write the problem with S here:

```
argmin{j - i, \forall (i, j): i < j, S[j]-S[i] >= K}
```

```C++
vector<int> S;
S.resize(n+1);
S[0]=0;
for (int i=0; i < n; ++i)
    S[i+1]=S[i]+A[i];
```

<br>

## Solution

Suppose that to find the answer for the whole array, we need to find the answer at every subarray from the beginning to j. Visiting all j takes O(n).

To quickly find the best i is difficult, since we have 3 conditions at the same time: i < j, S[i] <= S[j]-K and i is as high as possible.

Inheriting the loop of j, considering i as **j'<j**, we can reduce the searching space. This means at **j'**, we save some information which can support to compute i. Since it is obvious that **j'<j**, we solve the first condition. But **S[j]-K** is changed according to j. Is it possible to prepare some information at **j'** for computing alternative values of **S[j]-K** at further j?

Yes, it is possible. For easier, let consider simpler cases below.

<br>

## Solving with non-negative array

Suppose that A has no negative values. Accumulative sum of A, S is an ascending array. Now we have:

- if S[i] <= S[j]-K, then with all t < i, S[t] <= S[i] so that S[t] <= S[j] - K either (1).

- i is the optimal at j if S[i] <= S[j]-K and all t>i has S[t] > S[j]-K (2).

- With **j'<j**, S[j'] <= S[j], thus S[i'] <= S[j']-K <= S[j]-K. That means the best value i' of j' may be the best value of j (3).

![](../img/Data-structure/queue/untitled-diagram-1.png)

Since (1), finding i can be done by moving a pointer from 0 to j-1 and check (2). From (3), as i \geq i' where i' is the answer at j-1, it is not necessary to explore from 0 to i'-1, finding i for j could be inherited from i' of j-1. The pointer visits each element of S at most once, thus its total complexity after moving j from 1 to n is O(n). We solve the problem with non-negative array in O(n).

```java
int res=-1;
int i=-1;
for (int j = 1; j <= n; ++j)
{
    while (i<j-1 && S[j]-S[i]>=K) ++i;
    if (i>-1 && S[j]-S[i]>=K) 
        res = (res==-1) ? (j-i):min(res, j-i);
}
return res;
```

<br>

## Solving the original problem

Since the original array has negative numbers, its accumulative sum is not ascending. We face to these challenges:

- A[i-1]<0 leads to existing t<i that S[t]>S[i], thus (1) and (2) are incorrect.
- A[j-1]<0 leads to existing j'<j that S[j]<S[j'], thus (3) is incorrect.

![](../img/Data-structure/queue/ex2.png)

Notice that at j where A[j-1]<0 does not update the optimal value of the whole array. If existing A[j-1]<0 and S[j]-S[i] \geq K, we have S[j-1]-S[i] > S[j]-S[i] \geq K, thus j makes the optimal subarray longer, does not have any improvement from j-1. Therefore, just ignore these j with A[j-1]<0, we still update i for j by i' of j'.

However, since (1) and (2) is no longer true, stopping the pointer by (2) could miss better values of i after the breaking point. We need another way to storage some information that assists us reducing exploring space. In general, considering the relationship between options in finding different i for different j, a few comments below are useful to limit exploring cases:

If S[t] = min_S\{0..t\}, it’s not necessary to consider u \in [0..t-1] whether u satisfies S[u] \geq S[j] - K.
If t_1>t and S[t_1]>S[t], it should be saved. t_1 can be a candidate for i in case of S[j]-S[t_1] \geq K.
If existing t_2 that t<t_2<t_1 and S[t_2]>S[t_1], t_2 could be skipped.
Each time visit j, we apply these filtering rules and save positions in another array, let call D.

```C++
int r=0;
D[0]=0;
for (int j=1; j <= n; ++j)
{
    # find i for j and update the result
    # update D with j
    while (r>0 && S[j]<=S[D[r-1]]) --r;
    D[r++]=i;
}
```

S at positions in D is an ascending array, thus (1) and (2) are true. It allows applying moving the pointer to find the optimal value i for j. The complete script is:

```C++
int res=-1;
int l=-1; 
int r=0;
D[0]=0;
for (int j=1; j <= n; ++j)
{
    # find i=q[l] for j and update the result
    while (l<r-1 && S[j]-S[D[l+1]]>=K) ++l;
    if (l>-1 && S[j]-S[D[l]]>=K) 
        res = (res==-1) ? (j-D[l]):min(res, j-D[l]);
    # update D with j
    while (r>0 && S[j]<=S[D[r-1]]) --r;
        l=min(l, r);
    D[r++]=j;
}
```

Every element of S comes in and out the D at most once, therefore the total complexity is O(n).

The technique using D to assist computing is very popular, where D is also called deque. It has two pointers left and right. The left indicates that removing positions which are no longer useful. The right allows updating the deque corresponding to current values of the original array. Previously, I explained in detail this technique and its applying to many problems, to quickly find the min/max of subarrays in O(n) here, but in Vietnamese.

In conclusion, we figure out the simple case of the problem and solve it in O(n). In general, the original array which has both negative and non-negative values, using deque allows us to inherit the solution.


<br>

## Wrapping up



<br>

Thanks for your reading.

<br>

Refer:

[https://langocthuyan.wordpress.com/2020/04/26/shortest-subarray-with-sum-at-least-k/](https://langocthuyan.wordpress.com/2020/04/26/shortest-subarray-with-sum-at-least-k/)