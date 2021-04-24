---
layout: post
title: Some operators in RxJava 3.x
bigimg: /img/image-header/yourself.jpeg
tags: [Architecture Pattern]
---




<br>

## Table of contents





<br>

## Introduction to Operators in RxJava 3.x

RxJava operators produce observables that are observers of the Observable they are called on. If you call map() on an Observable, the returned Observable will subscribe to it. It will then transform each emission and, in turn, be a producer for observers downstream, including other operators and the terminal Observer itself.




<br>

## Conditional operators

Conditional operators emit or transform Observable conditionally.

1. takeWhile() and skipWhile()

    - **takeWhile()** operator takes emissions while a condition derived from each emission is true. The moment it encounters a condition that is **false**, it will generate the **onComplete** event and dispose of the used resources.

        ```java
        Observable.range(1, 100)
                .takeWhile(i -> i < 5)
                .subscribe(i -> System.out.println(i));
        ```

        Similarly, there is also **takeUntil()** operator that accepts another **Observable** as a parameter. It keeps taking emissions until that other **Observable** pushes an emission.

    - **skipWhile()** operator keeps skipping emissions while they comply with the condition. The moment that condition produces **false**, the emissions start flowing through.

        ```java
        Observable.range(1, 100)
                .skipWhile(i -> i <= 95)
                .subscribe(i -> System.out.println(i));
        ```

        Similarly, there is also **skipUntil()** operator that accepts another Observable as a parameter. It keeps skipping emissions until that other **Observable** emits something.

2. defaultIfEmpty()

    defaultIfEmpty() operator will be used when our source Observalbe can be empty, then without using defaultIfEmpty() we can have nothing to do.


3. switchIfEmpty()

    Similar to defaultIfEmpty() operator, switchIfEmpty() specifies a different Observable to emit values from if the source Observable is empty. This allows us to specify a different sequence of emissions in the event that the source is empty rather than emitting just one value, as in the case of defaultIfEmpty().

    If the preceding Observable is not empty, then switchIfEmpty() will have no effect and that second specified Observable will not be used.

<br>

## Supressing operators

These are operators that suppress emissions that do not meet a specified criterion. These operators work by simply not calling the onNext() function downstream for a disqualified emission, and therefore it doesn't go down the chain to Observer.

Belows are some common suppressing operators.
- filter()


- take()


- skip()


- distinct()


- distinctUntilChanged()


- elementAt()


<br>

## Transforming operators



- map()


- cast()


- startWithItem()


- sorted()


- scan()



<br>

## Reducing operators

- count()


- reduce()


- all()


- any()


- isEmpty()


- contains()


- sequenceEqual()


- 



<br>

## Collection operators


- toList()


- toSortedList()


- toMap() and toMultiMap()



- collect()



<br>

## Error recovery operators


- onErrorReturnItem() and onErrorReturn()


- onErrorResumeWith()


- retry()



<br>

## Action operators


- doOnNext() and doAfterNext()


- doOnComplete() and doOnError()



- doOnEach()


- doOnSubscribe() and doOnDispose()


- doOnSuccess()


<br>

## Utility operators


- delay()


- repeat()


- single()


- timestamp()


- timeInterval()



<br>

## Wrapping up




<br>

Refer:

[Learning RxJava, second edition]()