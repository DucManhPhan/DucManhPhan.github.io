---
layout: post
title: Common problems in Angular 7
bigimg: /img/image-header/california.jpg
tags: [Angular]
---

When I'm newbie to work with Angular, it is difficult to make familiar with it. Because the ways to think about it is really different to compare with using JQuery or the nature javascript.

So, in this article, we will tackle some common problems when using Angular 7.

Let's get started.

<br>

## Table of contents
- [Bind each element in an array to ngModel when using *ngFor](#bind-each-element-in-an-array-to-ngModel-when-using-*ngFor)
- [Angular validation with required is not working](#Angular-validation-with-required-is-not-working)
- [Wrapping up](#wrapping-up)

<br>

## Bind each element in an array to ngModel when using *ngFor
Assuming that we have:

```javascript
// In component file
items: string[];
```

```html
// In *.ts file
<form #myForm="ngForm">
    <table>
        <tr *ngFor="let item of items; let i=index;">
            <td>
                <input name="'item'+i" [(ngModel)]="items[i]"/>
            </td>
        </tr>
    </table>
</form>
```

The problem happens when we use ```[(ngModel)]="item"```, the ```value``` will not binding between the element of ```items``` array and the ```value``` property of ```input```. 

<br>

## Angular validation with required is not working
Angular will add ```novalidate``` attribute to our forms automatically when using the template-driven approach.

If you want browser validation then add ngNativeValidate attribute in your form.

```Javascript
<form ngNativeValidate>
    <input type='text' name='projectName' [(ngModel)]='projectName' required >
    <input type='submit' value='submit' />
<form>
```

In template-driven forms, we can use ```[(ngModel)]``` for each ```input:text``` or ```textarea```.

In reactive forms, we can not use ```[(ngModel)]```.

<br>

## The difference between #name and [(ngModel)]=name in Angular's Form




<br>

## Two-way data binding with primitive types causes lost focus when input changes





<br>

## Wrapping up
- In Angular 2.x or beyond, when we want to update, or set value for some element in html, we have to think of binding ways.

- Reactive forms do not support for ```ngModel```.

<br>

Refer:

[https://angular.io/guide/template-syntax](https://angular.io/guide/template-syntax)

[https://stackoverflow.com/questions/43234559/what-is-the-difference-between-the-name-and-ngmodel-name-in-angular2-form](https://stackoverflow.com/questions/43234559/what-is-the-difference-between-the-name-and-ngmodel-name-in-angular2-form)