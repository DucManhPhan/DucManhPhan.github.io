---
layout: post
title: Some ways to loop in Java
bigimg: /img/image-header/california.jpg
tags: [Java]
---



<br>

## Table of contents
- []()



<br>

## For-each loop




<br>

## Using iterator
- 
- 
- We can only modify the list contents by removing the current element, and then only if we do it through the ```remove()``` method of iterator itself.

<br>

## Utilizing traditional for loop


- When using traditional for loop means that we utilize index-based iteration, we're free to modify the list in any way.

<br>

## Using some methods to loop from Iterable, Stream



<br>

## Wrapping up
- The basic loop is not recommended as we do not know the implementation of the list.

    If that was a ```LinkedList```, each call to ```list.get(i)``` would be iterating over the list, resulting in ```N^2``` time complexity.

- 



Refer:

[https://www.geeksforgeeks.org/iterator-vs-foreach-in-java/](https://www.geeksforgeeks.org/iterator-vs-foreach-in-java/)

[https://www.geeksforgeeks.org/how-to-use-iterator-in-java/](https://www.geeksforgeeks.org/how-to-use-iterator-in-java/)

[https://stackoverflow.com/questions/18410035/ways-to-iterate-over-a-list-in-java](https://stackoverflow.com/questions/18410035/ways-to-iterate-over-a-list-in-java)