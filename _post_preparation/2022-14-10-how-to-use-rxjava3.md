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

The first thing we need to do is to study how an Observable sequentially passes items down the chain to an Observer. At the highest level, an Observer works by passing three types of events:
- **onNext()**: This passes each item one at a time from the source Observable all the way down to the Observer.
- **onComplete()**: This communicates a completion event all the way down to the Observer, indicating that no more onNext() calls will occur.
- **onError()**: This communicates an error down the chain to the Observer, which typically defines how to handle it. Unless a **retry()** operator is used to intercept the error, the Observable chain typically terminates, and no more emissions occur.

Belows are some ways to initialize an Observable.
1. Using **Observable.create()**

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

    From the **create()** method of Observable class, we find that the **create()** method will accept as a parameter an object of the ObservableOnSubscriber type that has only one method, subscribe(ObservableEmitter emitter), which accepts an ObservableEmitter type, which, in turn, extends the Emitter interface that has three methods: **onNext()**, **onError()**, and **onComplete()**.

    We can call the **ObservableEmitter**'s **onNext()** method to pass emissions (one at a time) down the chain of operators as well as **onComplete()** to signal completion and communicate that there will be no more items. Note that the **onNext()**, **onComplete()**, and **onError()** methods of the emitter do not necessarily push the data directly to the final **Observer**. There can be another operator between the source **Observable** and its **Observer** that acts as the next step in the chain, such as **map()**, **filter()** operators. Since operators such as map() and filter() yield new observables (which internally use Observer implementations to receive emissions), we can chain all our returned observables with the next operator, rather than unnecessarily saving each one to an intermediary variable.

    The **onComplete()** method is used to communicate down the chain to the **Observer** that no more items are coming. Observables are indeed be infinite, and if this is the case, the **onComplete()** event will never be called. Technically, a source could stop emitting **onNext()** calls and never call **onComplete()**. This would likely be bad design, though, if the source no longer plans to send emissions.

    In RxJava 3.x, the [Observable contract] (http://reactivex.io/documentation/contract.html) dictates that emissions must be passed sequentially and one at a time. Emissions can't be passed by an Observable concurrently or in parallel. This may seem like a limitation, but it does, in fact, simplify programs and make Rx easier to reason with.

2. Using **Observable.just()**

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


3. Using **Observable.fromIterable()**

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

<br>

## Observer

1. Some common methods of Observer interface

    Below is the definition of Observer interface.

    ```java
    public interface Observer<@NonNull T> {
        void onSubscribe(@NonNull Disposable d);
        void onNext(@NonNull T t);
        void onError(@NonNull Throwable e);
        void onComplete();
    }
    ```

    Observer provides a mechanism for receiving push-based notifications.

    When an Observer is subscribed to an ObservableSource through the ObservableSource.subscribe(Observer) method, the ObservableSource calls onSubscribe(Disposable) with a Disposable that allows disposing the sequence at any time, then the ObservableSource may call the Observer's onNext method any number of times to provide notifications. A well-behaved ObservableSource will call an Observer's onComplete method exactly once or the Observer's onError method exactly once.
    
    Calling the Observer's method must happen in a serialized fashion, that is, they must not be invoked concurrently by multiple threads in an overlapping fashion and the invocation pattern must adhere to the following protocol:

    ```python
    onSubscribe onNext* (onError | onComplete)?
    ```


2. Some types of Observer interface




3. Some notes about Observer interface's implementations

    - Subscribing an Observer to multiple ObservableSources is not recommended. If such reuse happens, it is the duty of the Observer implementation to be ready to receive multiple calls to its methods and ensure proper concurrent behavior of its business logic.

    - Calling onSubscribe(Disposable), onNext(Object) or onError(Throwable) with a null argument is forbidden.

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