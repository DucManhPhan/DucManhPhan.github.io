---
layout: post
title: How to use exception handling in Java
bigimg: /img/image-header/factory.jpg
tags: [Java]
---



<br>

## Table of contents
- [Introduction to Exception Handling](#introduction-to-exception-handling)
- [How exception handling works](#how-exception-handling-works)
- [try-catch block and throw(s) statement](#try-catch-block-and-throw(s)-statement)
- [finally block](#finally-block)
- [Best practices for utilizing Exception handling](#best-practices-for-utilizing-exception-handling)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Common problems with exception handling](#common-problems-with-exception-handling)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to Exception Handling

1. Exception handling's concept



2. The hierarchy of Exception handling

    ![](../img/Java/exception-handling/hierarchy-exceptions.png)

    Some types of Exceptions in Java:
    - Checked exceptions

        Checked exceptions that extends **Exception** class.
        - They must be handled or declared.
        - They can be thrown by the programmer or by the JVM.

        Some common checked exceptions:
        - **FileNotFoundException**

            Thrown programmatically when code tries to reference a file that does not exist.

        - **IOException**

            Thrown programmatically when there's a problem reading or writing a file.

    - Unchecked exceptions

        All unchecked exceptions that extend from **RuntimeException**.
        - They don't have to be handled or declared.
        - They can be thrown by the programmer or by the JVM.

        Some common unchecked exceptions:
        - **ArithmeticException**
            
            thrown by the JVM when code attempts to divide by zero.

        - **ArrayIndexOutOfBoundsException**
            
            thrown by the JVM when code uses an illegal index to access an array.

        - **ClassCastException**
        
            thrown by the JVM when an attempts is made to cast an exception to a subclass of which it is not an instance.

        - **IllegalArgumentException**
            
            thrown by the programmer to indicate that a method has been passed an illegal or inappropriate argument.

        - **NullPointerException**
        
            thrown by the JVM when there is a null reference where an object is required.

        - **NumberFormatException**
        
            thrown by the programmer when an attempt is made to convert a string to a numeric type but the string doesn't have an appropriate format.

<br>

## How exception handling works




<br>

## try-catch block and throw(s) statement

1. try block

    - Java uses a **try** statement to seperate the logic that might throw an exception from the logic to handle that exception.
    - The code in the **try** block is run normally. If any of the statements throw an exception that can be caught by the exception type listed in the **catch** block, the **try** block stops running and execution goes to the **catch** statement.
    - **try** statements are like methods in the curly braces are required even if there is only one statement inside the code blocks.
    - **try** keyword must be accompanied with **catch** blocks. Without using any catch blocks, our code does not compile.

    Syntax: 

    ```java
    try {
        // statements
        // ...
    } catch(exception_type identifier) {
        // do something
    }
    ```

2. catch block

    - If we have multiple catch blocks, at most one catch block will run and it will be the first catch block that can handle it.

    - In the **catch**/**finally** block, we can use **try** statement in it.

3. throw(s) statement

    - The **throws** keyword is used in a method declaration to indicate an exception might be thrown. When overriding a method, the method is allowed to throw fewer exceptions than the original version.

    - The **throw** keyword is used when we actually want to throw an exception.

    Some problems that related to the subclass:
    - When a class overrides a method from a superclass or implements a method from an interface, it's not allowed to add new checked exceptions to the method signature.

        For example:

        ```java

        ```

    - A subclass is allowed to declare fewer exceptions than the superclass or interface.

        For example:

        ```java

        ```
        
<br>

## finally block

```finally``` block will be called after the execution of the ```try``` or ```catch``` code blocks. Normally, **finally** block is typically used to close resources such as files or databases.

The only times ```finally``` won't be called are:
- If you invoke ```System.exit()```.
- If you invoke ```Runtime.getRuntime().halt(exitStatus)```.
- If the JVM crashes first.
- If the JVM reaches an infinite loop (or some other non-interruptable, non-terminating statement) in the ```try``` or ```catch``` block.
- If the OS forcibly terminates the JVM process; e.g., ```kill -9 <pid>``` on UNIX.
- If the host system dies; e.g., power failure, hardware error, OS panic, et cetera.
- If the ``finally`` block is going to be executed by a daemon thread and all other non-daemon threads exit before ```finally``` is called.

Syntax:

```java
try {
    // statements
    // ...
} catch(exception_type identifier) {
    // do something
} finally {
    // do something
}
```

<br>

## Best practices for utilizing Exception handling

- 

- 

<br>

## Benefits and Drawbacks

1. Benefits

    - Using exceptions makes our code easy to read, and tracking.

2. Drawbacks

    - Over-use exceptions can reduce the performance of system, create boilerplate code.

        Solution for this case is to use Defensive programming.

<br>

## Common problems with exception handling

1. Why is ```exception.printStackTrace()``` considered bad practice?

    [https://stackoverflow.com/questions/7469316/why-is-exception-printstacktrace-considered-bad-practice](https://stackoverflow.com/questions/7469316/why-is-exception-printstacktrace-considered-bad-practice)

    [https://stackoverflow.com/questions/10477607/avoid-printstacktrace-use-a-logger-call-instead](https://stackoverflow.com/questions/10477607/avoid-printstacktrace-use-a-logger-call-instead)

2. Take carefully when throwing exception from **finally** block

    For example:

    ```java
    try {
        throw new RuntimeException();
    } catch(RuntimeException ex) {
        throw new RuntimeException();
    } finally {
        throw new Exception();
    }
    ```

    In the try block, we throw a **RuntimeException**, then catch block will receive this exception. But in the **catch** block, it still throws **RuntimeException**. Then, the **finally** block would be executed, but a **RuntimeException** from the catch block will be ignored because the **finally** block also throws an exception.

    So, we can use **try/catch** blocks inside a **finally** block to make sure it doesn't mask the exception from the **catch** block.

<br>

## Wrapping up

- Understanding how an exception works in Java, and some best practice to use it.

<br>

Refer:

[OCA - Oracle Certified Associate Java SE 8 Programmer I - Study Guide ebook]()

[Data structure and Algorithms in Java, 6th Edition ebook]()

[Functional programming in Java - How functional techniques improve ebook]()

[https://stackoverflow.com/questions/2190161/difference-between-java-lang-runtimeexception-and-java-lang-exception](https://stackoverflow.com/questions/2190161/difference-between-java-lang-runtimeexception-and-java-lang-exception)

[https://www.mkyong.com/java/java-custom-exception-examples/?utm_source=mkyong.com&utm_medium=Referral&utm_campaign=afterpost-related&utm_content=link9](https://www.mkyong.com/java/java-custom-exception-examples/?utm_source=mkyong.com&utm_medium=Referral&utm_campaign=afterpost-related&utm_content=link9)

[https://stackoverflow.com/questions/65035/does-a-finally-block-always-get-executed-in-java](https://stackoverflow.com/questions/65035/does-a-finally-block-always-get-executed-in-java)

[https://docs.oracle.com/javase/specs/jls/se8/html/jls-14.html#jls-14.17](https://docs.oracle.com/javase/specs/jls/se8/html/jls-14.html#jls-14.17)

[http://www.informit.com/articles/article.aspx?p=1216151&seqNum=7](http://www.informit.com/articles/article.aspx?p=1216151&seqNum=7)
