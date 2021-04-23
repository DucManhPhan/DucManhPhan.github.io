---
layout: post
title: How to use RxJava3
bigimg: /img/image-header/yourself.jpeg
tags: [Reactive Programming]
---




<br>

## Table of contents
- [Given problem]()
- [Introduction to RxJava3]()
- []()
- []()
- []()


<br>

## Given problem






<br>

## Introduction to RxJava 3.x

1. 



2. Some common classes in RxJava 3.x

    - Observable


    - ObservableOnSubscriber


    - ObservableEmitter


    - Emitter


    - Observer


<br>

## Observable

The first thing we need to do is to study how an Observable sequentially passes items down the chain to an Observer. At the highest level, an Observer works by passing three types of events:
- onNext(): This passes each item one at a time from the source Observable all the way down to the Observer.
- onComplete(): This communicates a completion event all the way down to the Observer, indicating that no more onNext() calls will occur.
- onError(): This communicates an error down the chain to the Observer, which typically defines how to handle it. Unless a retry() operator is used to intercept the error, the Observable chain typically terminates, and no more emissions occur.

Belows are some ways to initialize an Observable.
1. Using Observable.create()

    A source Observable is an Observable from where emissions originiate. It is the starting point of our Observable chain (pipeline of operators). The Observable.create() factory allows us to create an Observable by providing a lambda that accepts an Observable emitter.

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

    From the create() method of Observable class, we find that the create() method will accept as a parameter an object of the ObservableOnSubscriber type that has only one method, subscribe(ObservableEmitter emitter), which accepts an ObservableEmitter type, which, in turn, extends the Emitter interface that has three methods: onNext(), onError(), and onComplete().

2. Using Observable.just()


3. 


<br>

## Observer





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
- The onNext(), onError() and onComplete() methods provided to the function via the Emitter instance should be called synchronously, never concurrently. Calling them from multiple threads is not supported and leads to an undefined behavior.

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

## 







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

- In RxJava 3.x, the [Observable contract] (http://reactivex.io/documentation/contract.html) dictates that emissions must be passed sequentially and one at a time. Emissions can't be passed by an Observable concurrently or in parallel. This may seem like a limitation, but it does, in fact, simplify programs and make Rx easier to reason with.

<br>

## Wrapping up




<br>

Refer:

[]()

[]()

[]()

[]()

[]()