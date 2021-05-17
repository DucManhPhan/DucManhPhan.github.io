---
layout: post
title: Introduction to React Native
bigimg: /img/image-header/yourself.jpeg
tags: [Multithreading, Java]
---




<br>

## Table of contents
- [Introduction to React Native](#introduction-to-react-native)
- [Installing React Native](#installing-react-native)
- [How React Native works](#how-react-native-works)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to React Native

React Native is a Javascript framework built on top of React.js, that used to build HTML-based web apps, but for targeting iOS and Android applications.

We still use React component and even a very similar workflow to creating web-based React apps.

<br>

## Installing React Native






<br>

## How React Native works

![](../img/React/react-native/how-react-native-works.png)

First, we code our apps using ```JSX``` and composing our components from a suite of components provided to us by React Native. Then it goes through a build process. The React Native packager, in the form of a terminal process, hangs around in the background and monitors our project for file changes.

It then compiles those files into a plain Javascript package using webpack. So in the meanwhile, we've installed our app on iOS or on Android in a simulator or on an actual device. This app talks to our React Native packager, which notifies it that there is a new bundle for it to download and run. The React Native code downloads this bundle and loads it into a Javascript engine where it executes it. In Javascript Core, the JS engine, it loads up our components, call a render() method, and it builds up a tree of components.

It then talks through a bridge with the native app where it programmatically lays out our View using the native components for the platform it's currently running on, either iOS or Android. So imagine we're an iOS developer and we don't use any graphical layout tools. We go and build up all our views programmatically.

- Why is it called Native but we build it using JS and React?

<br>

## Benefits and Drawbacks
1. Benefits

    - Cross platform: Target iOS and Android with the same code.

    - Dynamic updates: Update apps in a matter of seconds. So, if we have a bug to fix, we do not need to wait for app store approval to patch it, we can fix it in real time as we're used to doing with web apps.

    - Hybrid Apps: Combine native components and apps with React Native.

<br>

## Wrapping up




<br>

Refer:

[React Native: Getting Started](https://app.pluralsight.com/library/courses/react-native-getting-started/table-of-contents)