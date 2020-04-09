---
layout: post
title: How do vector work in STL/C++?
bigimg: /img/path.jpg
tags: [C++]
---

## Table of Contents
- [How do vector work in STL/C++ ?](#how-do-vector-work-in-STL/C++)
- [Hidden in vector](#hidden-in-vector)
- [Internally vector works](#internally-vector-works)

<br>

## How do vector work in STL/C++ ?

Vector is the common data structure that is always used in programming language. Because we do not take care about the size of vector. It automatically shrink or expand itself. 

So what is the vector's mechanism?

Before diving into the way to analyse the working of vector. We are going to discover what vector contains. 

<br>

## Hidden in vector

Open with vector file, we have that: 

```C++
template<class _Val_types>
class _Vector_val : public _Container_base
{	// base class for vector to hold data
public:
	...

	_Vector_val() : _Myfirst(),
		            _Mylast(),
		            _Myend()
	{	// initialize values
	}

	pointer _Myfirst;	// pointer to beginning of array
	pointer _Mylast;	// pointer to current end of sequence
	pointer _Myend;	// pointer to end of array
};
```

We can see that vector has three pointer: first, last, end. The way to create vector, I think, it is as same as creating two dimensional array. 

Example: 

```C++
// create two dimensional array.
int** pFakeVector = nullptr; 
const int Row = 10;
const int Col = 10;

pFakeVector = new int*[Row];

for (int i = 0; i < Row; ++i) {
	pFakeVector[i] = new int[Col];
}

// destroy array
for (int i = 0; i < Row; ++i) {
	delete[] pFakeVector[i];
}

delete[] pFakeVector;

// the other way to create two dimensional array
int** pFakeVector = nullptr; 
pFakeVector = new int*[Row];
int* tmp = new int[Row * Col];

for (int i = 0; i < Row; ++i) {
	pFakeVector[i] = tmp + i * Col;
}

// delete array
delete[] pFakeVector[0];
delete[] pFakeVector;

```

So, vector is suitable for inserting elements at the end of array, because vector has a pointer to the end of array. 

So the complexity of inserting element at the end is O(1).

And the complexity of inserting element at the begining of array is O(n) because the vector need to allocate new memory and put the new element at the beginning of vector. 

Inserting at the middle of vector is as same as inserting at the begining of vector. 

<br>

## Internally vector works

In order to allocate new memory for vector, it will compare the value of two variable: capacity and size. 

The size of vector is the number of elements that it contains. 

The capacity of vector is the maximum number of elements that it could contain without having to allocate new memory. 

When capacity is larger than size, you have some steps that vector works:

	- Multiply the vector's capacity with 2. So, allocate memory for the new vector with the capacity that has just been changed. 
  
    - Copy all of elements in the old vector to the new vector. 
  
    - Delete all of elements in the old vector. 

    - Finally, delete this old vector. 


Thanks for your reading.