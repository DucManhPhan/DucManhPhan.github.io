---
layout: post
title: Signaling Pattern
bigimg: /img/image-header/factory.jpg
tags: [Concurrency Pattern]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- []
- [Using synchronization](#)
- []()


<br>

## Given problem






<br>

## Solution of Signaling pattern





<br>

## When to use






<br>

## Benefits and Drawbacks



<br>

## Source code

1. Using synchronization


```java
public class SignalingPattern {
	
	private static Object lock = new Object();
	
	public static void main(String[] args) throws InterruptedException {
		Thread firstTask = new Thread(() ->  {
			synchronized (lock) {
				try {
					System.out.println("Task 1 is running");
					Thread.sleep(1000);
					
					lock.notify();
				} catch (InterruptedException e) {
					System.out.println(e);
				}
			}
		});
		
		Thread secondTask = new Thread(() -> {
			synchronized (lock) {
				try {
					lock.wait();

					System.out.println("Task 2 is running");
//					Thread.sleep(5000);
				} catch (InterruptedException e) {
					System.out.println(e);
				}
			}
		});
		
		secondTask.start();
		Thread.sleep(100);
		
		firstTask.start();

		firstTask.join();
		secondTask.join();
	}
	
}
```




2. Using ReentrantLock






3. Using Semaphore





<br>

## Wrapping up






<br>

Refer:

[]()
