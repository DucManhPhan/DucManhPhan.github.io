---
layout: post
title: Optimizing vector in C++
bigimg: /img/path.jpg
tag: [C++]
---

## Table of Contents
- [Initialize the capacity or the size of vector when knowing about exactly the number of elements or the minimum of elements in vector.](#initialize-the-capacity-or-the-size-of-vector-when-knowing-about-exactly-the-number-of-elements-or-the-minimum-of-elements-in-vector)
- [Should use assignment, or assign(), or insert() when you need to copy the vector's elements to the other vector.](#should-use-assignment-or-assign-or-insert-when-you-need-to-copy-the-vector's-elements-to-the-other-vector)
- [Use move semantic for the temporary variable.](#use-move-semantic-for-the-temporary-variable)
- [Use iterator or subscription of the element, instead of using the at() function.](#use-iterator-or-subscription-of-the-element-instead-of-using-the-at()-function)


## Initialize the capacity or the size of vector when knowing about exactly the number of elements or the minimum of elements in vector. 

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


## Should use assignment, or assign(), or insert() when you need to copy the vector's elements to the other vector. 

<br>

## Use move semantic for the temporary variable. 

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


## Use iterator or subscription of the element, instead of using the at() function.

In order to explain this statement, you can see the function at() of vector file.

```C++
const_reference at(size_type _Off) const
{	// subscript nonmutable sequence with checking
    if (size() <= _Off)
		_Xran();
	return ((*this)[_Off]);
}

reference at(size_type _Off)
{	// subscript mutable sequence with checking
	if (size() <= _Off)
        _Xran();
	return ((*this)[_Off]);
}
```

Before returning the value of element in vector, checking this index can be less than size of vector. 

If the index is invalid, it will throw an object of class std::out_of_range.

Therefore, the cause to decrease the speed of at() function is that call the size() function and check the condition of index of element. 

<br>

Refer to: 

[http://oldhandsblog.blogspot.com/2016/09/c-optimization-bibliography.html](http://oldhandsblog.blogspot.com/2016/09/c-optimization-bibliography.html)

[http://www.acodersjourney.com/2016/11/6-tips-supercharge-cpp-11-vector-performance/](http://www.acodersjourney.com/2016/11/6-tips-supercharge-cpp-11-vector-performance/)
