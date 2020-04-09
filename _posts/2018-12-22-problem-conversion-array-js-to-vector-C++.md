---
layout: post
title: Problem when using push_back() function of vector in v8 or NAN
bigimg: /img/path.jpg
tags: [C++, Node.js]
---


When using the v8 library or NAN for C++ addon modules, you want to convert the array in Node.js to the std::vector in C++. 

## Table of Contents
- [Given problem](#1-given-problem)
- [Solution](#2-solution)

<br>

## 1. Given problem
You will have wrong result in **std::vector** when using the **push_back()** function. 

For example: 

In Javascript, ```arr = [1, 2, 3, 4, 5]```

But the below v8, or NAN, you will have: ```std::vector<int> vect = {0, 0, 0, 0, 0, 1, 2, 3, 4, 5};```

I think that the problem can be caused by the asynchronous of Javascript.

<br>

## 2. Solution
You can use the basic array in C++. 

Code: 

```C++
...

Local<Array> array = Local<Array>::Cast(args[0]);

...

unsigned int length = array->Length();
std::vector<double> vect(length);
double* resArr = new double[length];
for (unsigned int i = 0; i < length; ++i)
{
    if (array->Has(i))
    {
        Local<Value> v = array->Get(i);
        if (!v->IsNumber()) 
        {
            return;
        }

		double value = v->NumberValue();
        vect[i] = value;
        resArr[i] = value;		
    }
	else
	{
		return;
	}
}

```

Thanks for your reading. 