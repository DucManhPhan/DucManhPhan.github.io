---
layout: post
title: Count number of car failure
bigimg: /img/image-header/factory.jpg
tags: [Two-Pointers]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force solution](#using-brute-force-solution)
- [Using two pointers](#using-two-pointers)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Suppose we have the **a** array that describes the order of cars before going to the tunnel.

```java
n = 5   // the number of cars
a = [3,5,2,1,4]
```

After all cars go out of the tunnel, the order of cars is in the **b** array.

```java
b = [4,3,2,5,1]
```

In the tunnel, we have a rule that each car don't across the other car. So, how many do cars across the other cars?

Constraints of this problem:
- **1 <= n <= 10^5**
- **1 <= a[i] <= 10^5**
- **1 <= b[i] <= 10^5**

Some test cases:

```java
Example 1: 
Input: n = 5
  	   a = [3,5,2,1,4]
  	   b = [4,3,2,5,1]
Output: 2

Example 2:
Input: n = 3 
 	   a = [1,2,3]
       b = [1,2,3]
Output: 0

Example 3:
Input: n = 5
 	   a = [4,3,5,1,2]
       b = [4,5,2,1,3]
Output: 3

Example 4:
Input: n = 5
 	   a = [2,5,3,4,1]
 	   b = [4,1,5,2,3]
Output: 3
```


<br>

## Using brute force solution

In this problem, we need to start using brute force algorithm.
- Using two loops to iterate elements of two arrays - a, b.
- a is the order of cars before going to the tunnel. So a is used as the standard array, and the outer loop.

    b is the order of cars after going out of the tunnel. So b is used to compare with a array.

- To maintain the order to cars in a array with b array, we will use prevIndex to mark an index as the position of **a[prevIndex - 1]** car.


```java
public static int countNumberOfCarsPenalized(int n, int[] a, int[] b) {
    int prevIndex = 0;
    int count = 0;
    
    for (int i = 0; i < n && prevIndex < n; ++i) {
        for (int j = prevIndex; j < n && prevIndex < n; ++j) {
            if (a[i] == b[j]) {
                ++count;
                prevIndex = j + 1;
                break;
            }
        }
    }

    return n - count;
}
```

The complexity of this solution:
- Time complexity: O(n^2)
- Space complexity: O(1)


<br>

## Using two pointers

To improve the time complexity of the brute force algorithm, we will use two pointers technique to deal with it.

Belows are some description for this solution:
- **aPointer**, **bPointer** is pointers that used to iterate the **a**, **b** array.
- Use map to save all penalized cars to reduce the time to search car.
- When the car as **b[bPointer]** is belong to the map, skip it, and go to the next car.

    Otherwise, compare the car at **aPointer** and **bPointer**. If it is equal, increment both **aPointer** and **bPointer**. If not, only increment **bPointer** and save this car in that map to mark it as a penalized car.


```java
public static void main(String[] args) {
		// Test case 1
//		int n = 5;
//		int[] a = {3,5,2,1,4};
//		int[] b = {4,3,2,5,1};
		
		// Test case 2
//		int n = 3;
//		int[] a = {1,2,3};
//		int[] b = {1,2,3};
		
    // Test case 3
    int n = 5;
    int[] a = {4,3,5,1,2};
    int[] b = {4,5,2,1,3};
    
    int res = countNumberOfCarsPenalized(n, a, b);
    System.out.println(res);
}

public static int countNumberOfCarsPenalized(int n, int[] a, int[] b) {
    int aPointer = 0;
    int bPointer = 0;
    Map<Integer, Integer> penalizedCars = new HashMap<>();
    
    while (aPointer < n || bPointer < n) {
        if (penalizedCars.containsKey(a[aPointer])) {
            ++aPointer;
        } else if (a[aPointer] != b[bPointer]) {
            penalizedCars.put(b[bPointer], penalizedCars.getOrDefault(b[bPointer], 0));
            ++bPointer;
        } else {
            ++aPointer;
            ++bPointer;
        }
    }
    
    return penalizedCars.size();
}
```

The complexity of this solution:
- Time complexity: O(n)
- Space complexity: O(1)

<br>

## Wrapping up



<br>

Refer:

[https://codelearn.io/training/detail/263087](https://codelearn.io/training/detail/263087)