---
layout: post
title: Linear Regression
bigimg: /img/image-header/yourself.jpeg
tags: [Machine learning]
---




<br>

## Table of contents





<br>

## Given problem

In reality, we always have a large data sets from many sources such as logging system, research results, ... , what we have to do with it is that we need to preprocess it, then, analysis it to get the useful data. 

After that based on the cleaned data, we have to establish the relationship between the input and output that is called as supervised learning, to predict results when we had inputs. Or we need to cluster our data based on relationships among the variables in the data --> unsupervised learning. With unsupervised learning, there is no feedback based on the prediction results.

To work with Machine Learning fluently, we need to study about some basic algorithms in supervised learning and unsupervised learn. Then in this article, we only focus on Linear Regression of supervised learning.

<br>

## Linear Regression

1. Symbols

    - $\mathbf{x}^{(i)}$ is denoted as the input variables, also called input features of the $i^{th}$ training examples.
    
    - $\mathbf{x_j}^{(i)}$ is a value of feature j in the $i^{th}$ training example.

    - $\mathbf{y}^{(i)}$ is denoted as the output or target variable.

    - A pair ($\mathbf{x}^{(i)}$, $\mathbf{y}^{(i)}$) is called a training example. ($\mathbf{x}^{(i)}$, $\mathbf{y}^{(i)}$) with $i = 1, 2, ..., m$ is called a traning set.

    - The superscript $(i)$ in the notation is simply an index into the training set, and has nothing to do with exponentation.

    - m is the number of training examples.

    - n is the number of features.

    - A function $h(\boldsymbol{x}): \mathbf{X} \rightarrow \mathbf{Y}$ is a good predictor for corresponding value of $\mathbf{Y}$. For historical reasons, this function h is called a hypothesis.

    - $\mathbf{x}$ is column vector such as $\mathbf{x} = \begin{bmatrix} x_1\\ x_2\\ x_3 \end{bmatrix}$ or $\mathbf{x} = [x_1; x_2; \dots; x_n]$. In Machine Learning, by default, all vectors are column vectors.

    - With $\boldsymbol{X}$ matrix, if we do nothing, $\boldsymbol{w_i}$ is a column vector of its matrix.

2. Establishing the equation of Linear Regression

    After the step of visualizing our data, we can find that our data can be fit in Linear Regression model with some below equations:

    $h_\mathbf{\theta} (\mathbf{x}) = \theta_0 + \theta_1x_1 + \theta_2x_2 + ... + \theta_nx_n = \begin{bmatrix}\theta_0 \ \theta_1 \ \dots \ \theta_n \end{bmatrix} \begin{bmatrix} x_0\\ x_1\\ \vdots \\ x_n \end{bmatrix} = \mathbf{\theta}^T\mathbf{x}$

    

<br>

## Normal Equation





<br>

## Source code
1. From scratch



2. Using scikit-learn




<br>

## Advantages and Disadvantages




<br>

## Wrapping up




<br>

Refer:

