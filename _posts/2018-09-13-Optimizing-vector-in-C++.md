---
layout: post
title: Optimizing vector in C++
---

1. Initialize the capacity or the size of vector when knowing about exactly the number of elements or the minimum of elements in vector. 

```C++
std::vector<int> vecStudent;
vecStudent.reserve(100);
```

or 

```C++
std::vector<int> vecStudent(100);
```

Because the pitfall of vector is reallocate memory of all elements when capacity < size. 
This memory reallocation takes so much time. There are many steps to reallocate old elements to the new memory. 
    - Multiply the vector's capacity with 2. So, allocate memory for the new vector with the capacity that has just been changed. 
    - Copy all of elements in the old vector to the new vector. 
    - Delete all of elements in the old vector. 
    - Finally, delete this old vector. 


2. Should use assignment, or assign(), or insert() when you need to copy the vector's elements to the other vector. 


3. Use move semantic for the temporary variable. 

Consider the below example: 

```C++
std::vector<int> vecScores;
...

int size = vecScores.size();
for (int i = 0; i < size; ++i) {
    vecScores.push_back(std::move(i));
}
```

When use std::move() function, you do not have to make the copy of the variable, pass the ownership the variable directly into vector. 

The state of the variable will become undefine, it can not be accessed. 


4. Use interator or subscription of the element, instead of using the at() function.




Refer to: 
[http://oldhandsblog.blogspot.com/2016/09/c-optimization-bibliography.html](OldHandsBlog)

[http://www.acodersjourney.com/2016/11/6-tips-supercharge-cpp-11-vector-performance/](AcodersJourney)
