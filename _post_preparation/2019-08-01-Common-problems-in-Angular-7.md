---
layout: post
title: Common problems in Angular 7
bigimg: /img/image-header/california.jpg
tags: [Angular]
---


<br>

## Table of contents




<br>

## 




<br>

## Angular validation with required is not working
Angular will add ```novalidate``` attribute to our forms automatically when using the template driven approach.

If you want browser validation then add ngNativeValidate attribute in your form.

```Javascript
<form ngNativeValidate>
    <input type='text' name='projectName' [(ngModel)]='projectName' required >
    <input type='submit' value='submit' />
<form>
```

<br>

## Wrapping up




<br>

Refer:

