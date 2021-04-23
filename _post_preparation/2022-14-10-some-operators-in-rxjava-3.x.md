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

1. takeWhile() and skipWhile()




2. switchIfEmpty()



<br>

## Supressing operators





<br>

## Transforming operators





<br>

## Reducing operators





<br>

## Collection operators





<br>

## Error recovery operators





<br>

## Action operators





<br>

## Utility operators






<br>

## Wrapping up




<br>

Refer:

