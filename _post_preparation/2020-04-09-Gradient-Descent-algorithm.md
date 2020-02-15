---
layout: post
title: Gradient Descent algorithm
bigimg: /img/image-header/yourself.jpeg
tags: [Machine learning]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of Gradient Descent](#solution-of-gradient-descent)
- [Improvement GD with Momentum](#improvement-gd-with-momentum)
- [Nesterov accelerated gradient (NAG)](#nesterov-accelerated-gradient-(nag))
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)

<br>

## Given problem






<br>

## Solution of Gradient Descent






<br>

## Improvement GD with Momentum





<br>

## Nesterov accelerated gradient (NAG)





<br>

## The comparison between Normal Equation and Gradient Descent

|        Gradient Descent        |         Normal Equation          |
| ------------------------------ | -------------------------------- |
| Need to choose alpha           | No need to choose alpha          |
| Needs many iterations          | No need to iterate               |
| O(kn^2)                        | O(n^3), need to calculate inverse of X^T.X |
| Works well when n is large     | Slow if n is very large          |

In practice, when the number of traning samples exceeds 10000, it might be a good time to go from a normal solution to an iterative process.

There is no need to do feature scaling with the normal equation.

<br>

## Benefits and Drawbacks





<br>

## Wrapping up
- The above Gradient Descent algorithm also called as Batch Gradient Descent.



<br>

Refer:

[https://www.hackerearth.com/blog/developers/3-types-gradient-descent-algorithms-small-large-data-sets](https://www.hackerearth.com/blog/developers/3-types-gradient-descent-algorithms-small-large-data-sets)

[https://www.quora.com/In-gradient-descent-without-feature-scaling-why-does-theta-descend-quickly-for-small-ranges-and-slowly-for-large-ones](https://www.quora.com/In-gradient-descent-without-feature-scaling-why-does-theta-descend-quickly-for-small-ranges-and-slowly-for-large-ones)

[https://machinelearningmastery.com/linear-regression-for-machine-learning/](https://machinelearningmastery.com/linear-regression-for-machine-learning/)

[https://machinelearningcoban.com/2017/01/16/gradientdescent2/#vi-du-minh-hoa](https://machinelearningcoban.com/2017/01/16/gradientdescent2/#vi-du-minh-hoa)