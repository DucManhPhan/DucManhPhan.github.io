---
layout: post
title: Transfer data among components in Angular
bigimg: /img/image-header/california.jpg
tags: [Angular]
---

When we're working with Angular, we need to learn how to divide UI into many components, and learn how to communicate between components. 

The first problem, how to split UI into components, it will be talked at the other article. 

So, in this article, we will focus on the communication among components in Angular. There are four different methods for sharing data between Angular components.

![Parent-child-sibling](../img/Angular-architecture/sharing-data-components/parent-child-sibling-components.png)

<br>

## Table of contents
- [Parent to Child: Sharing Data via ```@Input```](#parent-to-child-sharing-data-via-@input)
- [Child to Parent: Sharing Data via using local variable](#child-to-parent-sharing-data-via-using-local-variable)
- [Child to Parent: Sharing Data via ```@ViewChild```](#child-to-parent-sharing-data-via-@viewchild)
- [Child to Parent: Sharing Data via ```@Output``` and EventEmitter](#child-to-parent-sharing-data-via-@output-and-eventemitter)
- [Unrelated Components: Sharing Data with a Service](#unrelated-components-sharing-data-with-a-service)
- [Wrapping up](#wrapping-up)


<br>

## Parent to Child: Sharing Data via ```@Input```
To transfer data from parent component to child component, we will use ```@Input()``` decorator for variables in child component's ts file.

For example: 

At ```child.component.ts```, we have:

```javascript
import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-child',
  templateUrl: './child.component.html',
  styleUrls: ['./child.component.scss']
})
export class ChildComponent implements OnInit {

  constructor() { }

  ngOnInit() {
  }

  @Input() childMessage: string;
}
```

At ```child.component.html```, 

```html
<p>Say: {{childMessage}}</p>
```

At ```parent.component.ts```, we have:

```javascript
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-parent',
  templateUrl: './parent.component.html',
  styleUrls: ['./parent.component.scss']
})
export class ParentComponent implements OnInit {

  constructor() { }

  ngOnInit() {
  }

  parentMessage = "This is the message from parent.";

}
```

At ```parent.component.html```, 

```html
<app-child [childMessage]="parentMessage"></app-child>
```

At ```app.component.html```, 

```html
<app-parent></app-parent>
```

<br>

## Child to Parent: Sharing Data via using local variable

Refer: [https://angular.io/guide/component-interaction#parent-interacts-with-child-via-local-variable](https://angular.io/guide/component-interaction#parent-interacts-with-child-via-local-variable)


<br>

## Child to Parent: Sharing Data via ```@ViewChild```
The previous section we used a way through using local variable. But it is limited simply because the parent-child wiring must be done entirely within the parent template. The parent component itself has no access to the child.

We can not use the local variable technique if an instance of the parent component class must read or write child component or must call child component methods.

So, in this section, we will inject the child component into the parent as a ```@ViewChild()```.

But the parent component will be implemented ```AfterViewInit``` lifecycle hook. The child component is not available until after Angular displays the parent view. Then Angular calls the ```ngAfterViewInit``` at which time it is too late to update the parent view's display of child component.

For example: 

In ```child.component.ts```, we have:

```javascript
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-child',
  templateUrl: './child.component.html',
  styleUrls: ['./child.component.scss']
})
export class ChildComponent implements OnInit {

  constructor() { }

  ngOnInit() {
  }

  childMessage : string = "This is message from child component.";
}
```

In ```parent.component.ts```, 

```javascript
import { Component, OnInit, ViewChild, AfterViewInit  } from '@angular/core';

import {ChildComponent} from './child/child.component';

@Component({
  selector: 'app-parent',
  templateUrl: './parent.component.html',
  styleUrls: ['./parent.component.scss']
})
export class ParentComponent implements AfterViewInit  {

  @ViewChild(ChildComponent) 
  private child: ChildComponent;

  parentMessage: string;

  constructor() { }

  ngAfterViewInit() {
    this.parentMessage = this.child.childMessage;
  }
}
```

In ```parent.component.html```, we have:

```html
<p>
  Parent contains message from Child: {{parentMessage}}
</p>
<app-child></app-child>
```

Note: In our ```parent.component.html```, we need to insert ```<app-child></app-child>```. 

<br>

## Child to Parent: Sharing Data via ```@Output``` and EventEmitter
Another way to share data is to emit data from the child, which can be listed to by the parent. This approach is ideal when you want to share data changes that occur on things like button clicks, form entires, and other user events.

In the parent, we create a function to receive the message and set it equal to the message variable.

In the child, we declare a ```messageEvent``` variable with the ```Output``` decorator and set it equal to a new event emitter. Then we create a function named ```sendMessage``` that calls emit on this event with the message we want to send. Lastly, we create a button to trigger this function.

The parent can now subscribe to this messageEvent that’s outputted by the child component, then run the receive message function whenever this event occurs.

For example: 


<br>

## Unrelated Components: Sharing Data with a Service
[https://stackoverflow.com/questions/50371582/angular-6-passing-messages-via-service-to-from-component-to-message-component](https://stackoverflow.com/questions/50371582/angular-6-passing-messages-via-service-to-from-component-to-message-component)




<br>

## Wrapping up




<br>

Thanks for your reading.

<br>

Refer: 

[https://angularfirebase.com/lessons/sharing-data-between-angular-components-four-methods/](https://angularfirebase.com/lessons/sharing-data-between-angular-components-four-methods/)

[https://medium.com/@pandukamuditha/angular-5-share-data-between-sibling-components-using-eventemitter-8ebb49b64a0a](https://medium.com/@pandukamuditha/angular-5-share-data-between-sibling-components-using-eventemitter-8ebb49b64a0a)

[https://angular.io/guide/component-interaction](https://angular.io/guide/component-interaction)

[https://stackoverflow.com/questions/50371582/angular-6-passing-messages-via-service-to-from-component-to-message-component](https://stackoverflow.com/questions/50371582/angular-6-passing-messages-via-service-to-from-component-to-message-component)