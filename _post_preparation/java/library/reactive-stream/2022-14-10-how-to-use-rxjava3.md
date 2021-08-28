---
layout: post
title: How to use RxJava3
bigimg: /img/image-header/yourself.jpeg
tags: [Reactive Programming]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Introduction to RxJava 3.x](#introduction-to-rxjava-3.x)
- [Observable](#observable)
- [Observer](#observer)
- [Emitter](#emitter)
- [The comparison between RxJava's versions](#the-comparison-between-rxjava's-versions)
- [Some notes about RxJava versions](#some-notes-about-rxjava-versions)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Introduction to RxJava 3.x

1. Introduction to RxJava 3.x



2. Some common classes in RxJava 3.x

    - Observable
    - ObservableOnSubscriber
    - ObservableEmitter
    - Emitter
    - Observer

<br>

## Observable

0. Definition of Observable

    An Observable is an object that emits a sequence (or stream) of events. It represents a push-based collection, which is a collection in which events are pushed when they are created.

    An Observable emits a sequence that can be empty, finite, or infinite. When the sequence is finite, a complete event is emitted after the end of the sequence. At any time during the emission (but no after the end of it) an error event can be emitted, stopping the emission and cacelling the emission of the complete event.

    When the sequence is empty, only the complete event is emitted, without emitting any item. With an infinite sequence, the complete event is never emitted.

1. Some types of Observable

    - Cold Observable

        An Observable begins emitting a sequence of times when the Observer subscribes to it, they are called cold observables. Cold observables always wait to have at least one observer subscribed to start emitting items.

        **A cold observable replays the emissions to each Observer**, ensuring that it gets all the data. Most data-driven observables are cold, and this includes the observables produced by the **Observable.just()** and **Observable.fromIterable()** factories. It means that **Observable** sources that emit finite datasets are usually cold.

        Using operations such as **map()** and **filter()** against a cold Observable preserves the cold nature of the produced observables.

    - Hot Observable

        An Observable that begins emitting items before being connected to an observer is called a hot observable. With hot observables, an observer can subscribe and start receiving items at any time during the emission. With hot observables, the observer may received the complete sequence of items starting from the beginning or not.

        A hot observable is more like a radio station. It broadcasts the same emissions to all observers at the same time. If an Observer subscribes to a hot Observable, receives some emissions, and then another Observer subscribes later, that second Observer will have missed those emissions. Just like a radio station, if we tune in too late, we will have missed that song.    

        Logically, a hot Observable often represent events rather than finite datasets. The events can carry data with them, but there is a time-sensitive component, and late subscribers can miss previously emitted data.

    - ConnectableObservable

        It takes any **Observable**, even if it is cold, and makes it hot so that all emissions are played to all observers at once. To do this conversion, we simply need to call **publish()** on an **Observable**, and it will yield a **ConnectableObservable** object.

        Subscribing does not start the emission. We need to call the **connect()** method on the **ConnectableObservable** object to start it. This allows us to setup all our observers first, before the first value is emitted. It means that each emission goes to all observers simultaneously. Using ConnectableObservable to force each emission to go to all observers is known as multicasting.

        The **ConnectableObservable** is helpful in preventing the replaying of data to each Observer. You may want to do this when the replaying is expensive and you decide that emissions should go to all observers at the same time. You may also do it simply to force the operators upstream to use a single stream instance, even if there are multiple observers downstream.

        Multiple observers normally result in multiple stream instances upstream. But using publish() to return ConnectableObservable consolidates all the upstream operations into a single stream. For now, remember that ConnectableObservable is hot, and therefore, if new subscriptions occur after connect() is called, they will have missed emissions fired earlier.

2. How to create an Observable

    The first thing we need to do is to study how an Observable sequentially passes items down the chain to an Observer. At the highest level, an Observer works by passing three types of events:
    - **onNext()**: This passes each item one at a time from the source Observable all the way down to the Observer.
    - **onComplete()**: This communicates a completion event all the way down to the Observer, indicating that no more onNext() calls will occur.
    - **onError()**: This communicates an error down the chain to the Observer, which typically defines how to handle it. Unless a **retry()** operator is used to intercept the error, the Observable chain typically terminates, and no more emissions occur.

    Belows are some ways to initialize an Observable.
    - Using **Observable.create()**

        A source Observable is an Observable from where emissions originiate. It is the starting point of our Observable chain (pipeline of operators). The **Observable.create()** factory allows us to create an Observable by providing a lambda that accepts an Observable emitter.

        ```java
        // represents a basic, on-back pressured Observable source based interface, consumable via an Observer
        @FunctionalInterface
        public interface ObservableSource<@NonNull T> {
            void subscribe(@NonNull Observer<? super T> observer);
        }

        @FunctionalInterface
        public interface ObservableOnSubscriber<@NonNull T> {
            void subscribe(@NonNull ObservableEmitter<T> emitter) throws Throwable;
        }

        public final class ObservableCreate<T> extends Observable<T> {
            final ObservableOnSubscriber<T> source;

            @Override
            protected void subscribeActual(Observer<? super T> observer) {
                CreateEmitter<T> parent = new CreateEmitter<>(observer);
                observer.onSubscribe(parent);

                try {
                    source.subscribe(parent);
                } catch (Throwable ex) {
                    Exceptions.throwIfFatal(ex);
                    parent.onError(ex);
                }
            }

            static final class CreateEmitter<T> extends AtomicReference<Disposable> implements ObservableEmitter<T>, Disposable {}

            static final class SerializedEmitter<T> extends AtomicInteger<Disposable> implements ObservableEmitter<T> {}
        }

        public abstract class Observable<@NonNull T> implements ObservableSource<T> {
            // ...

            protected abstract void subscribeActual(@NonNull Observer<? super T> observer);

            public final Disposable subscribe() {
                return subscribe(Functions.emptyConsumer(), Functions.ON_ERROR_MISSING, Functions.EMPTY_ACTION);
            }

            public final Disposable subscribe(@NonNull Consumer<? super T> onNext) {
                return subscribe(onNext, Functions.ON_ERROR_MISSING, Functions.EMPTY_ACTION);
            }

            public final Disposable subscribe(@NonNull Consumer<? super T> onNext, @NonNull Consumer<? super Throwable> onError) {
                return subscribe(onNext, onError, Functions.EMPTY_ACTION);
            }

            public final Disposable subscribe(@NonNull Consumer<? super T> onNext, @NonNull Consumer<? super Throwable> onError,
                                            @NonNull Action onComplete) {
                LambdaObserver<T> ls = new LambdaObserver<>(onNext, onError, onComplete, Functions.emptyConsumer());
                subscribe(ls);
                return ls;
            }

            public final void subscribe(@NonNull Observer<? super T> observer) {
                Objects.requireNonNull(observer, "observer is null");
                try {
                    observer = RxJavaPlugins.onSubscribe(this, observer);

                    Objects.requireNonNull(observer, "The RxJavaPlugins.onSubscribe hook returned a null Observer. Please change the handler provided to RxJavaPlugins.setOnObservableSubscribe for invalid null returns. Further reading: https://github.com/ReactiveX/RxJava/wiki/Plugins");

                    subscribeActual(observer);
                } catch (NullPointerException e) { // NOPMD
                    throw e;
                } catch (Throwable e) {
                    Exceptions.throwIfFatal(e);
                    // can't call onError because no way to know if a Disposable has been set or not
                    // can't call onSubscribe because the call might have set a Subscription already
                    RxJavaPlugins.onError(e);

                    NullPointerException npe = new NullPointerException("Actually not, but can't throw other exceptions due to RS");
                    npe.initCause(e);
                    throw npe;
                }
            }

            public static <T> Observable create(@NonNull ObservableOnSubscriber<T> source) {
                return RxJavaPlugins.onAssembly(new ObservableCreate(source));
            }
        }
        ```

        From the **create()** method of Observable class, we find that the **create()** method will accept as a parameter an object of the **ObservableOnSubscriber** type that has only one method, **subscribe(ObservableEmitter emitter)**, which accepts an ObservableEmitter type, which, in turn, extends the Emitter interface that has three methods: **onNext()**, **onError()**, and **onComplete()**.

        We can call the **ObservableEmitter**'s **onNext()** method to pass emissions (one at a time) down the chain of operators as well as **onComplete()** to signal completion and communicate that there will be no more items. Note that the **onNext()**, **onComplete()**, and **onError()** methods of the emitter do not necessarily push the data directly to the final **Observer**. There can be another operator between the source **Observable** and its **Observer** that acts as the next step in the chain, such as **map()**, **filter()** operators. Since operators such as map() and filter() yield new observables (which internally use Observer implementations to receive emissions), we can chain all our returned observables with the next operator, rather than unnecessarily saving each one to an intermediary variable.

        The **onComplete()** method is used to communicate down the chain to the **Observer** that no more items are coming. Observables are indeed be infinite, and if this is the case, the **onComplete()** event will never be called. Technically, a source could stop emitting **onNext()** calls and never call **onComplete()**. This would likely be bad design, though, if the source no longer plans to send emissions.

        In RxJava 3.x, the [Observable contract] (http://reactivex.io/documentation/contract.html) dictates that emissions must be passed sequentially and one at a time. Emissions can't be passed by an Observable concurrently or in parallel. This may seem like a limitation, but it does, in fact, simplify programs and make Rx easier to reason with.

    - Using **Observable.just()**

        In RxJava 3.x, there are multiple versions of Observable.just() methods.

        ```java
        public abstract class Observable<@NonNull T> implements ObservableSource<T> {
            // ...

            public static <T> Observable<T> just(@NonNull T item) {
                return RxJavaPlugins.onAssembly(new ObservableJust<>(item));
            }

            public static <T> Observable<T> just(@NonNull T item1, @NonNull T item2) {                
                return fromArray(item1, item2);
            }

            public static <T> Observable<T> just(@NonNull T item1, @NonNull T item2, @NonNull T item3) {
                return fromArray(item1, item2, item3);
            }

            public static <T> Observable<T> just(@NonNull T item1, @NonNull T item2, @NonNull T item3, @NonNull T item4) {}

            public static <T> Observable<T> just(@NonNull T item1, @NonNull T item2, @NonNull T item3, @NonNull T item4, @NonNull T item5) {}

            public static <T> Observable<T> just(@NonNull T item1, @NonNull T item2, @NonNull T item3, @NonNull T item4, @NonNull T item5, @NonNull T item6) {}

            public static <T> Observable<T> just(@NonNull T item1, @NonNull T item2, @NonNull T item3, @NonNull T item4, @NonNull T item5, @NonNull T item6, @NonNull T item7) {}

            public static <T> Observable<T> just(@NonNull T item1, @NonNull T item2, @NonNull T item3, @NonNull T item4, @NonNull T item5, @NonNull T item6, @NonNull T item7, @NonNull T item8) {}

            public static <T> Observable<T> just(@NonNull T item1, @NonNull T item2, @NonNull T item3, @NonNull T item4, @NonNull T item5, @NonNull T item6, @NonNull T item7, @NonNull T item8, @NonNull T item9) {}

            public static <T> Observable<T> just(@NonNull T item1, @NonNull T item2, @NonNull T item3, @NonNull T item4, @NonNull T item5, @NonNull T item6, @NonNull T item7, @NonNull T item8, @NonNull T item9, @NonNull T item10) {}

            /**
            * Converts an array into an ObservableSource that emits the items in the array
            **/
            public static <T> Observable<T> fromArray(@NonNull T... items) {
                Objects.requireNonNull(items, "items is null");
                if (items.length == 0) {
                    return empty();
                }
                if (items.length == 1) {
                    return just(items[0]);
                }
                return RxJavaPlugins.onAssembly(new ObservableFromArray<>(items));
            }
        }
        ```

        From the above definition of **Observable.just()** method, we can pass into it up to 10 items that we want to emit. This will invoke **onNext()** for each one and then invoke **onComplete()** when they have all been pushed.


    - Using **Observable.fromIterable()**

        Below is the definition of Observable.fromIterable() method in RxJava 3.x.

        ```java
        public abstract class Observable<@NonNull T> implements ObservableSource<T> {
            // ...

            public static <T> Observable<T> fromIterable(@NonNull Iterable<@NonNull ? extends T> source) {
                return RxJavaPlugins.onAssembly(new ObservableFromIterable<>(source));
            }
        }
        ```

        So we can easily find that **Observable.fromIterable()** is used to emit the items from nay Iterable type, such as List, ... It will call **onNext()** for each element and then call **onComplete()** once all elements are emitted.

    - Using **Observable.range()**

        It creates an Observable that emits a consecutive range of integers. It emits each number from a start value and increments each subsequent value by one until the specified count is reached. These numbers are all passed through the onNext() event, followed by the onComplete() event.

        ```java
        Observable.range(1, 5)
            .subscribe(s -> System.out.println("RECEIVED: " + s));
        ```

        The two arguments for Observable.range() are not lower and upper bounds. The first argument is the initial value. The second argument is the total count of emissions, which will include both the initial value and subsequent incremented values. It means that we can call **Observable.range(5, 3);**.

        There is also a long equivalent called **Observable.rangeLong()** if we need to emit larger numbers.

    - Using **Observable.interval()**

        As we have seen, **Observable** produces emissions over time. Emissions are handed from the source down to the **Observer** sequentially. The emissions can be spaced out over time depending on when the source provides them.

        **Obserable.interval()** emits consecutive long values (starting at 0) with the specified time interval between emissions.

        **Observable.interval()** emits infinitely at the specified interval. However, because it operates on a timer, it needs to run on a separate thread, which is the computation scheduler by default. It means that our main method kicks off the Observable, but does not wait for it to finish. The Observable starts emitting on a seperate thread.

        To keep our main() method from finishing and exiting the application before our Observable has a chance to finish emitting, we use the sleep() method to keep this application alive for 3 seconds (from now on, we are going to use this method throughout the book without presenting its source code anymore). This gives our Observable enough time to fire all emissions before the application quits. When you create production applications, you likely will not run into this issue often because non-daemon threads for tasks such as web services.

    - Using **Observable.future()**

        The RxJava Observable is much more robust and expressive than **java.util.concurrent.Future**, but if we have existing libraries that yield **Future**, we can easily turn it into an Observable using **Observable.future()**.

    - Using **Observable.empty()**

        Although this may not seem useful yet, it is sometimes helpful to create an Observable that emits nothing and calls onComplete().

        Empty observables typically represent empty datasets. They can also result from operators such as filter() when none of the emitted values pass the criterion. Sometimes, you need to deliberately create an empty Observable using Observable.empty().

        An empty **Observable** is essentially RxJava's concept of null. It represents an absence of value or, technically, values. However, it is more elegant than null because operations do not throw **NullPointerExceptions**. The **onComplete** event is emitted, and the processing stops. Then, we have to trace through the chain of operators to find which one caused the flow of emissions to become empty.

    - Using **Observable.never()**

        A close cousin of Observable.empty() is Observable.never(). The only difference between them is that the never() method does not generate the onComplete event, thus leaving the observer waiting for an emission forever.

        This Observable is primarily used for testing and not that often in production. We have to use with sleep() because the main thread is not going to wait for it after kicking it off.

    - Using **Observable.error()**

        This is something that uses only with testing. It creates an Observable that immediately generates an onError event with the specified exception.

    - Using **Observable.defer()**

        - Given problem:

            Normally, we will use Observable.just() to create a new Observable, but Observable.just() is evaluated as soon as it's invoked, so it will create a sequence using the exact value when the Observable is created.

            But sometimes, there is a problem that we can change the data that it need to be reflected while an Observer is subscribed that Observable.

        - Solution

            **Observable.defer()** is a powerful factory due to its ability to create a separate state for each Observer. When using certain **Observable** factories, we may run into some nuances if our source is stateful and we want to create a separate state for each Observer. Our source **Observable** may not capture something that has changed regarding its parameters and send emissions that are obsolete.

            If we subscribe to this Observable, modify the count, and then subscribe again, you will find that the second Observer does not see this change.

            When your Observable source is not capturing changes to the things driving it, try putting it in Observable.defer(). If your Observable source was implemented naively and behaves in a broken manner with more than one Observer (for example, it reuses an Iterator that only iterates data once), Observable.defer() provides a quick workaround for this as well.
    
    - Using **Observable.fromCallable()**

        If you need to perform a calculation or some other action and then emit the result, you can use Observable.just() (or Single.just() or Maybe.just(). But sometimes, we want to do this in a lazy or deferred manner.

        Problem when not using Observable.fromCallable():
        -  if the expression in Observable.just(), Single.just(), or Maybe.just() throws an error, no emission (data or event) happens, and the exception propagates in the traditional Java fashion. So, onError event from the source Observable will not emit to the Observer. So, the error handler part of the Observer won't notified.

            That is because the Observable was not even created. So if we want it to be emitted down the Observable chain along with an onError event, even if thrown during the emission initialization, use Observable.fromCallable() instead. It accepts a functional interface, Supplier<T>.

        So if initializing our emission has a likelihood of throwing an error, use Observable.fromCallable() instead of Observable.just().

3. Some specialized flavors of Observable

    Belows are some flavors of Observable that we need to know.
    - Single

        The Single<T> class is essentially an Observable<T> that emits only one item and, as such, is limited only to operators that make sense for a single emission. Similar to the Observable class (which implements ObservableSource), the Single class implements the SingleSource functional interface, which has only one method, void subscribe(SingleObserver observer).

        There is the SingleObserver interface as well:

        ```java
        interface SingleObserver<T> {
            void onSubscribe(@NonNull Disposable d);
            void onSuccess(T value);
            void onError(@NonNull Throwable error);
        }
        ```

        In contrast with the Observer interface, it does not have the onNext() method and has the onSuccess() method instead of onComplete(). This makes sense because Single can emit one value at the most. onSuccess() essentially consolidates onNext() and onComplete() into a single event. When you call subscribe() on a Single object, you provide one lambda expression for onSuccess() and, optionally, another lambda expression for onError().

        There are operators on Single that turn it into an Observable, such as toObservable(). And, in the opposite direction, certain Observable operators return a Single. For instance, the first() operator will return a Single because that operator is logically concerned with a single item. However, it accepts a default value as a parameter if the Observable comes out empty.

        The Single must have one emission, so you can use it only if you have only one emission to provide. But if there are 0 or 1 emissions, you should use Maybe instead.

    - Maybe

        The Maybe is just like a Single, except that it also allows no emissions to occur at all (hence Maybe). The MaybeObserver is much like a standard Observer, but onNext() is called onSuccess() instead:

        ```java
        public interface MaybeObserver<T> {
            void onSubscribe(@NonNull Disposable d);
            void onSuccess(T value);
            void onError(@NonNull Throwable e);
            void onComplete();
        }
        ```

        A given Maybe<T> emits 0 or 1 items. It will pass the possible emission to onSuccess(), and in either case, it will call onComplete() when done. Maybe.just() can be used to create a Maybe emitting a single item. Maybe.empty() creates a Maybe that emits nothing.

        To get a Maybe object from an Observable object, use Observable.firstElement() method.

    - Completable

        Completable is simply concerned with an action being executed, but it does not receive any emissions. Logically, it does not have onNext() or onSuccess() to receive emissions, but it does have onError() and onComplete().

        ```java
        interface CompletableObserver<T> {
            void onSubscribe(@NonNull Disposable d);
            void onComplete();
            void onError(@NonNull Throwable error);
        }
        ```

        Completable is something you likely will not use often. You can construct one quickly by calling Completable.complete() or Completable.fromRunnable(). The former immediately calls onComplete() without doing anything, while fromRunnable() executes the specified action before calling onComplete().

4. Some common operations with Observables

    - Merging observables

        A common task done in ReactiveX is taking two or more Observable<T> instances and merging them into one Observable<T>. This merged Observable<T> subscribes to all of its merged sources simultaneously, making it effective for merging both finite and infinite observables.

        - Using merge() factory method

            The Observable.merge() factory will take two or more Observable<T> sources emitting the same type T and then consolidate them into a single Observable<T>.

            Another way to use merge() factory method is that this method accepts a collection of Observables or an instance of Iterable.

            This factory method can works with infinite observables. Since it will subscribe to all observables and fire their emissions as soon as they are available, you can merge multiple infinite sources into a single stream.

            To summarize, Observable.merge() combines multiple Observable<T> sources emitting the same type T and consolidates them into a single Observable<T>. It works on infinite Observable instances and does not necessarily guarantee that the emissions come in any order.

        - Using mergeWith() method

            If we want to merge only two Observables each other, utilize mergeWith() operator.

        The Observable.merge() factory and the mergeWith() operator will subscribe to all the specified sources simultaneously, but will likely fire the emissions in order if they are cold and on the same thread. This is just an implementation detail that is not guaranteed to work the same way every time. If you want to fire elements of each Observable sequentially and keep their emissions in sequential order, you should use Observable.concat().

        If we have more than four Observable<T> sources, we can use Observable.mergeArray() to pass an array of Observable instances that we want to merge. The reason mergeArray() gets its own method and is not a merge() overload instead is to avoid ambiguity. This is true for all the xxxArray() operators.

        To make the emissions from Observable in strictly order, use Observable.concat() operator.

    - flatMap()

        - flatMap()

            It performs a dynamic Observable.merge() by taking each emission and mapping it to an Observable. Then, it merges the resulting observables into a single stream. The simplest application of flatMap() is to map one emission to many emissions.

            Just like Observable.merge(), flatMap() can also map emissions to infinite instances of Observable and merge them. For instance, it can receive simple Integer values from Observable<Integer> but use flatMap() on them to drive an Observable.interval(), where each Integer value serves as the period argument.

            The Observable.merge() operator accepts a fixed number of Observable sources. However, flatMap() dynamically adds new Observable sources for each value that comes in. This means that you can keep merging new incoming Observable sources all the time.

        - flatMap() with combiner

            The flatMap() operator has an overloaded version, flatMap(Function<T,Observable<R>> mapper, BiFunction<T,U,R> combiner), that allows the provision of a combiner along with the mapper function. This second combiner function associates the originally emitted T value with each flat-mapped U value and turns both into an R value.

            We can also use flatMapIterable() to map each T value into an Iterable<R> instead of an Observable<R>. It will then emit all the R values for each Iterable<R>, saving us the step and overhead of converting it into an Observable.

            There is also flatMapSingle() that maps the input to Single, flatMapMaybe() that maps to Maybe, and flatMapCompletable() that maps to Completable.

<br>

## Observer

0. Definition of Observer

    An Observer is an object that subscribes to an Observable. It listens and reacts to whatever sequence of items is emitted by the Observable.

    The Observer is not blocked while waiting for new emitted items, so in concurrent operations, no blocking occurs. It just wakes up when a new item is emitted.

    This is one of the core principles of reactive programming: instead of executing instructions one at a time (always waiting for the previous instruction to be completed), the observable provides a mechanism to retrieve and transform data, and the Observer activates this mechanism, all in a concurrent way.

    In order to connect an Observable with an Observer, we must use the subscribe() method.

    An Observable can't notify both onCompleted and onError methods, only one of them. It will always be the last method invoked.

1. Some common methods of Observer interface

    Below is the definition of Observer interface.

    ```java
    public interface Observer<@NonNull T> {
        void onSubscribe(@NonNull Disposable d);
        void onNext(@NonNull T t);

        /**
         * It notifies the Observer when the Observable raises
         * an error and stops emitting items, even if the sequence is not completed.
         */
        void onError(@NonNull Throwable e);

        /**
         * It notifies the Observer when the Observable stops emitting items
         * because the sequence is completed normally.
         */
        void onComplete();
    }
    ```

    Observer provides a mechanism for receiving push-based notifications.

    When an Observer is subscribed to an ObservableSource through the ObservableSource.subscribe(Observer) method, the ObservableSource calls onSubscribe(Disposable) with a Disposable that allows disposing the sequence at any time, then the ObservableSource may call the Observer's onNext method any number of times to provide notifications. A well-behaved ObservableSource will call an Observer's onComplete method exactly once or the Observer's onError method exactly once.
    
    Calling the Observer's method must happen in a serialized fashion, that is, they must not be invoked concurrently by multiple threads in an overlapping fashion and the invocation pattern must adhere to the following protocol:

    ```python
    onSubscribe onNext* (onError | onComplete)?
    ```

    From the Observable's perspective, an Observer is the end consumer thus it is the Observer's responsibility to handle the error case and signal it "further down". This means unreliable code in the **onXXX** methods should be wrapped into ```try-catch```es, specifically in **onError(Throwable)** or **onComplete()**, and handled there (for example, by logging it or presenting the user with an error dialog). However, if the error would be thrown from **onNext(Object)**, [Rule 2.13](https://github.com/reactive-streams/reactive-streams-jvm#2.13)  mandates the implementation calls **Disposable.dispose()** and signals the exception in a way that is adequate to the target context, for example, by calling **onError(Throwable)** on the same Observer instance.

    If, for some reasons, the Observer won't follow [Rule 2.13](https://github.com/reactive-streams/reactive-streams-jvm#2.13), the Observable.safeSubscribe(Observer) can wrap it with the necessary safeguards and route exceptions thrown from onNext into onError and route exceptions thrown from onError and onComplete into the global error handler via io.reactivex.rxjava3.plugins.RxJavaPlugins.onError(Throwable).

    Each Observable returned by an operator is internally an Observer that receives, transforms, and relays emissions to the next Observer downstream. It does not know whether the next Observer is another operator or the final Observer at the end of the chain. When we talk about the Observer, we are often talking about the final Observer at the end of the processing chain that consumes the emissions. But each operator, such as map() and filter(), also implements Observer internally.

    In fact, **Observable** implements the functional interface **ObservableSource**, which has only one method, **void subscribe(Observer<T> observer)**. When we call the **subscribe()** method on Observable and pass into it an object that implements the Observer interface or just a lambda expression that represents the Observable implementation, we subscribe this **Observer** to the emissions (data and events) of the Observable.

    When you call the **subscribe()** method on an **Observable**, an **Observer** receives three events: **onNext**, **onError**, and **onComplete**, that are processed by the corresponding methods. An error that happens anywhere in the chain will propagate to onError() to be handled and then terminate the Observable with no more emissions. If you do not specify an action for onError, the chain will stop processing anyway, but the error will not be handled by the application and propagate all the way into the JVM, and most likely will force the application's exit. We can use retry() operators to attempt recovery and resubscribe to an Observable if an error occurs.

    It is critical to note that most of the subscribe() overload variants (including the shorthand lambda we have just covered) return a Disposable that we did not do anything with. A Disposable allows the Observable to be disconnected from its Observer so emissions are terminated early, which is critical for an infinite or a long-running Observable.

2. Some event types of Observer interface

    The Observable provides three event types that contains onNext(), onCompleted(), and onError(). So the Observer also needs to react to three types of events.
    - Item emissions by the Observable

        It occurs zero, one, or more times. If the sequence completes correctly, the onNext() method will be invoked as many times as the number of items in the sequence. If an error occurs at a certain point, the onNext() method won't be invoked any further.

    - The completion of items emission

        Only when all items in the sequence are emitted correctly, the onCompleted() method will be invoked. It's invoked only once, and after the last item has been emitted. It also can never happen if we're working with an infinite sequence.

    - An error

        Error can occur in every moment of the sequence, and the sequence will stop immediately. In this case, the method onError will be invoked, passing the error as a Throwable object. The other two methods, onNext and onCompleted, won't be invoked.

3. Some notes about Observer interface's implementations

    - Subscribing an Observer to multiple ObservableSources is not recommended. If such reuse happens, it is the duty of the Observer implementation to be ready to receive multiple calls to its methods and ensure proper concurrent behavior of its business logic.

    - Calling onSubscribe(Disposable), onNext(Object) or onError(Throwable) with a null argument is forbidden.

4. Some common problems when using Observers

    - Using only method for onNext event

        ```java
        observable.subscribe(item -> doSomething());
        ```

        When using this signature of subscribe() method, we won't get notified when the sequence completes. More importantly, if an error occurs, an exception will be thrown by RxJava because no implementation of onError can be found, and our app will crash.

    - How to disconnect between Observable and Observer

        When calling **Observable.subscribe()** method, normally RxJava will create an Subscription object to connect between Observable and Observer. To know more about this architecture, we can read about the following link [What is Reactive programming in Java](https://ducmanhphan.github.io/2019-12-01-What-is-Reactive-programming-in-Java/).

        ```java
        Subscription subscription = Observable.just("Hello", "world", "reactive", "programming")
                                              .subscribe(System.out::println);  
        ```

        So to disconnect Observable and Observer, calling unsubscribe() method of Subscription.

        ```java
        subscription.unsubscribe();
        ```

        The unsubscribe() method can be called at any time during items emissions. After the call to unsubscribe() method, onNext() won't receive any other item, and the other two methods, onCompleted and onError won't be notified. After unsubscription, the observable can stop or continue with item emission, but the observer will not be notified about it.

        To check whether the subscription has been unsubscribed or Observer and Observable are no longer connected, use Subscription.isUnsubscribed() method.

<br>

## Emitter

According to Emitter class from RxJava 3.x, we have a definition of Emitter. This is base interface for emitting signals in a push-fashion in various generator-like source operators (create, generate).


```java
public interface Emitter<@NonNull T> {
    void onNext(@NonNull T);
    void onError(@NonNull Throwable error);
    void onComplete();
}
```

Note:
- The **onNext()**, **onError()** and **onComplete()** methods provided to the function via the Emitter instance should be called synchronously, never concurrently. Calling them from multiple threads is not supported and leads to an undefined behavior.

Below is the definition of **ObservableEmitter** classs.

```java
public interface ObservableEmitter<@NonNull T> extends Emitter<T> {
    void setDisposable(@Nullable Disposable d);
    void setCancellable(@Nullable Cancellable c);
    boolean isDisposed();
    
    @NonNull
    ObservableEmitter<T> serialize();

    boolean tryOnError(@NonNull Throwable t);
}
```

<br>

## When to use







<br>

## Benefits and Drawbacks

1. Benefits

    - lower memory usage
    - flexible concurrency
    - disposability

2. Drawbacks

    - 
    - 
    - 

<br>

## The comparison between RxJava's versions

1. RxJava 1.x and RxJava 2.x

    RxJava 1.x wasn't supported from March 21, 2018. RxJava 2.x was maintained to fix bug until February 28, 2021.


2. RxJava 2.x and RxJava 3.x



All RxJava versions can be run on Java 1.6 or above.

<br>

## Some notes about RxJava versions

- In RxJava 1.x, the types are contained in the rx package. In RxJava 2.x, most types are contained in the io.reactivex package. In RxJava 3.x, the types are contained in the io.reactivex.rxjava3 package.

- In RxJava 1.x, **onComplete()** event is actually called **onCompleted()**. In RxJava 1.x, ensure that we use Observable.fromEmitter() instead of Observable.create(). The latter is something entirely different in RxJava 1.x and is intended to be used only by advanced RxJava users.


<br>

## Wrapping up




<br>

Refer:

[]()

[]()

[]()

[]()

<br>

**Some rules for reactive programming of RxJava 1.x**

[https://github.com/reactive-streams/reactive-streams-jvm#2.13](https://github.com/reactive-streams/reactive-streams-jvm#2.13)

[https://viblo.asia/p/rxjava-su-khac-biet-giua-flatmap-switchmap-concatmap-924lJrv8lPM](https://viblo.asia/p/rxjava-su-khac-biet-giua-flatmap-switchmap-concatmap-924lJrv8lPM)