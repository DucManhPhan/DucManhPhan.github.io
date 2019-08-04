---
layout: post
title: Creating custom two way binding in Angular 7
bigimg: /img/image-header/tailor-1.jpg
tags: [Angular]
---

Before moving on this article about custom two way binding, we can read up on [Data binding in Angular](https://ducmanhphan.github.io/2019-08-03-Data-binding-in-Angular/). Then, we will dive into custom two way binding in Angular, and understand about the problems of two way binding, how to reduce it.

Let's get started.

<br>

## Table of contents
- [Custom two way binding](#custom-two-way-binding)
- [The problem of two way binding](#the-problem-of-two-way-binding)
- [Solution to prevent using two way binding](#solution-to-prevent-using-two-way-binding)
- [Wrapping up](#wrapping-up)

<br>

## Custom two way binding
Now, we will create the project about custom two binding with Angular CLI, measuring the modification of counter. If we haven't installed Angular CLI yet, we can use the below command:

```javascript
npm install -g @angular/cli
```

Next, create our own project:

```javascript
ng new custom-two-way-binding --style scss --routing
```

Because we want to use SCSS preprocessor for CSS, so, we will use additional parameters such as ```--style scss```. Then, we can use ```--routing``` to navigate to the other page.

After that, we create the new component such as:

```javascript
ng g c custom-counter
```

Fill all the below codes looks like this.

```html
<!-- custom-counter.component.html -->
<div class="content">
  <button (click)="decrement()">-</button>
  <span class="content-number" >{{counter}}</span>
  <button (click)="increment()">+</button>
</div>
```

```css
// custom-counter.component.scss
.content {
    border: solid 1px white;
    margin: 40px;

    .content-number {
        color: dark;
        margin: 0 15px;
    }
}
```

```javascript
import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-custom-counter',
  templateUrl: './custom-counter.component.html',
  styleUrls: ['./custom-counter.component.scss']
})
export class CustomCounterComponent implements OnInit {

  counterValue = 0;

  @Input()
  get counter() {
    return this.counterValue;
  }

  @Output()
  counterChange = new EventEmitter();

  constructor() { }

  ngOnInit() {
  }

  set counter(val) {
    this.counterValue = val;
    this.counterChange.emit(this.counterValue);
  }

  decrement() {
    --this.counterValue;
    this.counterChange.emit(this.counterValue);
  }

  increment() {
    ++this.counterValue;
    this.counterChange.emit(this.counterValue);
  }

}
```

The above code is the code of ```CustomCounterComponent```. To implement two way binding, we will use ```@Input()``` and ```EventEmitter``` to do. Whenever we change the ```counterValue``` variable, we also must fire the change event to notify for parent component that contains child component - ```CustomCounterComponent```.

Continuously, we will see the source code in ```app.component.ts``` and ```app.component.html```.

```javascript
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  value = 0;
}
```

```html
<app-custom-counter [(counter)]='value'></app-custom-counter>

<p>The value of counter is {{value}}</p>
```

So, we can find that the ```value``` variable of AppComponent will bind to the ```counter``` properties get/set of ```CustomCounterComponent```. So, when ```counter``` is changed by something, it will be reflected to ```value``` of ```AppComponent```.

Source code for this sample here: [https://github.com/DucManhPhan/Learn-Javascript/tree/master/src/Angular/src/custom-two-way-binding](https://github.com/DucManhPhan/Learn-Javascript/tree/master/src/Angular/src/custom-two-way-binding)

- ```@Input()```

    It will be used to mark this variable that will be passed data from parent component.

- ```@Output()``` and ```EventEmitter```

    It is used to know that the task in child component will update value in the parent component.

<br>

## The problem of two way data binding
Before delving into the problem of two-way data binding, we have to understand the ```Change dectection mechanism``` in Angular and AngularJS. Because change dectection is the mechanism responsible for data binding in Angular.

- The first thing is to be aware of the Angular tree structure.

    An Angular application can be seen as a component tree.

    [https://www.gistia.com/angular-performance-optimization-change-detection/](https://www.gistia.com/angular-performance-optimization-change-detection/)

- Some strategies of Change Detection Mechanism

    - How does Change Detection Mechanism works?



    - ChangeDetectionStrategy.Default

        Whenever data is mutated or changed, Angular will run the change detector to update the DOM.

    - ChangeDetectionStrategy.OnPush

        Angular will only run the change detection when a new reference is passed to ```@Input()``` data.

- 




<br>

## Solution to prevent using two way binding




<br>

## Wrapping up
- AngularJS support two-way data binding, but Angular doesn't support two-way binding any more. ```[(ngModel)]``` is not a two-way data binding, it is only a symbol of the combination between property binding and event binding.

- Angular generates a change detector for every single component.


<br>

Refer:

[https://www.quora.com/What-technique-AngularJS-uses-for-two-way-binding](https://www.quora.com/What-technique-AngularJS-uses-for-two-way-binding)

[https://glebbahmutov.com/blog/improving-angular-web-app-performance-example/](https://glebbahmutov.com/blog/improving-angular-web-app-performance-example/)

[https://dzone.com/articles/understanding-output-and-eventemitter-in-angular](https://dzone.com/articles/understanding-output-and-eventemitter-in-angular)

[https://angular.io/api/core/ChangeDetectionStrategy](https://angular.io/api/core/ChangeDetectionStrategy)

[https://codewithstyle.info/change-detection-angular-versus-angularjs/](https://codewithstyle.info/change-detection-angular-versus-angularjs/)

[https://blog.angular-university.io/how-does-angular-2-change-detection-really-work/](https://blog.angular-university.io/how-does-angular-2-change-detection-really-work/)

[https://blog.angularindepth.com/everything-you-need-to-know-about-change-detection-in-angular-8006c51d206f](https://blog.angularindepth.com/everything-you-need-to-know-about-change-detection-in-angular-8006c51d206f)

[https://blog.angularindepth.com/the-mechanics-of-dom-updates-in-angular-3b2970d5c03d](https://blog.angularindepth.com/the-mechanics-of-dom-updates-in-angular-3b2970d5c03d)

[https://www.gistia.com/angular-performance-optimization-change-detection/](https://www.gistia.com/angular-performance-optimization-change-detection/)

[https://netbasal.com/optimizing-angular-change-detection-triggered-by-dom-events-d2a3b2e11d87](https://netbasal.com/optimizing-angular-change-detection-triggered-by-dom-events-d2a3b2e11d87)