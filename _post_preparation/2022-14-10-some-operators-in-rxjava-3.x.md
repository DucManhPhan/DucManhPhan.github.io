---
layout: post
title: Some operators in RxJava 3.x
bigimg: /img/image-header/yourself.jpeg
tags: [Reactive Programming]
---




<br>

## Table of contents
- [Introduction to Operators in RxJava 3.x](#introduction-to-operators-in-rxjava-3.x)
- [Conditional operators](#conditional-operators)
- [Supressing operators](#supressing-operators)
- [Transforming operators](#transforming-operators)
- [Reducing operators](#reducing-operators)
- [Collection operators](#collection-operators)
- [Error recovery operators](#error-recovery-operators)
- [Action operators](#action-operators)
- [Utility operators](#utility-operators)
- [Wrapping up](#wrapping-up)


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

    The map() operator transforms an emitted value of the T type into a value of the R type using the Function<T, R> lambda expression provided. The map() operator does a one-to-one conversion of each emitted value. If we need to do a one-to-many conversion, we can use flatMap() or concatMap().

- cast()

    cast() operator will cast each emitted item to another type. The cast() operator received the class type as an argument.

    If we find that we are having typing issues due to inherited or polymorphic types being mixed, this is an effective brute-force way to cast everything down to a common base type, but strive to use generics properly and type wildcards appropriately first.

- startWithItem()

    - The startWithItem() operator (in RxJava 2.x, it is called as startWith() operator) allows us to insert a value of type T that will be emitted before all the other values.

        The startWithItem() operator is helpful for cases like where we want to seed an initial value or precede our emissions with one particular value.

    - startWithArray() and startWithIterable() 

        If we want to start with more than one value emitted first, use **startWithArray()** or startWithIterable() operators, which accepts **varargs** or a Collection.

    If we want emissions of one Observable to precede the emissions of another Observable, use Observable.concat() or concatWith().

- sorted()

    If we have a finite Observable<T> that emits items that are of a primitive type, String type, or objects that implement Comparable<T>, we can use sorted() to sort the emissions. Internally, it collects all the emissions and then re-emits them in the specified order. 

    Of course, this can have some performance implications and consumes the memory as it collects all emitted values in memory before emitting them again. If you use this against an infinite Observable, you may even get an OutOfMemoryError exception.

    The overloaded version, sorted(Comparator<T> sortFunction), can be used to establish an order other than the natural sort order of the emitted items that are of a primitive type. This overloaded version, sorted(Comparator<T> sortFunction), can also be used to sort the emitted items that are objects that do not implement Comparable<T>. 

    Since Comparator is a single abstract method interface, you can implement it quickly with a lambda expression. Specify the two parameters representing two emissions, T o1 and T o2, and then implement the Comparator<T> functional interface by providing the body for its compare(T o1, T o2) method. For instance, we can sort the emitted items not according to their implementation of the compareTo(T o) method (that is, the Comparable<T> interface), but using the comparator provided.

- scan()

    The scan() method is a rolling aggregator. It adds every emitted item to the provided accumulator and emits each incremental accumulated value. 

    This operator does not have to be used just for rolling sums. You can create many kinds of accumulators, even non-math ones such as String concatenations or boolean reductions.

    scan() operator is very similar to reduce(). The scan() operator emits the rolling accumulation for each emission, whereas reduce() yields a single result reflecting the final accumulated value after onComplete() is called. This means that reduce() has to be used with a finite Observable only, while the scan() operator can be used with an infinite Observable too.

    You can also provide an initial value for the first argument and aggregate the emitted values into a different type than what is being emitted. If we wanted to emit the rolling count of emissions, we could provide an initial value of 0 and just add 1 to it for every emitted value. Keep in mind that the initial value would be emitted first, so use skip(1) after scan() if you do not want that initial emission to be included in the accumulator.

<br>

## Reducing operators

When we need to take a series of emitted values and aggregate them into a single value (usually emitted through a Single). And all of these reducing operators only work on a finite Observable that calls onComplete() because we can aggregate only finite datasets.

- count()

    The count() operator counts the number of emitted items and emits the result through a Single once onComplete() is called. Like most reduction operators, this should not be used on an infinite Observable. It will hang up and work indefinitely, never emitting a count or calling onComplete(). If we need to count emissions of an infinite Observable, using scan() operator to emit a rolling count instead.

- reduce()

    The reduce() operator is syntactically identical to scan(), but it only emits the final result when the source Observable calls onComplete(). Depending on which overloaded version is used, it can yield Single or Maybe. If you need the reduce() operator to emit the sum of all emitted integer values, for example, you can take each one and add it to the rolling total. But it will only emit once—after the last emitted value is processed (and the onComplete event is emitted)

    Similar to scan(), there is a seed argument that you can provide that will serve as the initial value to accumulate on.

Belows are some boolean operators that we can usually use.
- all()

    The all() operator verifies that all emissions meet the specified criterion and returns a Single<Boolean> object. If they all pass, it returns the Single<Boolean> object that contains true. If it encounters one value that fails the criterion, it immediately calls onComplete() and returns the object that contains false.

    If we call all() operator on an empty Observable, it will emit true due to the principle of vacuous.

- any()

    The any() method checks whether at least one emission meets a specified criterion and returns a Single<Boolean>. The moment it finds an emission that does, it returns a Single<Boolean> object with true and then calls onComplete(). If it processes all emissions and finds that none of them meet the criterion, it returns a Single<Boolean> object with false and calls onComplete().

- isEmpty()

    The isEmpty() operator checks whether an Observable is going to emit more items. It returns a Single<Boolean> with true if the Observable does not emit items anymore.

- contains()

    The contains() operator checks whether a specified item (based on the hashCode()/equals() implementation) has been emitted by the source Observable. It returns a Single<Boolean> with true if the specified item was emitted, and false if it was not.

- sequenceEqual()

    The sequenceEqual() operator checks whether two observables emit the same values in the same order. It returns a Single<Boolean> with true if the emitted sequences are the same pairwise.


<br>

## Collection operators

A collection operator accumulates all emissions into a collection such as a List or Map and then returns that entire collection as a single value. It is another form of a reducing operator since it aggregates emitted items into a single one.

- toList()

    The toList() is probably the most often used among all the collection operators. For a given Observable<T>, it collects incoming items into a List<T> and then pushes that List<T> object as a single value through Single<List<T>.

    By default, toList() uses an ArrayList implementation of the List interface. You can optionally specify an integer argument to serve as the capacityHint value that optimizes the initialization of the ArrayList to expect roughly that number of items.

    If you want to use a different List implementation, you can provide a Callable function as an argument to specify one.

- toSortedList()

    A different flavor of toList() operator is toSortedList(). It collects the emitted values into a List object that has the elements sorted in a natural order (based on their Comparable implementation). Then, it pushes that List<T> object with sorted elements into the Observer.

    As with the sorted() operator, you can provide a Comparator as an argument to apply a different sorting logic. You can also specify an initial capacity for the backing ArrayList, just like in the case of the toList() operator.

- toMap() and toMultiMap()

    - toMap() operator

        For a given Observable<T>, the toMap() operator collects received values into Map<K,T>, where K is the key type. The key is generated by the Function<T,K> function provided as the argument.

        If we decide to yield a different value other than the received one to associate with the key, we can provide a second lambda argument that maps each received value to a different one.

    - toMultiMap() operator

        If we want a given key to map to multiple values, use toMultiMap() instead, which maintains a list of corresponding a list of corresponding values for each key.

- collect()

    When none of the collection operators can do what you need, you can always use the collect() operator to specify a different type to collect items into.

    When you need to collect values into a mutable object and you need a new mutable object seed each time, use collect() instead of the reduce() operator.

<br>

## Error recovery operators

To handle exceptions in the chain of the Observable operators, use onError event that is communicated down the Observable chain to the Observer. After that, the subscription terminates and no more emissions occur. But in fact, we still want to intercept exceptions before they get to the Observer and attempt some form of recovery.

- onErrorReturnItem() and onErrorReturn()

    - onErrorReturnItem() operator is used when we want to resort to a default value if an exception occurs.

        The emissions stopped after the error anyway, but the error itself didn't flow down to the Observer. Instead, the default value was received by it as if emitted by the source Observable.

    - onErrorReturn(Function<Throwable, T> valueSupplier) operator is used to dynamically produce the value using the specified function. This gives us access to a Throwable object, which we can use while calculating the returned value.

        We also take care about the location of onErrorReturn() operator in the chain of the operators matters. If we put it before the operator that doesn't throw an exception, the error wouldn't be caught because it happened downstream. To intercept the emitted error, it must originate upstream from the onErrorReturn() operator.

    onErrorReturnItem() and onErrorReturn() operators happened, then the emissions will be terminated because onError event was pushed from Observable to Observer. So, the remaining items doesn't emit to the Observer. If we want to resume emissions, we can handle the error by using try/catch within the operators where the error occurs.

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

    We can postpone emissions using the delay() operator. It will hold any received emissions and delay each one for the specified time period.

    For more advanced cases, we can pass another Observable as your delay() argument, and this will delay emissions until that other Observable emits something.

- repeat()

    The repeat() operator will repeat subscription after onComplete() a specified number of times. If you do not specify a number, it will repeat infinitely, forever re-subscribing after every onComplete(). There is also a repeatUntil() operator that accepts a BooleanSupplier function and continues repeating until the provided function returns true.

- single()

    The single() operator returns a Single that emits the item emitted by this Observable. If the Observable emits more than one item, the single() operator throws an exception. If the Observable emits no item, the Single, produced by the single() operator, emits the item passed to the operator as a parameter.

    There is also a singleElement() operator that returns Maybe when the Observable emits one item or nothing and throws an exception otherwise. And there is a singleOrError() operator that returns Single when the Observable emits one item only and throws an exception otherwise.

- timestamp()

    The timestamp() operator attaches a timestamp to every item emitted by an Observable.

- timeInterval()

    The timeInterval() operator emits the time lapses between the consecutive emissions of a source Observable.

<br>

## Wrapping up




<br>

Refer:

[Learning RxJava, second edition]()

[https://rxmarbles.com/#merge](https://rxmarbles.com/#merge)