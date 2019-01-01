---
layout: post
title: Learn basic bootstrap - part 2
bigimg: /img/image-header/ravashing-beach.jpg
tags: [bootstrap]
---

In this article, we will continue find out something about bootstrap 4. 

## Table of Contents

- [Menu](#menu)
- [Jumbotron](#jumbotron)
- [Collapse with button](#collapse-with-button)
- [Pagination](#pagination)
- [Form](#form)

<br>

## Menu
In bootstrap 4, there are two types of menu. It includes: 
- horizontal menu
- vertical menu

To make horizontal menu, add the **.nav** class to a <ul> element, followed by **.nav-item** for each <li> and add the **.nav-link** class to their links.

To make the vertical menu, add the **.flex-column** class into the <ul> element that is behind the **.nav** class.

Ex:

```html
 <ul class="nav">
  <li class="nav-item">
    <a class="nav-link" href="#">Html</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#">Javascript</a>
  </li>
</ul> 
```

To make the tabs, you can add the **.nav-tabs** class in <ul> element. 

<br>

## Jumbotron
A jumbotron indicates a big grey box for calling extra attention to some special content or information.

Use **.jumbotron** or **.jumbotron-fluid** classes to create a jumbotron. Inside of **.jumbotron-fluid**, you can insert the **.container** or **.container-fluid** classes to make a full-width jumbotron without rounded borders.

Ex:

```html
<div class="jumbotron jumbotron-fluid">
  <div class="container">
    ...
  </div>
</div>
```

<br>

## Collapse with button
When you want to hide the contents of the other elements, you can use **.collapse** class. 

To control (show/hide) the collapsible content, add the **data-toggle="collapse"** attribute to an \<a\> or a \<button\> element. Then add the **data-target="#id"** attribute to connect the button with the collapsible content (<div id="demo">).

Ex: 

```html
<button data-toggle="collapse" data-target="#collapsedElement">Click</button>

<div id="collapsedElement" class="collapse">
  ...
</div>
```

<br>

## Pagination

Pagination is used to go to the other pages in website quickly. The pagination have the image: 

![Pagination in Bootstrap 4](../img/bootstrap-course/Pagination.png)

To create a basic pagination, add the **.pagination** class to an <ul> element. Then add the **.page-item** to each <li> element and a **.page-link** class to each link inside <li>:

About adjusting the size of pagination, you have some classes such as **pagination-sm**, **pagination-lg**. 


Ex: 

```html
<ul class="pagination pagination-sm justify-content-left">
  <li class="page-item disabled"><a class="page-link" href="#">1</a></li>
  <li class="page-item"><a class="page-link" href="#">1</a></li>
  <li class="page-item active"><a class="page-link" href="#">2</a></li>
  <li class="page-item"><a class="page-link" href="#">...</a></li>
  <li class="page-item"><a class="page-link" href="#">Final</a></li>
</ul>
```

<br>

## Form

Bootstrap has 3 ways to arrange the elements in the form.
- Use **.form-group** to organize elements vertically
- Use **.form-inline** to organize element horizontally
- Put the elements into the Grid system, you can use the **.form-row** class.

Ex:

```html
<form>
<!-- Vertically -->
<div class="form-group">
    <label for="myEmail">Email</label>
    <input type="email" id = "myEmail" class="form-control" placeholder="Email">
    <label for="myPassword">Password</label>
    <input type="password" id="myPassword" class="form-control" placeholder="Password">
    <button type="submit" class="btn btn-primary">Submit</button>
</div>
</form>
```

```html
<form>
   <!-- Horizontally -->
   <div class="form-inline">
      <label for="myEmail">Email</label>
      <input type="email" id="myEmail" class="form-control" placeholder="Email">
      <label for="myPassword">Password</label>
      <input type="password" id="myPassword" class="form-control" placeholder="Password">
      <button type="submit" class="btn btn-primary">Submit</button>
   </div>
</form>
```

```html
<form>
   <!-- Grid -->
   <div class="row">
      <div class="col-6 col-sm-4">
         <input type="text" class="form-control" placeholder=".col-6 .col-sm-4">
      </div>
      <div class="col-6 col-sm-8">
         <input type="text" class="form-control" placeholder=".col-6 .col-sm-8">
      </div>
   </div>
</form>
```

```html
<form>
   <!-- Grid - form-row -->
   <div class="form-row">
      <div class="col-6 col-sm-4 form-group">
         <label>Product Code</label>
         <input type="text" class="form-control" placeholder=".col-6 .col-sm-4">
      </div>
      <div class="col-6 col-sm-8 form-group">
         <label>Product Name</label>
         <input type="text" class="form-control" placeholder=".col-6 .col-sm-8">
      </div>
   </div>
</form>
```

The following are the controls that is used in the form. 
- Use **.btn** class with type=button\|reset\|submit for button control.
- Use **form-check-input**, **.form-check-label** classes with type=checkbox\|radio to make the checkbox or radio for input control.
- Use **form-control** class with type=text\|password\|email\|search\|url\|tel\|number\|color\|date\|time\|datetime-local\|month\|week for input control.
- Use **.form-control-file** class with type=file.
- Use **.form-control-range** class with type=range.


Thanks for your reading.