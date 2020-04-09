---
layout: post
title: Cache Memory with Locality of Reference
bigimg: /img/path.jpg
tags: [Memory management]
---

In order to optimize source code, there are so many ways to do it. But using locality of reference is the suitable way to optimize.

In this article, we will find something about Locality of Reference.

<br>

## Table of contents
- [Cache memory](#cache-memory)
- [The types of memory in computer](#the-types-of-memory-in-computer)
- [Definition of Locality of Reference](#definition-of-locality-of-reference)
- [The types of Locality of Reference](#the-types-of-locality-of-reference)
- [How cache memory enhances the processing of computer](#how-cache-memory-enhances-the-processing-of-computer)
- [Example for using cache memory with locality of reference](#example-for-using-cache-memory-with-locality-of-reference)
- [Example for cache pollution](#example-for-cache-pollution)

<br>

## Cache memory

Cache memory is high-speed static random access memory (SRAM) that a computer microprocessor can access more quickly than it can access regular random access memory (RAM).

The purpose of cache memory is to store program instructions and data that are used repeatedly in the operation of programs or information that the CPU is likely to need next. 

The processor can access this information quickly from the cache rather than having to get it from the computer's main memory. 

Fast access to these instructions increases the overall speed of the program. 

The ability of cache memory to improve a computer's performance relies on the concept of the locality of reference. 

<br>

## The types of memory in computer

There are several types of memory. Each type has the strength and weakness. The below image will talk about these. 

![The type of memory](/img/type-memory.png)

<br>

## Definition of Locality of Reference
According to the wikipedia.org, locality of reference, also known as the principle of locality, is a term for the phenomenon in which the same values, or related storage locations, are frequently, depending on the memory access pattern. 

Locality describes various situations that make a system more predictable, such as where the same storage location is repeatedly accessed, creating a pattern of memory access that the cache memory relies upon.

<br>

## The types of Locality of Reference
There are two basic types of locality of reference. 

- Temporal locality
  
  refers to the reuse of specific data and / or resources within relatively small time durations. Access latency can be avoided by reusing the data fetched previously. With poor temporal locality, data that could have been reused is lost from a working area and must be fetched again. Loops over the same small amount of data result in excellent temporal locality.
  
- Spatial locality

  If a particular storage location is referenced at a particular time, then it is likely that nearby memory locations will be referenced in the near future. 

- Sequential locality

  A special case of spatial locality, occurs when elements are arranged and accessed linearly, such as, traversing the elements in one-dimensional array. 

<br>

## How cache memory enhances the processing of computer

Let us take an example to illustrate the role of cache memory in performance enhancement. As we know that CPU execute only one instruction at a time, let consider a situation where 5 instructions are to be executed by the CPU one by one.

Suppose the time needed to bring a instruction to processor from the primary memory is 100ns. (nano-second). Now, to execute 5 instructions, the CPU need 5*100ns=500ns time, when there is no cache memory is used.

Now cache memory is placed in between primary memory and processor, let’s see what happens:

![Locality of Reference](/img/locality-of-reference.png)

When the cache memory is present, suppose it requires 90ns to bring an instruction from primary memory to cache memory and another 20ns is needed to bring that instruction from the cache memory to CPU. So, we found that total time required to bring a single instruction from primary memory to cache memory is 90ns+20ns = 110ns. So, to execute 5 instructions it requires 5*110ns=550ns.

Although the cache memory is used with an aim to enhance the speed, from the above calculations it is cleared that execution time is increased from 500ns to 550ns, which is not great. This is the situation where locality of reference takes place.


The locality of reference is implemented to utilize the full benefit of cache memory in computer organization. It indicates that all the instructions referred by the processor are localized in nature. If the processor searches an instruction ‘i’, the probability is very high that after execution of instruction ‘i‘, it will search for ‘i+1‘. That is a processor request instructions from memory which are residing in memory in nearby locations.


The locality of reference holds good in computer architecture which is utilized to enhance the speed of the cache memory system. If we consider the execution of 5 instructions, with the implemented cache memory and locality of reference, We can bring those 5 instructions simultaneously from primary memory to cache memory only in 90ns.

As a CPU can hold only a single instruction at a time, the time required to bring these 5 instructions from cache to CPU, one after another is 5*20 = 100ns. So, the total time required is 90+100 = 190ns.

This way the cache memory with the locality of reference can enhance the speed of computer system. It is due to the locality of reference, that almost all the instructions fetched from primary memory to cache memory will get executed by the CPU.

<br>

## Example for using cache memory with locality of reference

Example: 
```C++
int sum = 0; 
for (int i = 0; i < n; ++i){
  sum += a[i];
}

return sum;
```

- Data

  - Reference array elements in succession (stride-1 reference pattern): Spatial Locality.
  - Reference *sum* each iteration: Temporal Locality.

- Instructions

  - Reference instructions in sequence: Spatial Locality. 
  - Cycle through loop repeatedly: Temporal Locality.

<br>

## Example for cache pollution

Cache pollution describes situations where an executing computer program loads data into CPU cache unsuccessfully, thus causing other useful data to be evicted from the cache into lower levels of the memory hierarchy, degrading performance. 

Example: 
```
 T[0] = T[0] + 1;
 for i in 0..sizeof(CACHE)
   C[i] = C[i] + 1;
 T[0] = T[0] + C[sizeof(CACHE)-1];
```

Before the loop starts, T[0] will be fetched from memory into cache, its value updated. 

However, as the loop executes, because the number of data elements the loop references requires the whole cache to be filled to its capacity, the cache block containing T[0] has to be evicted. 

Thus, the next time the program requests T[0] to be updated, the cache misses, and the cache controller has to request the data bus to bring the corresponding cache block from the main memory again. 

<br>

Thanks for your reading.

Refer to :

 [https://www.csetutor.com/locality-of-reference-in-cache-memory/](https://www.csetutor.com/locality-of-reference-in-cache-memory/)

 [https://en.wikipedia.org/wiki/Locality_of_reference](https://en.wikipedia.org/wiki/Locality_of_reference)

 [https://en.wikipedia.org/wiki/Cache_pollution](https://en.wikipedia.org/wiki/Cache_pollution)
[https://ivoroshilin.wordpress.com/2013/02/06/know-your-locality-of-reference-some-techniques-for-keeping-data-in-the-cpu-cache/](https://ivoroshilin.wordpress.com/2013/02/06/know-your-locality-of-reference-some-techniques-for-keeping-data-in-the-cpu-cache/)