---
layout: post
title: Some interview questions about ExceptionHandling
bigimg: /img/path.jpg
tags: [Java, Interview question]
---



<br>

1. What occurs when a method uses an otherwise valid return value to indicate failure?

    A. An exception
    B. The semipredicate problem
    C. A run-time error
    D. A compile-time error

    Solution: B

<br>

2. What is the structure used by Java that stores information, like where a catch block is located and the range over which it applies?

    Solution: Exception Table



<br>

3. Which of these classes is a checked exception?

    A. NumberFormatException
    B. ThreadDeath
    C. ClassNotFoundException
    D. NoClassDefFoundError

    Solution: C



<br>

4. Which of the following classes is a direct subclass of RuntimeException?

    A. ArrayIndexOutOfBoundsException
    B. IllegalArgumentException
    C. LinkageError
    D. IllegalAccessException

    Solution: B


<br>

5. In which of the following situations will the compiler generate an error?

    A. Mixing subclasses and superclasses in a throws clause.
    B. Don't having at least one catch block after a try block.
    C. Catching an checked exception that is not thrown in a try block.
    D. Downcasting an instance of Exception to an incorrect type (E.g. RuntimeException re = (RuntimeException)e;)

    Solution: C

<br>

6. What could be an advantage of using checked exceptions?

    A. Checked exceptions help document a method.
    B. Checked exceptions encourage less cluttered code.
    C. Checked exceptions can expose implementation details.
    D. Checked exceptions are invisible.

    Solution: A.


<br>

7. The following exception represents a bad designed exception:

    A. FileNotFoundException
    B. Exception
    C. UncheckedIOException
    D. SQLException

    Solution: D


8. When an error conditions almost never happens, which exception type is recommended?

    A. Error
    B. Unchecked
    C. Checked

    Solution: B

9. Which of the following is easier to ignore?

    A. A compile-time exception
    B. A run-time exception
    C. An error code

    Solution: C

<br>

10. Which instances of this class are treated as unchecked exceptions?

    A. Throwable
    B. Error
    C. Exception

    Solution: B

11. Resources declared in a try-with-resources block must implement which interface?

    A. java.io.Serializable
    B. java.lang.Closeable
    C. java.lang.Runnable
    D. java.lang.AutoCloseable

    Solution: D

<br>

## Wrapping up







<br>

Refer:

[pluralsight.com](pluralsight.com)