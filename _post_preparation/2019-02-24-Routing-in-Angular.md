---
layout: post
title: Routing in Angular
bigimg: /img/image-header/california.jpg
tags: [Angular]
---


<br>

## Table of contents




<br>

## Introduction to Routing in Angular
Routing in Angular is completely implemented in the client side. When we have specific endpoints, the current component will be transformed to the corresponded component. All essential things is contained in the ```@angular/router``` package. 

```@angular/router``` package defines the ```Route``` object that maps a URL path to a component, and the ```RouterOutlet``` directive that we use to place a routed view in a template, as well as a complete API for configuring, querying, and controlling the router state.

Then, Angular Router has a plethora of feature such as:
- The support for multiple Router outlets which helps us easily add complex routing scenario like nested routing. 
- Various path matching strategies (```prefix``` and ```full```) to tell the Router how to match a specific path to a component.
- Easy access to route parameters and query parameters. 
- Resolvers
- Lazy loading of modules
- Route guards for adding client side protection and allow or disallow access to component or modules, ...

Routing in Angular is also referred to as component routing because the Router maps a single or a herarchy of components to a specific URL.

<br>

## 



Refer:

[https://www.techiediaries.com/angular-router/](https://www.techiediaries.com/angular-router/)

[https://angular.io/api/router/Route](https://angular.io/api/router/Route)

[https://angular.io/api/router/ActivatedRoute](https://angular.io/api/router/ActivatedRoute)

[https://angular.io/api/router/ParamMap](https://angular.io/api/router/ParamMap)