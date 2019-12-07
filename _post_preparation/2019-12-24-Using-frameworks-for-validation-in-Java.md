---
layout: post
title: Using frameworks for validation in Java
bigimg: /img/image-header/california.jpg
tags: [Clean code]
---



<br>

## Table of contents




<br>

## Summary information about frameworks
- Use native Java

    In Java 1.7 and version later, we are supported to validate method's inputs based on [Objects](https://docs.oracle.com/javase/8/docs/api/java/util/Objects.html) class.

- Use Guava & Apache




- Use Hamcrest & AssertJ


<br>

## Native Java
```Objects``` class provides some useful methods for us to validate method's inputs.
1. For object
- ```equals()```

    ```java
    public static boolean equals(Object a, Object b);
    ```

    - Return true if two arguments are equal, otherwise, return false.
    - Both arguments are null, return true.
    - If one of them is null, return false.
    - Correspond to this code:

        ```java
        public static boolean equals(Object a, Object b) {
            // Check conditions

            return a.equals(b);
        }
        ```


- ```deepEquals()```

    ```java
    public static boolean deepEquals(Object a, Object b);
    ```

    - Both arguments are deeply equal, then return true, otherwise false.
    - Both arguments are arrays, use ```Arrays.deepEquals()``` method to determine quality.

- ```isNull()```

    ```java
    // 1.8
    public static boolean isNull(Object o);
    ```

    - Return true if the argument is null, otherwise false.

- ```nonNull()```

    ```java
    // 1.8
    public static boolean nonNull(Object o);
    ```

    - Return true if the argument is non-null, otherwise false.

- ```requireNonNull()```

    ```java
    public static <T> T requireNonNull(T obj);

    public static <T> T requireNonNull(T obj, String message);
    ```

    - This method is designed primarily for doing parameter validation in methods and constructors.
    - Throw ```NullPointerException``` exception when the argument is null.

- ```requireNonNullElse()```

    ```java
    // 9
    public static <T> T requireNonNullElse(T obj, T defaultObj);

    // 9
    public static <T> T requireNonNullElseGet(T obj, Supplier<? extends T> supplier);
    ```

    - Return the first argument if it is non-null.
    - Otherwise returns ```defaultObj``` or ```supplier``` the non-null second arguement.
    - Throws ```NullPointerException``` exception when both ```obj``` and ```defaultObj``` or ```suplier``` or ```supplier.get()``` value is null.

2. For array
- ```checkIndex()```

    ```java
    // 9
    public static int checkIndex(int index, int length);
    ```

    - Checks if the ```index``` is within the bounds of the range from 0 (inclusive) to ```length``` (exclusive).
    - Throws ```IndexOutOfBoundsException``` - if the index is out-of-bounds.

- ```checkFromToIndex()```

    ```java
    // 9
    public static int checkFromToIndex(int fromIndex, int toIndex, int length);
    ```

    - Checks if the sub-range from ```fromIndex``` (inclusive) to ```toIndex``` (exclusive) is within the bounds of range from 0 (inclusive) to ```length``` (exclusive).
    - Throws ```IndexOutOfBoundsException``` - if the sub-range is out-of-bounds.

- ```checkFromIndexSize()```

    ```java
    public static int checkFromIndexSize(int fromIndex, int size, int length);
    ```

    - Checks if the sub-range from ```fromIndex``` (inclusive) to ```fromIndex + size``` (exclusive) is within the bounds of range from 0 (inclusive) to ```length``` (exclusive).
    - Throws ```IndexOutOfBoundsException``` - if the sub-range is out-of-bounds.

<br>

## Guava & Apache framework





<br>

## Hamcrest & AssertJ





<br>

## Wrapping up



<br>

Thanks for your reading.

<br>

Refer:

