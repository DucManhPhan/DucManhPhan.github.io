---
layout: post
title: How to convert int[] to List<Integer>
bigimg: /img/image-header/yourself.jpeg
tags: [Java]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Arrays utitlity class](#using-arrays-utitlity-class)
- [Using Collections class](#using-collections-class)
- [Using the traditional for loop](#using-the-traditional-for-loop)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

When we work on some projects, or practice coding in LeetCode, sometimes we need to do conversion from `int[]` to `List<Integer>`. This is a tedious task. 

Normally, we will think about `Arrays.asList()` method to convert `int[]` to `List<Integer>`. But this doesn't solve our issue because `asList()` method will return `List<int[]>`.

```java
public class Arrays {
    ...

    public static <T> asList(T... a) {
        return new ArrayList<>(a);
    }

    ...
}
```

So how do we convert `int[]` to `List<Integer>` with elegant solutions?


<br>

## Using Arrays utitlity class

1. Below is the solution that we use `stream()` method of `Arrays` class.

    ```java
    int[] rawData = {1, 3, 5};
    List<Integer> data = Arrays.stream(rawData)     // IntStream
                            .boxed()             // Stream<Integer>
                            .collect(Collectors.toList());
    ```

    The definition of `Arrays.stream()` method is:

    ```java
    public class Arrays {
        ...

        public static IntStream stream(int[] array) {
            return stream(array, 0, array.length);
        }

        ...
    }
    ```

2. Using `forEach()` method to add elements.

    ```java
    int[] rawData = {1, 3, 5};

    List<Integer> data = new ArrayList<Integer>();
    Arrays.stream(rawData).forEach(data::add);
    ```

3. To reduce this version, we can use `IntStream.of()` method.

    ```java
    int[] rawData = {1, 3, 5};
    List<Integer> data = IntStream.of(rawData)      // IntStream
                                .boxed()             // Stream<Integer>
                                .collect(Collectors.toList());
    ```

    Then, we have the definition of `IntStream.of()` method in Java.

    ```java
    public interface IntStream extends BaseStream<Integer, IntStream> {
        ...

        public static IntStream of(int... values) {
            return Arrays.stream(values);
        }

        ...
    }
    ```

4. Using the improved version of `Arrays.stream()` in Java 16+.

    ```java
    List<Integer> data = Arrays.stream(rawData)
                               .boxed()
                               .toList();
    ```


<br>

## Using Collections class

```java
int[] rawData = {1, 3, 5};
List<Integer> data = new ArrayList<Integer>();
Collections.addAll(data, Arrays.stream(rawData).boxed().toArray(Integer::new));
```

Then, below is the definition of `Collections.addAll()` method.

```java
public class Collections {

    ...

    public static <T> boolean addAll(Collection<? super T> c, T... elements) {
        boolean result = false;
        for (T element : elements)
            result |= c.add(element);
        return result;
    }

    ...
}
```

Because the `addAll()` method needs the second arguments as the array of **Integer**. So we will convert the **int[]** to **Integer[]**, then pass it as the argument.


<br>

## Using the traditional for loop

```java
int[] rawData = {1, 3, 5};
List<Integer> data = new ArrayList<Integer>();

for (int num : rawData) {
    data.add(num);
}
```


<br>

## Wrapping up




<br>
