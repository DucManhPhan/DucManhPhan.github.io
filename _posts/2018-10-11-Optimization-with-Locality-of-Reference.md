---
layout: post
title: Optimization with Locality of Reference
bigimg: /img/path.jpg
tags: [Optimization, Memory management]
---

In the previous article, we had learnt about [Cache memory with Locality of Reference](https://ducmanhphan.github.io/2018-09-20-Locality-of-Reference/). Now, we will utilize the concept of locality to optimize some code in reality.

Before starting optimizing the code, have you remembered that how many types are there in locality of reference?

Basically, there are two types of locality of reference. 
- Temporal Locality: means if the data of element always is utilized repeatedly. Thus, this data will be fetched into cache. 
- Spatial Locality: means the location of the element is used at the particular time. Honestly, processor can call the next location in the near future. 

At the moment, we will dive into the content of optimization with locality of reference. 

Example: 

```C++
const int n = 10000;
struct { double a, b, c; } s[n];
for (int i = 0; i < n; ++i) {
    s[i].a = s[i].b + s[i].c;
}
```

We can see that the struct object s[n] includes three double variable. And in the for loop, the principle of locality can not be used in this case. 

It causes decrease the performance of the program. 

The below codes will fix the weakness of the above problem.

```C++
const int n = 10000;
double a[n], b[n], c[n];
for (int i = 0; i < n; ++i) {
    a[i] = b[i] + c[i];
}
```

Using the rearrangement, "a", "b", and "c" may be processed by array processing instructions that are significantly faster than scalar instructions.


The improved code will be show: 

```C++
const int n = 10000;
double interleaved[n * 3];
for (int i = 0; i < n; ++i) {
    const size_t idx = i * 3;
    interleaved[idx] = interleaved[idx + 1] + interleaved[idx + 2];
}
```


Thanks for your reading. 

Refer: 

[https://en.wikibooks.org/wiki/Optimizing_C%2B%2B/Code_optimization/Faster_operations](https://en.wikibooks.org/wiki/Optimizing_C%2B%2B/Code_optimization/Faster_operations)

