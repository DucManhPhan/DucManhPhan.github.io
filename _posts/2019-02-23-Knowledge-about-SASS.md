---
layout: post
title: Knowledge about SASS
bigimg: /img/path.jpg
tags: [Front-End, SASS]
---

To write CSS professionally, we have to learn one of the CSS preprocessor like SASS, SCSS, LESS, ... Because when using one of them, we do not repeat code, easily maintain CSS code, ...

So, in this article, we will discuss about SASS preprocessor.

<br>

## Table of contents
- [Introduction to SASS](#introduction-to-sass)
- [Nested Rules](#nested-rules)
- [Import files](#import-files)
- [Variables](#variables)
- [Use @mixin](#use-@mixin)
- [Function in SASS](#function-in-sass)
- [Extend properties in SASS](#extend-properties-in-sass)
- [Placeholder in SASS](#placeholder-in-sass)
- [Condition statements](#condition-statements)
- [Loop statement](#loop-statement)
- [Functions for processing number](#functions-for-processing-number)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to SASS
SASS is an acronym of *Syntactically Awesome Stylesheets*, and is an extension of CSS that adds power and elegance to the basic language. It allows us to use variables, nested rules, mixins, inline imports, and more, all with a fully CSS-compatible syntax. 

The coding convention of SASS is as same as with CSS. It also have curly bracket to include all properties of elements, and use semicolon to end up code of properties, and some the other things.

Beside SASS syntaxes in SASS, there is a SCSS syntaxes. So, we will have some differences between SASS syntaxes and SCSS syntaxes.
- Sass is an extension of CSS3, adding nested rules, variables, mixins, selector inheritance, and more. It’s translated to well-formatted, standard CSS using the command line tool or a web-framework plugin.
- Sass has two syntaxes. The new main syntax (as of Sass 3) is known as “SCSS” (for “Sassy CSS”), and is a superset of CSS3’s syntax. This means that every valid CSS3 stylesheet is valid SCSS as well. SCSS files use the extension .scss.
- The second, older syntax is known as the indented syntax (or just “Sass”). Inspired by Haml’s terseness, it’s intended for people who prefer conciseness over similarity to CSS. Instead of brackets and semicolons, it uses the indentation of lines to specify blocks. Although no longer the primary syntax, the indented syntax will continue to be supported. Files in the indented syntax use the extension .sass.


<br>

## Nested Rules
SASS will let us nest our CSS selectors in a way that follows the same visual hierarchy of our HTML. 

Be aware that overly nested rules will result in over-qualified CSS that could prove hard to maintain and is generally considered bad practice.

```html
<nav> 
    <ul>
        <li><a href="#">Home</a></li>
        <li><a href="#">Language</a></li>
        <li><a href="#">Technologies</a></li>
        <li><a href="#">About me</a></li>
    </ul>
</nav>
```

```css
nav {
  ul {
    margin: 0;
    padding: 0;
    list-style: none;
  }

  li { display: inline-block; }

  a {
    display: block;
    padding: 6px 12px;
    text-decoration: none;
  }
}
```

<br>

## Import files
When our css file is more bigger than before, we have to think about splitting up css files into smaller files. Because it keeps things easier to maintain.

A convention name of Sass file is with a leading underscore. We might name it something like ```_partial.scss```.

The underscore lets Sass know that the file is only a partial file and that it should not be generated into a CSS file. Sass partials are used with the ```@import``` directive.

The drawback of using ```@import``` is that each time we use ```@import``` in CSS it creates another HTTP request. 

Sass builds on top of the current CSS ```@import``` but instead of requiring an HTTP request, Sass will take the file that you want to import and combine it with the file you're importing into so you can serve a single CSS file to the web browser.

For example:

```css
/* _reset.scss */
html,
body,
ul,
ol {
  margin:  0;
  padding: 0;
}
```

```css
/* base.scss */
body {
  font: 100% Helvetica, sans-serif;
  background-color: #efefef;
}
```

<br>

## Variables
Syntax:

```css
$variable_name: value;
```

Example: 

```css
$bkgr-color: #ffffff;
```

<br>

## Use @mixin
In programming language, using function will make our program do not repeat so much time again. Our program will easily maintain, readable, apply **Don't Repeat Yourself** principle, and **Keep It Simple, Stupid** principle in SOLID.

So, in CSS, using ```@mixin``` will play the same role with function in Programming.

Syntax:
- No parameters

    ```css
    @mixin mixin_name {
        ...
    }
    ```

- Parameters

    ```css
    @mixin mixin_name(parameter_list) {
        ...
    }
    ```

- Using ```@mixin```

    ```css
    @include mixin_name
    ```

Example for mixin:
- No parameters

    **SASS file**

    ```css
    @mixin menu{
        #menu 
        {
            a {
                background: #333;
                text-decoration: none;
            }
            
            li {
                height: 30px;
                line-height: 30px;
            }
        }
    }
 
    @include menu;
    ```

    **CSS file**

    ```css
    #menu a {
        background: #333;
        text-decoration: none; 
    }
 
    #menu li {
        height: 30px;
        line-height: 30px; 
    }
    ```

- Parameters
    
    **SASS file**

    ```css
    @mixin nav($backgroud, $color){
        background: $backgroud;
        color: $color;
    }
    
    .nav{
        @include nav(red, white);
        border: solid 1px;
    }
    ```

    **CSS file**

    ```css
    .nav {
        background: red;
        color: white;
        border: solid 1px; 
    }
    ```

- Default parameters

    ```css
    @mixin nav($backgroud, $color : white){
        background: $backgroud;
        color: $color;
    }
    
    .nav{
        @include nav(red);
        border: solid 1px;
    }
    ```

- Pass parameter's name that is as same as variable's name

    ```css
    @mixin nav($background, $color){
        background: $background;
        color: $color;
    }
    
    .nav{
        @include nav($color : blue, $background : red);
        border: solid 1px;
    }
    ```

- Insert additional properties into ```@mixin```

    ```css
    @mixin nav($border){
        border: $border;
        @content;
    }
    
    .nav{
        @include nav(solid 1px red 1231 ){
            padding: 20px;
        };
    }
    ```

    After finding out about ```@mixin```, we see that ```@mixin``` is used to combined a code segment into one. It is as same as ```procedure``` in programming language, because it does not return value.

<br>

## Function in SASS
Syntax: 

```css
@function function_name($first_var, $second_var, ...) {
    ...

    @return value;
}
```

Using ```@function```, **we have to return value**. If we do not want to return value, using ```placeholder``` or ```@mixin```.

<br>

## Extend properties in SASS
To get an example about extend in SASS, we will think about buttons's other styles such as ```.btn-success```, ```.btn-primary```, ```.btn-danger```, ...

All buttons will have common properties, and each button still has the other properties such as ```background-color```, ...

Example for button in Bootstrap:
- SCSS file will have:

    ```css
    .btn {
        border: solid 1px;
        text-align: center;
        font-size: 16px;
        padding: 20px 10px;
    }

    .btn-primary {
        @extend .btn;
    }

    .btn-success {
        @extend .btn;
        background-color: blue;
    }

    .btn-danger {
        @extend .btn;
        background-color: yellow;
    }
    ```

- After compiled, CSS file will have:

    ```css
    .btn, .btn-primary, .btn-success, .btn-danger {
        border: solid 1px;
        text-align: center;
        font-size: 16px;
        padding: 20px 10px;
    }   

    .btn-success {
        background-color: blue;
    }

    .btn-danger {
        background-color: yellow;
    }
    ```

Finally, we will have hierarchical inheritance.

**SCSS file**

```css
.floatLeft {
    float: left;
    width: 50%;
}

.columnLeft {
    @extend .floatLeft;
    backgroud: #ffffff;
}

.boxLeft {
    @extend .columnLeft;
    color: #000;
}
```

**CSS file**

```css
.floatLeft, .columnLeft, .boxLeft {
  float: left;
  width: 50%; 
}
 
.columnLeft, .boxLeft {
  backgroud: #ffffff; 
}
 
.boxLeft {
  color: #000; 
}
```


<br>

## Placeholder in SASS
In the above section - **Extend properties in SASS**, we will find that ```.btn``` is redundant. Because we will not use it in html.

```html
<button class="btn-primary">Click me</button>
<button class="btn-success">Here</button>
```

So, to reduce this problem, we will use ```PlaceHolder```, then, SASS will not compile this ```.btn``` to selector of CSS.

Syntax of PlaceHolder:

```css
%placerName {
    ...
}
```

Using placeholder, we have:

**SCSS file"

```css
%btn {
    border: solid 1px;
    text-align: center;
    font-size: 16px;
    padding: 20px 10px;
}

.btn-primary {
    @extend .btn;
}

.btn-success {
    @extend .btn;
    background-color: blue;
}

.btn-danger {
    @extend .btn;
    background-color: yellow;
}
```

After compiled SASS file, we have:

**CSS file**

```css
.btn-primary, .btn-success, .btn-danger {
    border: solid 1px;
    text-align: center;
    font-size: 16px;
    padding: 20px 10px;
}   

.btn-success {
    background-color: blue;
}

.btn-danger {
    background-color: yellow;
}
```

When we will not use selector in html, we will declare this selector is placeholder.

<br>

## Condition statements
Syntax:

- Using if ... else

    ```css
    @if ($condition) {
        ...
    }
    @else {
        ...
    }
    ```

- Using if ... else if ... else

    ```css
    @if ($first_condition) {
        ...
    }
    @else if ($second_condition) {
        ...
    }
    @else {
        ...
    }
    ```

For example:

```css
$with-nav : 500px;
 
@if ($with-nav < 280px){
    h1 {
        display: none;
    }
}
@else{
    h1 {    
        display: block;
    }
}
```

<br>

## Loop statement
Syntax:
- for statement

    ```css
    @for $i from $begin_value through $end_value {
        ...
    }
    ```

    To get the value of ```$i```, we will use ```#{$i}```.s

    Or

    ```css
    @for $i from $begin_value to $end_value {
        ...
    }
    ```

    With the above loop statement, we will omit the last value - ```$end_value```.

    For example:

    ```css
    @for $i from 1 through 4 {
        #item-#{$i}{
            background: red
        }
    }
    ```

- while statement

    ```css
    @while condition {
        ...
    }
    ```

- each statement

    ```css 
    @each $value in $values {
        ...
    }
    ```

    ```$values``` is a list data type. List data type is an array of values that is splitted up by space. Each value has a curly branket or not.

    Example: 

    ```css
    $borders: "solid 2px" "solid 3px";

    @each $border in $borders {
        .btn {
            border: #{$border};
        }
    }
    ```

    So ```@each``` will used to iterate an array of values, when using for statement, while statement can not do that.

<br>

## Operators
The operators in SASS will be derscribed in the below table:

|        Types          |                   Operators                  |
| --------------------- | -------------------------------------------- |
| Assignment            | :                                            |
| Mathmetical           | + - * / %                                    |
| Comparator            | == != > >= < <=                              |
| Logical               | and or not                                   |
| append string         | +                                            |
| color                 | +                                            | 


## Functions for processing number

|           Funtions            |               Description           |
| ----------------------------- | ----------------------------------- |
| percentage($number)           | transform ```$number``` into percentage (%) |
| round($number)                | |
| ceil($number)                 | | 
| floor($number)                | |
| abs($number)                  | get the absolute value of ```$number``` |
| min($numbers...)              | find min number from ```$numbers``` - list data type |
| max($numbers...)              | find max number from ```$numbers``` - list data type |
| random([$limit])              | create random number that do not reache ```$limit``` |


<br>

## Wrapping up
- All of these are fundamental knowledge about SASS. 
- Beside understanding SASS, we have to master about accessing selectors.

<br>

Thanks for your reading.

Refer: 

[https://medium.com/@awesome_sayrah/introduction-to-sass-scss-and-less-7ff7e494e798](https://medium.com/@awesome_sayrah/introduction-to-sass-scss-and-less-7ff7e494e798)

[https://sass-lang.com/guide](https://sass-lang.com/guide)

[https://freetuts.net](https://freetuts.net)