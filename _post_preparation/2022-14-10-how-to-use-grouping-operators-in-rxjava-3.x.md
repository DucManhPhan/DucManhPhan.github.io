---
layout: post
title: How to use Grouping operators in RxJava 3.x
bigimg: /img/image-header/yourself.jpeg
tags: [Reactive Programming]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with grouping operators](#solution-with-grouping-operators)
- [When to use](#when-to-use)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution with grouping operators

Grouping operators are used to group emissions by a specified key into seperate observables.

1. groupBy() operator

    This operator will accept a function that maps each emission to a key. It will then return an Observable<GroupedObservable<K, T>>, which emits a special type of Observable, called as GroupedObservable. The GroupedObservable<K, T> class is just like any other Observer, but it has the key K value accessible as a property. It emits T type values that are mapped for that given key.

    GroupedObservable is a weird combination of a hot and cold Observable. It is not cold as it does not replay missed emissions to a second Observer, but it caches emissions and flushes them to the first Observer, ensuring that none are missed. If we need to replay the emissions, collect them in a list, and perform our operations againsts that list.


<br>

## When to use





<br>

## Wrapping up




<br>

Refer:

