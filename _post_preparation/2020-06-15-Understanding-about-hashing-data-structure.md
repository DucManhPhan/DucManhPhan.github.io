---
layout: post
title: Understanding about hashing data structure
bigimg: /img/image-header/yourself.jpeg
tags: [Data structure]
---




<br>

## Table of contents
- [Introduction to hashing data structure](#introduction-to-hashing-data-structure)
- [Hash function](#hash-function)
- [Hash table](#hash-table)


<br>

## Introduction to hashing data structure






<br>

## Hash function

A hash function is basically a function that maps values from a large, and in principle, unbounded domain, we call it the **preimage**, to a smaller and fixed-size domain that's called the image.

![](../img/Algorithm/hashing/hash-function.png)

Clearly, if the **preimage** is larger than the image, some of the values in the **preimage** have to be mapped to the same value in the image if all the **preimage** values were to be mapped. When two or more values from the **preimage** are mapped to the same value in the image, we refer to this as a collision, and in order for a hash function to be useful, we are generally interested in having the smallest possible risk of collisions for the **preimage** values that are relevant for our given scenario.

A hash function could be a mapping from all strings in the world to a set of strings with fixed length.

1. Collisions of hash table with chaining

    The classical way of describing hash tables, namely where collisions are handled by chaining. If the hash function is good enough, that is if it distributes the values to be stored sufficiently, the insertion, lookup, and deletion all takes expected, constant time, or O(1) if we express it in Big O notation.

    ![](../img/Algorithm/hashing/collision-hash-table.png)
    
    Collisions handled by storing all keys with the same value in a chain, for example using a linked list, but in this situation, it is necessary to scan all the elements in the chain in order to find the relevant one. And this effectively gives a horrible worst-case time complexity of O(N) if there are N elements to be inserted in the hash table.

    So, when constructing hash tables, the used hash function should result in a minimum amount of collisions for the set of keys we intend to insert.

    If the hash function gives no collisions at all for a set of keys, we say that the hash function is prefect for that keyset.

2. Throughput property

    In order to be able to operate efficiently on a data stream of large values, it may make sense to squeeze these values down to a smaller size, for example, down to 32-bit integers. This can be achieved by hashing. Of course, this is only feasible for some algorithms that analyzes the distribution of values in a data set or other characteristic that are not directly tied to the actual values. For such scenarios, a key property of the used hash function should be a high throughput and often also that the hash values produced behaves sufficiently random. Similarly when generating a checksum of a file, throughput is clearly also a desired property. The performance of throughput of a hash function depends on the key size and which platform it is run on. 

    ![](../img/Algorithm/hashing/hashing-process.png)

3. Independency property

    Instead of only considering a single hash function, we now consider a whole set of hash functions. Roughly speaking, we want to be able to tell how random the hash values of these functions can be considered.

    ![](../img/Algorithm/hashing/k-independent-1.png)

    So, here are three hash functions, h1, h2, and h3, that map the same colored values to different or possibly different hash values.

    ![](../img/Algorithm/hashing/k-independent-2.png)

    Together we refer to these hash functions as a family. So in this case, our family consists of three hash function, and we now want to tell how dependent or independent the hash functions are. That is, we can deduce the values of one hash function from the values of other hash functions? Some data structure, like the Cuckoo hash table and Bloom filters that utilizes multiple hash functions, that is a family of hash functions, and exploit a high degree of independence in this family in order to provide good performance.

    For indenpendence, we strive for two conditions to be satisfied. First, for each and every key to be mapped, the family of hash functions must map this key uniformly.

    ![](../img/Algorithm/hashing/k-independent-3.png)

    The second condition is on a specific hash function from the family and says that if we choose two or three, or more generally, any k different keys, then the hash values of these k keys should be independent. It should not be possible to deduce one of the hash values from the others. Generally, it's harder for a family of hash functions to have a high degree of independence, so 5 independence is harder to achieve then 2 independence. When these two conditions are satisfied, we can put the label k-independent, for example, 2-independent on the family.

Some languages, including Java and C#, have decided to use a special hash function for integer keys, namely the hash function that maps the key to itself.

For example:

```java
5698 -> 5698
```

The hash function is certainly fast since it involves no operations other than retaining the numbers themselves. The hash function is also perfect, that is two different keys will always map to two different hash values, resulting in no collisions. However, the function is not cryptographic in any sense. Since we can trivially deduce the original value from the hash value, it's the same number. And this hash function does not distribute the keys randomly, leaving it unsuitable for the kind of data structures and algorithm that exploits a random distribution.

![](../img/Algorithm/hashing/hash-implementation-oulier.png)

Another approach to build a hash value is the so-called Merkle-Damgard construction, which is the typical approach used for larger keys. A Merkle-Damgard construction starts with an initial C value and initial state say state 0. Then for each few byte chunk of the key, a new state is built by mixing the previous state and the current chunk using a set of operations that is specific for the hash function. Typically, it is a mix of multiplication, XR, and bit shifting.

    If the length of the key is not a whole multiplier of the chunk size, there will be some leftover bits in the end of the key. These are handled in a final step, and the final hash value is then found in the last and final state.

<br>

## Hash table

1. Linear probing



2. Robin Hood hashing



3. Cuckoo hashing



<br>

## Wrapping up




<br>

Refer:

