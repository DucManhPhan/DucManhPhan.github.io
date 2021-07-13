---
layout: post
title: Clean code with Method
bigimg: /img/image-header/yourself.jpeg
tags: [Clean Code]
---

In this article, we will go with Clean code for method. It's very useful to apply knowledges into our projects. It makes our code easily maintainable, readable, ...

Let's get started.

<br>

## Table of contents
- [What (not) to Return](#what-(not)-to-return)
- [Method parameters](#method-parameters)
- [Flag argument](#flag-argument)
- [Fail fast && Return early](#fail-fast-&&-return-early)
- [Refactor duplication](#refactor-duplication)
- [Conditionals and Ternary expressions](#conditionals-and-ternary-expressions)
- [Wrapping up](#wrapping-up)

<br>

## What (not) to Return

1. Avoid returning null as much as possible.

    Example: Assuming that we are in a case that we want to get a list populated from a database or from a file on disk.

    If coping with error, we will return null.

    ```java
    List<String> getSomeData() {
        try {
            // read from DB
        } catch(Exception e) {
            // operation failed
            return null;
        }
    }
    ```

    In the above code, when we want to return null, there are two things that we want:
    - We assume that everyone will know about this internal implementation. But, it's much safer to assume that people do not know something.

        So, if a caller does not know about null, they will hit a ```NullPointerException```. And if someone does know about that null, they have to add extra checks, if list is null. So, we have to write check null every time. Meaning, if we had to call this **getSomeData()** method four or five times, then this extra check has to be applied four or five times.

    Solution for this problem is to return an empty collection such as ```Collections.emptyList()```.

2. Avoid returning special integers that act as error codes.

    ```java
    int withDraw(int amount) {
        if (amount > balance) {
            return -1;
        } else {
            balance -= amount;
            return 0;
        }
    }
    ```

    When we read above code, we see that -1 is a magic number with a magic meaning understandable. It makes other people confused.

    In this case, consider throwing an exception.

    ```java
    void withDraw(int amount) throws InsufficientFundsException {
        if (amount > balance) {
            throw new InsufficientFundsException();
        }

        balance -= amount;
    }
    ```

<br>

## Method parameters

```
Generally, fewer method arguments is better.
```

We need to notice about the number of arguments, because when we have multiple arguments, it always makes us remember them. More arguments means more complexity.

It is really difficult when business logic of method is complicated. So, below is an image to describe the recommended number of argument.

|        OK        |          Avoid             |          Refactor         |
| ---------------- | -------------------------- | ------------------------- |
|     0 - 2        |             3              |            4 +            |

If we have methods with 3+ arguments might:
- do too many things --> should split it.
- take too many primitive types --> pass a single object.
- takes a boolean (flag) argument --> remove it.

Example: We will see that ```nowPlusTime()``` method has 3 arguments, so, we need to refactor this method.

```java
public static void main(String[] args) {
    long millisSinceEpoch = nowPlusTime(0, 0, 4);
    new Order().setExpirationDate(millisSinceEpoch);
}

private static long nowPlusTime(int months, int weeks, int days) {
    return LocalDateTime.now().plusMonth(months)
                        .plusWeeks(weeks)
                        .plusDays(days)
                        .atZone(ZoneId.systemDefault())
                        .toInstant()
                        .toEpochMilli();
}
```

Convert **nowPlusTime()** method:

```java
private static long nowPlusMonths(int months) {
    return now().plusMonths(months)
                .atZone(ZoneId.systemDefault())
                .toInstant()
                .toEpochMilli();
}

private static long nowPlusWeeks(int weeks) {
    return now().plusWeeks(weeks)
                .atZone(ZoneId.systemDefault())
                .toInstant()
                .toEpochMilli();
}

private static long nowPlusDays(int days) {
    return now().plusDays(days)
                .atZone(ZoneId.systemDefault())
                .toInstant()
                .toEpochMilli();
}

// So, we have:
new Order().setExpirationDate(nowPlusDays(4));
```

With above code, we see that our code is WET and not DRY, so, we need to reduce this duplication.

Next, we have another example:

```java
public static void main(String[] args) {
    String greeting = new EmailSender().constructTemplateEmail("Mr.", "John", "Smith");
}
```

So, we need to refactor ```constructTemplateEmail()``` method.

```java
static class Person {

    private String title;
    private String name;
    private String surname;

    Person(String title, String name, String surname) {
        this.title = title;
        this.name = name;
        this.surname = surname;
    }

    String getTitle() {
        return title;
    }

    String getName() {
        return name;
    }

    String getSurname() {
        return surname;
    }
}

public static void main(String[] args) {
    Person john = new Person("Mr.", "John", "Smith");   // need to refactor

    // use builder pattern
    Person john = Person.Builder()
                        .title("Mr.")
                        .name("John")
                        .surname("Smith")
                        .build();

    String greeting = new EmailSender().constructTemplateEmail(john);
}
```


<br>

## Flag Argument

```
Flag arguments are ugly.

It immediately complicates the signature of the method, 
loudly proclaiming that this function does more than one thing.

---
Robert Martin
```

When a method that uses flag argument, we can see that it does not satisfy ```Single Responsibility Principle``` in SOLID. So, we need to split this method into smaller methods.

Example:

First, we will have a method with boolean argument.

```java
void switchLights(Room room, boolean on) {
    if (on) {
        // do something
    } else {
        // do something
    }
}
```


Instead of having a single ```switchLights()``` method, we will create two smaller methods such as ```switchLightsOn(room);``` and ```switchLightsOff(room);```.

<br>

## Fail fast && Return early


|            Fail fast                                    |               Fail safe             |
| ------------------------------------------------------- | ----------------------------------- |
| Immediately report any failure and let the program fail | Try to keep the program running. |

Benefits of fail fast:
- The main reason is faster debugging and troubleshooting, sometimes much faster.

Example with fail safe, we will be difficult to find error when accidently, client fill ```0``` into ```getTotalCompensation()``` method.

```java
public static void main(String[] args) {
    int total = getTotalCompensation(0);
    System.out.println(total);
}

private static int getTotalCompensation(int someBonusVariable) {
    int intermediateResult = getBaseSalary() * someBonusVariable;

    int secondIntermediateResult = convertToLocalCurrency(intermediateResult);

    return getSomeOtherMetric() / secondIntermediateResult;
}
```

Refactor ```getTotalCompensation()``` method, we have:

```java
private static int getTotalCompensation(int someBonusVariable) {
    if (someBonusVariable <= 0) {
        throw new IllegalArgumentException("Variable can not be < 0");
    }

    int intermediateResult = getBaseSalary() * someBonusVariable;

    int secondIntermediateResult = convertToLocalCurrency(intermediateResult);

    return getSomeOtherMetric() / secondIntermediateResult;
}
```

So, we will easily find this bug and fix it.

We can use libraries to check:
- Native Java

    ```java
    Objects.isNull();
    ```

- Guava

    ```java
    Preconditions.checkArgument();
    ```

- Apache

    ```java
    ObjectUtils.isNotEmpty();
    ```

To go the next section - Return early, we can see the below example:

```java
public class Application {

    private boolean systemIsUp;

    public String getPersonalInfo(Person person, int pin) {
        if (systemIsUp) {
            if (person != null && person.getName().equals("")) {
                if (person.getPin() != pin) {
                    return "Invalid pin";
                }

                return "Invalid Name";
            }

            return "System is down at the moment";
        }

        return person.getPersonalInfo();
    }
}
```

The above code is difficult to map which ```if``` statement relates to which ```return``` statement.

To simply this, we need to check for simple conditions first and return immediately.

```java
public String getPersonalInfo(Person person, int pin) {
    if (!systemIsUp) {
        return "System is down at the moment";
    }

    if (person != null && person.getName().equals("")) {
        return "Invalid Name";
    }

    if (person.getPin() != pin) {
        return "Invalid Pin";
    }
}
```

<br>

## Refactor duplication

We always have:

```
Smaller methods mean easier, flexible and reusable code.
```

Example: We will encounter many places that have duplication code such as:

```java
private static long nowPlusMonths(int months) {
    if (months < 0) {
        throw new IllegalArgumentException("Variable can not be < 0");
    }

    return now().plusMonths(months)
                .atZone(ZoneId.systemDefault())
                .toInstant()
                .toEpochMilli();
}

private static long nowPlusWeeks(int weeks) {
    if (weeks < 0) {
        throw new IllegalArgumentException("Variable can not be < 0");
    }

    return now().plusWeeks(weeks)
                .atZone(ZoneId.systemDefault())
                .toInstant()
                .toEpochMilli();
}

private static long nowPlusDays(int days) {
    if (days < 0) {
        throw new IllegalArgumentException("Variable can not be < 0");
    }

    return now().plusDays(days)
                .atZone(ZoneId.systemDefault())
                .toInstant()
                .toEpochMilli();
}
```

Refactor the above segment code, we have:

```java
private static long toEpochMilli(LocalDateTime time) {
    return time.atZone(ZoneId.systemDefault())
               .toInstant()
               .toEpochMilli();

}

private static void checkTimeIsValid(int time) {
    if (time < 0) {
        throw new IllegalArgumentException("Variable can not be < 0");
    }
}

private static long nowPlusMonths(int months) {
    checkTimeIsValid(months);
    return toEpochMilli(now().plusMonths(months));
}

private static long nowPlusWeeks(int weeks) {
    checkTimeIsValid(weeks);
    return toEpochMilli(now().plusWeeks(weeks));
}

private static long nowPlusDays(int days) {
    checkTimeIsValid(days);
    return toEpochMilli(now().plusDays(days));
}
```


<br>

## Conditionals and Ternary expressions

- Boolean checks

    ```java
    if (!doorClosed == false) {
        // nothing to do
    }
    ```

    We do not need to do the above condition. This is completely redundant, so just remove the comparison.

    ```java
    if (!doorClosed) {
        // nothing to do
    }
    ```

    This is better but this does not follow the Boolean naming convention, so let's add prefix.

    ```java
    // This is readable, short, and compliant at the same time
    if (!isDoorClosed) {
        // nothing to do
    }
    ```

    One more guideline is don't be anti-negative. So, we have:

    ```java
    // Right
    if (isDoorOpen) {
        // nothing to do
    }
    ```

    With other example:

    ```java
    public static void main(String[] args) {
        int hour = getHourOfDay();

        if (hour > 6 && hour < 23) {    // need to refactor
            // day time logic
        } else {
            // night time logic
        }
    }

    // Refactor code
    private static boolean isDay(int hour) {
        return hour > 6 && hour < 23;
    }

    public static void main(String[] args) {
        int hour = getHourOfDay();
        if (isDay(hour)) {
            // day time logic
        } else {
            // night time logic
        }
    }
    ```

- Avoid nested ternary expressions

    Example:

    ```java
    String getTitle(Person p) {
        return p.gender == Person.MALE ? "Mr." : p.isMarried() ? "Mr." : "Miss";
    }
    ```

    Refactor: Instead, consider changing it to a pure if-else statement or a mix of if statement and a simple ternary operations. This is more lines of code, but programming is not a competition about how much logic we can stuff into a single line.

    ```java
    String getTitle(Person p) {
        if (p.gender == Person.MALE) {
            return "Mr.";
        } else {
            return p.isMarried() ? "Mrs." : "Miss";
        }
    }
    ```


<br>

## Wrapping up

- Understanding deeply about these above problems and how to solve them.


<br>

Thanks for your reading.

<br>

Refer:

[Java: Writing readable code and maintainable code](https://app.pluralsight.com/library/courses/java-writing-readable-maintainable-code/table-of-contentshttps://www.pluralsight.com/courses/java-writing-readable-maintainable-code)