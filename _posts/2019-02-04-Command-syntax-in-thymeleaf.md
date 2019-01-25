---
layout: post
title: Command syntax in thymeleaf engine 
bigimg: /img/image-header/home-office-1.jpg
tags: [java]
---

In the previous [article](https://ducmanhphan.github.io/2019-02-07-Implementation-with-layout-in-thymeleaf), we have understood a few about utilizing layout with Thymeleaf. But it is not enough knowledege to write front-end easily.

So, to dig into Thymeleaf, in this article, we will continue to learn some syntaxes such as conditional statement, loop statement, ... in Thymeleaf. 

All informations are referenced from this [website](https://www.thymeleaf.org/doc/tutorials/2.1/usingthymeleaf.html) of Thymeleaf.

<br>

## Table of Contents
- [Link URLs](#link-urls)
- [Messages and Variables](#messages-and-variables)
- [Using text](#using-text)
- [Conditional statement](#conditional-statement)
- [Loop statement](#loop-statement)
- [Recap](#recap)


<br>

## Link URLs





<br>

## Messages and Variables





<br>

## Using text




<br>

## Conditional statement
When we have a specific condition to display elements in html, we can use simple conditionals: ```if``` and ```unless```.

```html
<div class="container">
    <th:block th:if="${#lists.isEmpty(contacts)}">
        ...
    </th:block>

    <th:block th:unless="${#lists.isEmpty(contacts)}">
        <div class="row">
            ...
        </div>
    </th:block>
</div>
```

With ```th:block```, we can refer to this [part](#comments-and-blocks).

The ```th:if``` attribute will not only evaluate boolean conditions. Its capabilities go a little beyond that, and it will evaluate the specified expression as true following these rules:
- If value is not null: 
    - If value is a boolean and is true.
    - If value is a number and is non-zero
    - If value is a character and is non-zero
    - If value is a String and is not “false”, “off” or “no”
    - If value is not a boolean, a number, a character or a String.

- If value is null, ```th:if``` will evaluate to false.

```th:if``` has a negative counterpart - ```th:unless```.

If we want to get the complement of a specific condition, use ```not``` before condition.

```html
<a href="comments.html"
   th:href="@{/product/comments(prodId=${prod.id})}" 
   th:if="${not #lists.isEmpty(prod.comments)}">
   view
</a>
```

We can use ```th:unless``` to transfer the above code that use ```th:if``` to have similiar meaning:

```html
<a href="comments.html"
   th:href="@{/product/comments(prodId=${prod.id})}" 
   th:unless="${#lists.isEmpty(prod.comments)}">
   view
</a>
```

Now, we will go to the next condition statement, it is ```switch``` statement such as ```th:switch``` and ```th:case```.

```html
<div th:switch="${user.role}">
  <p th:case="'admin'">User is an administrator</p>
  <p th:case="#{roles.manager}">User is a manager</p>
  <p th:case="*">User is some other thing</p>
</div>
````

As soon as one ```th:case``` attribute is evaluated as ```true```, every other ```th:case``` attribute in the same switch context is evaluated as ```false```.

The default option of ```th:case``` is ```*```.

<br>

## Loop statement
In Controller, we pass the ```java.util.List``` object into the Model in Spring Boot, assuming that it is ```prods``` object, ResolveViewer have to iterate all elements in this array object. So, to do this, Thymeleaf provide an easy way. It is to use ```th:each```.

```html
 <table>
    <tr>
        <th>NAME</th>
        <th>PRICE</th>
        <th>IN STOCK</th>
    </tr>
    <tr th:each="prod, iterStat : ${prods}" th:class="${iterStat.odd}? 'odd'">
        <td th:text="${prod.name}">Onions</td>
        <td th:text="${prod.price}">2.41</td>
        <td th:text="${prod.inStock}? #{true} : #{false}">yes</td>
    </tr>
</table>
```

Because with ```prods``` - ```java.util.List``` object, we can iterate a set of objects. But we can utilize other data structures to iterate by using ```th:each```.
- Any object implementing ```java.util.Iterable```
- Any object implementing ```java.util.Map```. When iterating maps, iter variables will be of class java.util.Map.Entry.
- Any array
- Any other object will be treated as if it were a single-valued list containing the object itself.

When using ```th:each```, Thymeleaf offers a mechanism useful for keeping track of the status of your iteration: the status variable.

Status variables are defined within a ```th:each``` attribute and contain the following data:
- The current iteration index, starting with 0. This is the ```index``` property.
- The current iteration index, starting with 1. This is the ```count``` property.
- The total amount of elements in the iterated variable. This is the ```size``` property.
- The iter variable for each iteration. This is the ```current``` property.
- Whether the current iteration is even or odd. These are the ```even```/```odd``` boolean properties.
- Whether the current iteration is the first one. This is the ```first``` boolean property.
- Whether the current iteration is the last one. This is the ```last``` boolean property.

In order to use the status variable in ```th:each``` attribute, we can exert two ways to declare it.
- In ```th:each``` attribute, Writing status variable name such as ```iterStat``` after the iteration variable itself such as ```prod```, separated by a comma.
- Thymeleaf will always create one status variable for you by suffixing ```Stat``` to the name of the iteration variable, for example: ```prodStat```, if we do not explicitly set a status variable.

    ```html
    ...
    <tr th:each="prod : ${prods}" th:class="${prodStat.odd}? 'odd'">
        <td th:text="${prod.name}">Onions</td>
        <td th:text="${prod.price}">2.41</td>
        <td th:text="${prod.inStock}? #{true} : #{false}">yes</td>
    </tr>
    ```

<br>

## Comments and Blocks




<br>

## Recap
- Thymeleaf uses ```/templates``` as root. And in the default ```application.properties```, we have:
    
    ```html
    spring.thymeleaf.prefix=classpath:/templates/
    ```



