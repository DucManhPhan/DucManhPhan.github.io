---
layout: post
title: Some ways to get selector in CSS
bigimg: /img/image-header/home-office-1.jpg
tags: [Front-End]
---

The following table will contains all selectors in CSS that we need.

|       Selector       |          Example        |                  Description                    |
| -------------------- | ----------------------- | ----------------------------------------------- |
| .class               | .intro                  | Selects all elements with class="intro"         |
| #id                  | #firstname              | Selects the element with id="firstname"         |
| *                    | *                       | Selects all elements                            |
| element              | p                       | Selects all \<p\> elements                      |
| element, element     | div, p                  | Selects all \<div\> elements and \<p\> elements |
| element element      | div p                   | Selects all \<p\> elements inside \<div\> elements |
| element > element    | div > p                 | Selects all \<p\> elements where the parent is a \<div\> element |
| element + element    | div + p                 | Selects all \<p\> elements that are placed immediately after \<div\> elements |
| element1 ~ element2  | p ~ ul                  | Selects every \<ul\> element that are preceded by a \<p\> element |
| [attribute]          | [```target```]          | Selects all elements with a ```target``` attribute |
| [attribute = value]  | [```target``` = _blank] | Selects all elements with target="_blank"          |
| [attribute ~= value] | [title ~= flower]       | Selects all elements with a title attribute containing the word "flower" |
| [attribute \|= value]| [lang \|= en]           | Selects all elements with a lang attribute value starting with "en" |
| [attribute \^= value]| a[href \^= "https"]     | Selects every \<a\> element whose href attribute value begins with "https" |
| [attribute \$= value]| a[href \$= ".pdf"] 	 | Selects every \<a\> element whose href attribute value ends with ".pdf" |
| [attribute \*= value]| a[href \*= "w3schools"] | Selects every \<a\> element whose href attribute value contains the substring "w3schools" |
| :active              | a:active                | Selects the active link. | 
| ::after              | p:after                 | Insert something after the content of each \<p\> element. |
| ::before             | p:before                | Insert something before the content of each \<p\> element | 
| :checked             | input:checked           | Selects every checked \<input\> elements |


<br>

Thanks for your reading. 

Refer: 

[https://www.w3schools.com/cssref/css_selectors.asp](https://www.w3schools.com/cssref/css_selectors.asp)