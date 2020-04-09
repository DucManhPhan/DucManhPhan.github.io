---
layout: post
title: Clean code with Exception Handling
bigimg: /img/image-header/california.jpg
tags: [Clean Code]
---

In this article, we will find something out about Clean code with Exception Handling. It is really useful when to utilize in our program. It helps us quickly to find bug ...

Let's get started.

<br>

## Table of contents
- [Catch specific exceptions](#catch-specific-exceptions)
- [Catch block](#catch-block)
- [Finally block](#finally-block)
- [Wrapping up](#wrapping-up)
 
<br>

## Catch specific exceptions
In Java, we have a lot of exceptions, 
- First we should not catch the top-level ```Throwable``` because when encountering exception, we do not know the meanings of this exception. It's hard to fix bug. Instead, we can catch out of memory error or internal error.

- Next, try to avoid catching the general exception as well, at least 90% of the time. We might catch some runtime exception that shouldn't be caught. 

    We should not catch ```NullPointerException```. ```NullPointers``` are not supposed to be caught because they are usually the result of programming errors. So, if we catch and handle ```NullPointers```, then we essentially cover up our own programming mistakes, a bit like sweeping problems under the carpet. That's not a good thing.

    Instead, try our best to prevent nulls as much as possible especially if it's in our own code. But sometimes we have no control whether we get a null from third-party software, so then the second best thing we can do is check for null with an if statement.

    Look at our example:

    ```java
    public static void main(String[] args) {

        // too long
        // We are catching so much exceptions here.
        try {
            readFile();
            executeSqlQuery();
        } catch (FileNotFoundException ex) {
            // handle it
        } catch (IOException e) {
            // handle it
        } catch (SQLException e) {
            // handle it
        }
    }
    ```

    So, to refactor the above code, we can catch only one ```Exception```. but it is not good idea.

    ```java
    // NO!
    // This code just catches one single general exception.
    // As we can see, this is much less code, so it looks like clean code
    // However, it is not advised to do this.
    // Problem: we might end up catching unwanted runtime exception, such as NullPointer
    try {
        readFile();
        executeSqlQuery();
    } catch (Exception ex) {
        // one exception to rule them all
    }
    ```

    So, we can squeeze all exceptions in one single line. But it has downside - we can not tailor our exception message for each. We have to write a more generic message that fits them all.

    ```java
    // Java 7 or latter provides a way to declare all of exceptions in a single line
    // Benefits: fewer lines of code.
    // Downside: we can not tailor our exception message for each. We have to write a more generic message that fits them all.
    try {
        readFile();
        executeSqlQuery();
    } catch (IOException | SQLException ex) {
        // balance - handle in Java 7 way
    }
    ```

    In order to improve above case, we should do not start branching code with if statement like below. Because, that does not bring any benefit compared to the original way of doing it. If we are tempted to do this, because we want to have a specific message for each exception, then we might as well just have a long catch list.

    ```java
    // NO!
    try {
        readFile();
        executeSqlQuery();
    } catch (IOException | SQLException ex) {
        if (ex instanceof IOException) {
            // do something
        }

        if (ex instanceof SQLException) {
            // do something
        }
    }
    ```

![](../img/clean-code/Exceptions/catch-specific-exceptions.png)


<br>

## Catch block

Catch block should not:
- Be empty.
- Have only comments.
- Contain unhelpful code.


Catch block exists on purpose for a reason. So do not leave it empty and do not add comments saying something like this should never happen.

And do not return null.

Ignoring exceptions is bad, but filling it up with code is not helpful.

```java
catch {                         }
catch { 
    // should never happen  
}
catch {         return null;     }
catch {   e.printStackTrace();   }
```

Printing the stack trace or the message of the code exception does not do anything extra. We should have that information anyway. What we want to do instead is log the exception using a logging framework.

The useful things to do inside the catch block is:
- First, log it using a logging framework.

    ```java
    catch {
        log.error(e);
    }
    ```
- Second, just rethrow it and pass all useful information to the exception.

    ```java
    catch {
        throw new CustomException(e);
    }
    ```

<br>

## Finally block

```
Avoid exceptions in finally {}
```

Let's see an example:

```java
public static void main(String[] args) {
    try {
        int result = 1 / 0;     // ArithmeticException (1)
    } finally {
        cleanup();
    }
}

private static void cleanup() {
    throw new IllegalStateException();      // (2)
}
```

So we can find that we have two exception. First, it is an ```ArithmeticException``` exception. Second, it's in ```cleanup()``` method, this method throws ```IllegalStateException``` exception.

When we investigates a bug, it is difficult to know that the cause, because we have two places that leave two exceptions.

Therefore, we need to not throw exception in ```finally``` block.

In Java 7 or higher, we should use ```try-with-resources``` statement, which can handle cleanup for us.

```java
void readFile() {
    try (Scanner scanner = new Scanner(new File("file.txt"))) {
        // read file
    } catch (FileNotFoundException e) {
        // handle it
    }
}
```

<br>

## Wrapping up
- We should catch specific exceptions.
- Proper handling in catch {}.
- Avoid exceptions in finally block and should use Java 7 try-with-resources.


<br>

Thanks for your reading.
