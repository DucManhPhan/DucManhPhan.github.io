---
layout: post
title: Command syntax in thymeleaf engine 
bigimg: /img/image-header/home-office-1.jpg
tags: [Thymeleaf]
---

In the previous [article](https://ducmanhphan.github.io/2019-02-07-Implementation-with-layout-in-thymeleaf), we have understood a few about utilizing layout with Thymeleaf. But it is not enough knowledege to write front-end easily.

So, to dig into Thymeleaf, in this article, we will continue to learn some syntaxes such as conditional statement, loop statement, ... in Thymeleaf. 

All informations are referenced from this [website](https://www.thymeleaf.org/doc/tutorials/2.1/usingthymeleaf.html) of Thymeleaf.

<br>

## Table of Contents
- [Introduction expression in Thymeleaf](#introduction-expression-in-thymeleaf)
- [Link URLs expression](#link-urls-expression)
- [Messages expression](#messages-expression)
- [Variable expression](#variable-expression)
- [Selection variable](#selection-variable)
- [Conditional operators](#conditional-operators)
- [Conditional evaluation](#conditional-evaluation)
- [Arithmetic operations](#arithmetic-operations)
- [Loop statement](#loop-statement)
- [Recap](#recap)


<br>

## Introduction expression in Thymeleaf
There are some following expressions:
- Simple expression
    - Variable expression: ```${...}```
    - Selection Variable: ```*{...}```
    - Message expression: ```#{...}```
    - Link URLs expression: ```@{...}```
- Literals
    - Text literals: 'one text', 'Another one!',…
    - Number literals: 0, 34, 3.0, 12.3,…
    - Boolean literals: true, false
    - Null literal: null
    - Literal tokens: one, sometext, main,…
- Text operations
    - String concatenation: +
    - Literal substitutions: |The name is ${name}|
- Arithmetic operations:
    - Binary operators: +, -, *, /, %
    - Minus sign (unary operator): -
- Boolean operations:
    - Binary operators: and, or
    - Boolean negation (unary operator): !, not
- Comparisons and equality:
    - Comparators: >, <, >=, <= (gt, lt, ge, le)
    - Equality operators: ==, != (eq, ne)
- Conditional operators:
    - If-then: (if) ? (then)
    - If-then-else: (if) ? (then) : (else)
    - Default: (value) ?: (defaultvalue)

<br>

## Link URLs expression
Syntax: 
- ```@{...}``` of Thymeleaf Standard Dialect.

There are two types of URLs:
- Absolute URLs
- Relative URLs
    - Page-relative, like ```user/login.html```
    - Context-relative, like ```/itemdetails?id=3``` (context name in server will be added automatically)
    - Server-relative, like ```~/billing/processInvoice``` (allows calling URLs in another context (= application) in the same server
    - Protocol-relative URLs, like ```//code.jquery.com/jquery-2.0.3.min.js```

Thymeleaf can handle absolute URLs in any situation, but for relative ones it will require you to use a context object that implements the IWebContext interface, which contains some info coming from the HTTP request and needed to create relative links.

So, we have: 
- ```th:href``` is an attribute modifier attribute: once processed, it will compute the link URL to be used and set the ```href``` attribute of the \<a\> tag to this URL.
- We are allowed to use expressions for URL parameters (as you can see in ```orderId=${o.id}```). The required URL-encoding operations will also be automatically performed.
- If several parameters are needed, these will be separated by commas like ```@{/order/process(execId=${execId},execType='FAST')}```
- Variable templates are also allowed in URL paths, like ```@{/order/{orderId}/details(orderId=${orderId})}```
- Relative URLs starting with ```/``` (like ```/order/details```) will be automatically prefixed the application context name.
- If cookies are not enabled or this is not yet known, a ```";jsessionid=..."``` suffix might be added to relative URLs so that session is preserved. This is called URL Rewriting, and Thymeleaf allows you to plug in your own rewriting filters by using the ```response.encodeURL(...)``` mechanism from the Servlet API for every URL.
- The ```th:href``` tag allowed us to (optionally) have a working static ```href``` attribute in our template, so that our template links remained navigable by a browser when opened directly for prototyping purposes.

```html
<!-- Will produce 'http://localhost:8080/gtvg/order/details?orderId=3' (plus rewriting) -->
<a href="details.html" 
   th:href="@{http://localhost:8080/gtvg/order/details(orderId=${o.id})}">view</a>

<!-- Will produce '/gtvg/order/details?orderId=3' (plus rewriting) -->
<a href="details.html" th:href="@{/order/details(orderId=${o.id})}">view</a>

<!-- Will produce '/gtvg/order/3/details' (plus rewriting) -->
<a href="details.html" th:href="@{/order/{orderId}/details(orderId=${o.id})}">view</a>
```

<br>

## Messages expression
Syntax: ```#{...}```

We will usually use this message expression int ```th:text``` or ```th:utext```. We can pass parameter into message expression through a pair of parentheses.

```html
<p th:utext="#{${welcomeMsgKey}(${session.user.name})}">
    Welcome to our grocery store, Sebastian Pepper!
</p>
```

So, the value of ```${session.user.name}``` will be passed to the message expression.

<br>

## Variable expression
Syntax: ```${...}```

It is in fact OGNL (Object-Graph Navigation Language) expressions executed on the map of variables contained in the context.

Some expression basic object includes:
- ```#ctx```: the context object. 
- ```#vars```: the context variable.
- ```#locale```: the context locale.
- ```#httpServletRequest```: the ```HttpServletRequest``` object (only in Web Contexts).
- ```#httpSession```: the ```HttpSession``` object (only in Web Contexts).

```html
<p>Today is: <span th:text="${today}">13 february 2011</span>.</p>
```

means:

```java
ctx.getVariables().get("today");
```

<br>

## Selection variable
Syntax: ```*{...}```

The selection variable is the other way of the variable expression for evaluating a value of expression.

Especially, the asterisk syntax evaluates expressions on selected objects rather than on whole context variables map. As long as there is no selected object, the dollar ```$``` and the asterisk ```*``` syntaxes do exactly the same.

```html
<div th:object="${sesson.user}">
    <p>Name: <span th:text="*{firstName}"></span></p>
    <p>Name: <span th:text="*{lastName}"></span></p>
    <p>Name: <span th:text="*{nationality}"></span></p>
</div>
```

It is equivalent to:

```html
<div>
    <p>Name: <span th:text="${sesson.user.firstName}"></span></p>
    <p>Name: <span th:text="${sesson.user.lastName}"></span></p>
    <p>Name: <span th:text="${sesson.user.nationality}"></span></p>
</div>
```

When an object selection is in place, the selected object will be also available to dollar expressions as the ```#object``` expression variable:

```html
<div th:object="${sesson.user}">
    <p>Name: <span th:text="${#object.firstName}"></span></p>
    <p>Name: <span th:text="${sesson.user.lastName}"></span></p>
    <p>Name: <span th:text="*{nationality}"></span></p>
</div>
```

<br>

## Conditional operators
Conditional expressions are meant to evaluate only one of two expressions depending on the result of evaluating a condition (which is itself another expression).

```html
<tr th:class="${row.even} ? 'even' : 'old'">
    ...
</tr>
```

Else expressions can also be omitted, in which case a null value is returned if the condition is false:

```html
<tr th:class="${row.even} ? 'alt'">
    ...
</tr>
```

Next, the special kind of conditional operator is a default expression - Elvis operator. It has no ```then``` part.

```html
<div th:object="${session.user}">
    ...
    <p>Age: <span th:text="*{age} ?: '(no age specified)'">15</span></p>
</div>
```

It is completely equivalent to:

```html
<p>Age: <span th:text="*{age} ? *{age} : '(no age specified)'">15</span></p>
```

<br>

## Conditional evaluation
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

## Arithmetic operations
In these operations, we have two ways to use them because of depending on each template engine:

```html
th:with="isEven=(${prodStat.count} % 2 == 0)"
```

Or

```html
th:with="isEven=${prodStat.count % 2 == 0}"
```


<br>

## Comments and Blocks
Some comment styles in Thymeleaf are:
- standard html/xml

    ```html
    <!--Comment to something-->
    ```

- parser-level comment blocks

    ```html
    <!--/* We want to comment something here */-->
    ```


```th:block``` will be used in situation where we want to combine some elements into one block.

```html
<table>
  <th:block th:each="user : ${users}">
    <tr>
        <td th:text="${user.login}">...</td>
        <td th:text="${user.name}">...</td>
    </tr>
    <tr>
        <td colspan="2" th:text="${user.address}">...</td>
    </tr>
  </th:block>
</table>
```


<br>

## Recap
- Thymeleaf uses ```/templates``` as root. And in the default ```application.properties```, we have:
    
    ```html
    spring.thymeleaf.prefix=classpath:/templates/
    ```
- Conditional evaluation is used to select between tags/elements in html/thymeleaf.
- Conditional operator is used to evaluate only one of two expressions depending on the result of evaluating a condition (which is itself another expression). such as:
    ```html
    <tr th:class="${row.even}? 'even' : 'odd'">
        ...
    </tr>
    ```

