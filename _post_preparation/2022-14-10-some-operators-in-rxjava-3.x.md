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

These operators don't modify the Observable, but use it for side effect such as debugging as well as getting visibility into an Observable chain.

Belows are some action operators that we need to know.
- doOnNext() and doAfterNext()

    - doOnNext() operator allows a peek at each received value before letting it flow into the next operator. It doesn't affect the processing or transform the emission in any way. We can use it just to create a side effect for each received value.

    - doAfterNext() operator performs the action after the item is passed downstream rather than before.

        It means that the action of doAfterNext() operator will be processed after the Observer completely finishes.


- doOnComplete() and doOnError()

    - doOnComplete() operator

        The onComplete() operator allows us to fire off an action when an onComplete event is emitted at the point in the Observable chain. This can be helpful in seeing which points of the Observable chain have completed.

    - doOnError() operator

        The onError() will peek at the error being emitted up the chain, and we can perform an action with it. This can helpful to put between operators to see which one is to blame for an error.

- doOnEach()

    **doOnEacḥ()** operator is similar to **doOnNext()**.

    The only difference is that in **doOnEach()**, the emitted item comes wrapped inside a **Notification** that also contains the type of the event. This means we can check which of the three events - **onNext()**, **onComplete()**, or **onError()** has happened and select an appropriate action.

    The **subscribe()** method accepts these three actions as lambda arguments or an entire **Observer<T>**. So, using **doOnEach()** is like putting **subscribe()** right in the middle of our **Observable** chain.

    The error and the value (the emitted item) can be extracted from Notification in the same way.

    ```java
    Observable.just("One", "Two", "Three")
              .doOnEach(s -> System.out.println("doOnEach: " + 
                             s.getError() + ", " + s.getValue()))
              .subscribe(i -> System.out.println("Received: " + i));
    ```

- doOnSubscribe() and doOnDispose()

    - doOnSubscribe(Consumer<Disposable> onSubscribe) executes the function provided at the moment subscription occurs. It provides access to the Disposable object in case we want to call dispose() in that action.

    - doOnDispose(Action onDispose) operator performs the specified action when diposal is executed. To dispose a Subscription or a stream internally in Observable-Observer, call dispose() method immediately.

    We use both operators to print when subscription and disposal occur, then the emitted values go through, and then disposal is finally fired.

    Another option is to use the doFinally() operator, which will fire after either onComplete() or onError() is called or disposed of by the chain.

- doOnSuccess()

    Maybe and Single types don't have an onNext() event, but rather an onSucess() operator to pass a single emission. The doOnSuccess() operator usage should effectively feel like doOnNext().

- doFinally()

    The doFinally() operator is executed when onComplete(), onError(), or disposal happens. It is executed under the same conditions as doAfterTerminate(), plus it is also executed after the disposal.

    The doFinally() operator guarantees that the action is executed exactly once per subscription. And, by the way, the location of these operators in the chain does not matter, because they are driven by the events, not by the emitted data.

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

[https://rxmarbles.com/#merge](https://rxmarbles.com/#merge)