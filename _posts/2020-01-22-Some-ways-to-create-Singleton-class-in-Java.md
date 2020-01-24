---
layout: post
title: Some ways to create Singleton class in Java
bigimg: /img/image-header/factory.jpg
tags: [Java, Design pattern]
---

In this article, we will find something out about ways to create Singleton class in Java. Before understanding it, we should read up on this [Singleton class](https://ducmanhphan.github.io/2019-10-28-Singleton-Pattern/).

Let's get started.

<br>

## Table of contents
- [Eager Initialization Singleton class](#Eager-Initialization-Singleton-class)
- [Lazy Initialization Singleton class](#Lazy-Initialization-Singleton-class)
- [Thread-safe Singleton class](#Thread-safe-Singleton-class)
- [Double-checking Singleton class](#Double-checking-Singleton-class)
- [Bill Pugh Singleton class](#Bill-Pugh-Singleton-class)
- [Enum Singleton class](#Enum-Singleton-class)
- [Wrapping up](#wrapping-up)

<br>

## Eager Initialization Singleton class

1. Implementation

    - With public final field

        ```java
        public class Singleton {
            public static Singleton instance = new Singleton();

            private Singleton() {}

            // do other things
            // ...
        }
        ```

    - With static factory

        ```java
        public class Singleton {
            private static Singleton instance = new Singleton();

            private Singleton() {}

            public static Singleton getInstance() {
                return instance;
            }

            // do other things
            // ...
        }
        ```

    These versions have the same performance because modern JVM implementations are almost certain to inline the call to the static factory method and the public final field.

2. Benefits and Drawbacks

    - Benefits

        - With public final field

            - The declarations make it clear that the class is a singleton: the public static field is final, so it will always contains the same object reference.

            - The public final field version is simpler than the static factory version.

        - With static factory

            - It gives us the flexibility to change the our mind about whether the class should be a singleton without changing its API.

            - Applying with generic types.            

    - Drawbacks

        - They only work in single-threaded environment.

        - It takes memory because static fields are initialized at class loading time, so an ```instance``` variable is created when our application still do not use it.

        - We still do create many instances of ```Singleton``` class because we can invoke the private constructor reflectively with the aid of the ```AccessibleObject.setAccessible()``` method.

            ```java
            Constructor[] constructors = Singleton.class.getDeclaredConstructors();
            Constructor constructor = constructors[0];
            constructor.setAccessible(true);
            Singleton tmpSingleton = (Singleton) constructor.newInstance(new Object[0]);
            ```

            To solve this problem, we need to modify the constructor of ```Singleton with public final field```'s version or the static method - ```getInstance()``` of ```Singleton with static factory```'s version to make it throw an exception if it's asked to create a second instance.

            ```java
            public class Singleton {
                private static boolean isCreatedInstance = false;

                private static final Singleton instance = new Singleton();

                private Singleton() {
                    if (isCreatedInstance) {
                        throw new IllegalStateException();
                    } else {
                        isCreatedInstance = true;
                    }
                }

                public static Singleton getInstance() {
                    return instance;
                }

                // do other things
                // ...
            }
            ```

<br>

## Lazy Initialization Singleton class

1. Implementation

    ```java
    public class Singleton {

        private static final Singleton instance = null;

        private Singleton() {}

        public static Singleton getInstance() {
            if (Objects.isNull(instance)) {     // Use Objects with Java 7 or later version
                singleton = new Singleton();
            }

            return singleton;
        }

    }
    ```

2. Benefits and Drawbacks

    - Benefits

        - This way prevents the problem about using singleton with static final field when we do not want to create singleton class's instance at class loading time.

        - Exception handling will be used in the method.

    - Drawbacks

        - Only use in single-threaded environment.

        - Reflection attacks.

<br>

## Thread-safe Singleton class

1. Implementation

    ```java
    public class Singleton {

        private static final Singleton instance = null;

        private Singleton() {}

        public static synchronized Singleton getInstance() {
            if (Objects.isNull(instance)) {     // Use Objects with Java 7 or later version
                singleton = new Singleton();
            }

            return singleton;
        }

    }
    ```

    This way will improve the ```Lazy Initialization Singleton class```'s version when it can use in multi-threaded environment.

2. Benefits and Drawbacks

    - Benefits

        - Use in multithread environment.

        - It still has the benefits of ```Lazy Initialization Singleton class```'s version.

    - Drawbacks

        - ```getInstance()``` method is synchronized so it causes slow performance as multiple threads can't access it simultaneously.

<br>

## Double-checking Singleton class

1. Implementation

    ```java
    public class Singleton {

        private volatile static final Singleton instance = null;

        private Singleton() {}

        public static Singleton getInstance() {
            if (Objects.isNull(instance)) {     // Use Objects with Java 7 or later version
                synchronized (Singleton.class) {
                    if (Objects.isNull(instance)) {
                        singleton = new Singleton();
                    }
                }
            }

            return singleton;
        }
    }
    ```

    When we see about this code, we can find that we still have encountered the performance overhead at the first time, only one thread will be entered into the synchronized block of static class, the remained threads will be waited for some times.

    After the first moment, the performance for using Singleton class do not affected by the first null checked condition.

    Note that using ```volatile``` keyword for ```instance``` variable, it will tell the compiler that always to read / write from the main memory, not use CPU cache or local thread stack.

2. Benefits and Drawbacks

    - Benefits

        - Performance overhead gets reduced, so it can be use in high performance multithread environment.

        - Having benefits of ```Thread-safe Singleton class```'s version.

    - Drawbacks

        - At the first time, it can affect performance.

<br>

## Bill Pugh Singleton class

1. Implementation

    ```java
    public class Singleton {
        private Singleton() {}

        public static Singleton getInstance() {
            return BillPughSingleton.instance;
        }

        private static class BillPughSingleton {
            private static final Singleton instance = new Singleton();
        }
    }
    ```

2. Benefits and Drawbacks

    - Benefits

        - Thread safe but does not using synchronized keyword.

        - Lazy initialization.

        - Simple and easy understand.

    - Drawbacks

        - Reflection attacks.

<br>

## Enum Singleton class

1. Implementation

    ```java
    public enum Singleton {
        INSTANCE;

        // other methods
    }
    ```

    According to the [Java Language Specifications](https://docs.oracle.com/javase/specs/jls/se7/html/jls-8.html#jls-8.9), we have:

    ```
    The final clone method in Enum ensures that enum constants can never be cloned, and the special treatment by the serialization mechanism ensures that duplicate instances are never created as a result of deserialization. Reflective instantiation of enum types is prohibited. Together, these four things ensure that no instances of an enum type exist beyond those defined by the enum constants.
    ```

    So, we allegedly get protection against serialization, clone and reflection attacks for free.

2. Benefits and Drawbacks

    - Benefits

        - It is really concise.
        - prevent serialization or reflection attacks.

    - Drawbacks

        - Do not have lazy initialization.
        - Do not inherit from another base class, because enums can not extends another class. If we want to mimic inheritance, we might want to consider the interface mixin pattern in this [New Java 8 "Object Support Mixin Pattern" for overriding Object.equals(), hashCode(), toString() and compareTo()](http://minborgsjavapot.blogspot.com/2014/10/new-java-8-object-support-mixin-pattern.html).

<br>

## Wrapping up






<br>

Refer:

[https://stackoverflow.com/questions/44171031/why-java-singleton-needs-to-prevent-the-reflection-attack](https://stackoverflow.com/questions/44171031/why-java-singleton-needs-to-prevent-the-reflection-attack)

[http://minborgsjavapot.blogspot.com/2015/01/enforcing-java-singletons-is-very-hard.html](http://minborgsjavapot.blogspot.com/2015/01/enforcing-java-singletons-is-very-hard.html)

[https://technonstop.com/java-singleton-reflection-and-lazy-initialization](https://technonstop.com/java-singleton-reflection-and-lazy-initialization)

[https://dzone.com/articles/singleton-bill-pugh-solution-or-enum](https://dzone.com/articles/singleton-bill-pugh-solution-or-enum)

[https://codepumpkin.com/breaking-singleton-using-reflection-and-enum-singleton/](https://codepumpkin.com/breaking-singleton-using-reflection-and-enum-singleton/)

[https://medium.com/@sinethneranjana/5-ways-to-write-a-singleton-and-why-you-shouldnt-1cf078562376](https://medium.com/@sinethneranjana/5-ways-to-write-a-singleton-and-why-you-shouldnt-1cf078562376)

[http://www.tellmehow.co/concept-singleton-class-java-detailed/#how-to-make-singleton-class](http://www.tellmehow.co/concept-singleton-class-java-detailed/#how-to-make-singleton-class)

[https://www.geeksforgeeks.org/java-singleton-design-pattern-practices-examples/](https://www.geeksforgeeks.org/java-singleton-design-pattern-practices-examples/)

<br>

**Concurrency Singleton pattern**

[https://stackoverflow.com/questions/12878012/concurrent-calls-of-singleton-class-methods](https://stackoverflow.com/questions/12878012/concurrent-calls-of-singleton-class-methods)

[https://crunchify.com/thread-safe-and-a-fast-singleton-implementation-in-java/](https://crunchify.com/thread-safe-and-a-fast-singleton-implementation-in-java/)

[https://dzone.com/articles/singleton-patterns-20-years-later](https://dzone.com/articles/singleton-patterns-20-years-later)

[https://www.journaldev.com/171/thread-safety-in-java-singleton-classes-with-example-code](https://www.journaldev.com/171/thread-safety-in-java-singleton-classes-with-example-code)