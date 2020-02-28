---
layout: post
title: Understanding about Numpy
bigimg: /img/image-header/yourself.jpeg
tags: [Numpy, Python]
---




<br>

## Table of contents
- [Introduction to Numpy](#introduction-to-numpy)
- 



<br>

## Introduction to Numpy






<br>

## Math



<br>

## Random




<br>

## Indexing





<br>

## Filtering





<br>

## Statistics





<br>

## Aggregation




<br>

## Saving Data





<br>

## Common methods use for ML

1. Create matrix with elements are 1

    ```python
    X0 = np.array([[2], [7], [9], [3], [10], [6], [1], [8]])
    ones = np.ones_like(X0)
    ```



2. Combine two matrix

    ```python
    X0 = np.array([[2], [7], [9], [3], [10], [6], [1], [8]])
    ones = np.ones_like(X0)

    X = np.concatenate((X0, ones), axis=1)
    ```

3. Some element wise operations with matrix

    - Square for each element

        ```python
        import numpy as np

        arr = [1, 2, 4, 6]
        print("Square values of arr: ", np.square(arr))
        ```
    
    - Multiply each element of matrixes with other

        ```python
        import numpy as np
        a = np.array([[1,2],[3,4]])
        b = np.array([[5,6],[7,8]])
        np.multiply(a,b)
        ```

        We should use **array** instead of **matrix**. **matrix** objects have all sorts of horrible incompatibilities with regular ndarrays. With **ndarrays**, you can just use * for elementwise multiplication:

        ```Python
        a * b

        # In Python 3.5, we can use @ operator to do matrix multiplication
        a @ b
        ```

<br>

## Wrapping up




<br>

Refer:

