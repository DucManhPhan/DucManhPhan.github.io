---
layout: post
title: Some common problems and avoid them in BEM/CSS
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Front-End, CSS]
---

When we work with BEM methodology in CSS, we have some problems about nesting elements in blocks, changing the states of some elements ... It makes our code difficult to read, the code is longer than before.

So, in this article, we will find solutions for each problem. All information is refereced at website [https://www.smashingmagazine.com](https://www.smashingmagazine.com/2016/06/battling-bem-extended-edition-common-problems-and-how-to-avoid-them/).

<br>

## Table of contents
- [Grandchildren selectors](#grandchildren-selectors)
- [Cross component ... components](#cross-component-...-componenets)
- [Modifiers or a new component](#modifiers-or-a-new-component)
- [How To Handle States](#how-to-handle-states)
- [How to nest component](#how-to-nest-component)

<br>

## Grandchildren selectors
Normally, assumed that we have a code segment: 

```css
<div class="card">
    <div class="card__header">
        
        <h2 class="card__header__title">Title text here</h2>
    
    </div>
    <div class="card__body">
        
        <img class="card__body__img" src="some-img.png">
        
        <p class="card__body__text">Lorem ipsum dolor sit amet, consectetur</p>
        <p class="card__body__text">Adipiscing elit.
            <a href="/somelink.html" class="card__body__text__link">Pellentesque amet</a>
        </p>

    </div>
</div>
```

When we have many nested component in ```card```, the class names of each component is long, because we have to link the name of component with past ```block__element```s. 

It will look something like: ```parent_child_grandchild_greatgrandchild_greatgreat...grandchild```.

So, we should use double underscore pattern only once in a selector name.

Therefore, we have a right way.

```css
<div class="card">
    <div class="card__header">
        
        <h2 class="card__title">Title text here</h2>
    
    </div>
    <div class="card__body">
        
        <img class="card__img" src="some-img.png">
        
        <p class="card__text">Lorem ipsum dolor sit amet, consectetur</p>
        <p class="card__text">Adipiscing elit.
            <a href="/somelink.html" class="card__link">Pellentesque amet</a>
        </p>

    </div>
</div>
```

This means all the descendent elements are only affected by the card block. So, we would be able to move the text and images into ```card_header``` or a new ```card_footer``` element without breaking anything.

<br>

## Cross component... components
This problems means a component's styling or positioning is affected by it's parent container.

Let's assume we want to add a button into the card body of our previous example. 

```css
<div class="c-card">
    <div class="c-card__header">
        <h2 class="c-card__title">Title text here</h3>
    </div>

    <div class="c-card__body">

        <img class="c-card__img" src="some-img.png">
        <p class="c-card__text">Lorem ipsum dolor sit amet, consectetur</p>
        <p class="c-card__text">Adipiscing elit. Pellentesque.</p>

        <!-- Our nested button component -->
        <button class="c-button c-button--primary">Click me!</button>

    </div>
</div>
```

However, what happens if there are a few subtle styling differences such as make elements a bit smaller, rounded corners, ... A solution is to use cross component class.

```css
<div class="c-card">
    <div class="c-card__header">
        <h2 class="c-card__title">Title text here</h3>
    </div>

    <div class="c-card__body">

        <img class="c-card__img" src="some-img.png">
        <p class="c-card__text">Lorem ipsum dolor sit amet, consectetur</p>
        <p class="c-card__text">Adipiscing elit. Pellentesque.</p>

        <!-- My *old* cross-component approach -->
        <button class="c-button c-card__c-button">Click me!</button>

    </div>
</div>
```

The unique styling attributes are applied to ```c-card__button``` which lives in the with the rest of the CSS for card. This means if you decide to remove the card component, the unique button styles are removed with it, without you having to remember to do so. It’s worth putting a comment in your CSS to indicate that it is a cross component style.

But using ```c-car__button``` is violating the Open/Closed principle of component-driven design. Ex: there should be no dependency on another module for aesthetics.

So, the best solution at here is to use a modifier for these small cosmetic differences, because we may well find that we wish to reuse them elsewhere as our project grows. 

Even if you never use those additional classes again, at least you won’t be tied to the parent container, specificity or source order to apply the modifications.

```css
<button class="c-button c-button--rounded c-button--small">Click me!</button>
```

<br>

## Modifiers or a new component
One of the biggest problems is deciding where a component ends and a new one begins.

In the ```c-card``` example, you might later create another component named ```c-panel``` with very similar styling attributes but a few noticeable differences.

But what determines whether there should be two components, ```c-panel``` and ```c-card```, or simply a modifier for ```c-card``` that applies the unique styles?

It’s very easy to over modularise and make everything a component. I recommend starting with modifiers but if you’re finding your specific component CSS file is getting difficult to manage then it’s probably time to break a few of those modifiers out. A good indicator is when you find you’re having to reset all the “Block” CSS to be able to style your new modifier, this to me suggests new component time.

The best way if you work with other developers or designers is to ask them for an opinion. Grab them for a couple of minutes and discuss it. I know it’s a bit of a cop-out answer but on a large application its vital that you all understand what modules are available and agree on exactly what constitutes a component.

<br>

## How To Handle States
This is a common problem, particularly when we're styling a component in an active or open state.

Let’s say our cards have an active state; so, when clicked on, they stand out with a nice border styling treatment. How do you go about naming that class?

We will have two options really: either a standalone state hook or a BEM-like naming modifier at the component level:

```css
<!-- standalone state hook -->
<div class="c-card is-active">
    […]
</div>

<!-- or BEM modifier -->
<div class="c-card c-card--is-active">
    […]
</div>
```

While we like the idea of keeping the BEM-like naming for consistency, the advantage of the standalone class is that it makes it easy to use JavaScript to apply generic state hooks to any component. When you have to apply specific modifier-based state classes with script, this becomes more problematic. It is, of course, entirely possible, but it means writing a lot more JavaScript for each possibility.

## How to nest component
Suppose we want to display a checklist in our c-card component. Here is a demonstation of how not to mark this up:

```css
<div class="c-card">
    <div class="c-card__header">
        <h2 class="c-card__title">Title text here</h3>
    </div>

    <div class="c-card__body">

        <p>I would like to buy:</p>

        <!--A nested component-->
        <ul class="c-card__checklist">
            <li class="c-card__checklist__item">
                <input id="option_1" type="checkbox" name="checkbox" class="c-card__checklist__input">
                <label for="option_1" class="c-card__checklist__label">Apples</label>
            </li>
            <li class="c-card__checklist__item">
                <input id="option_2" type="checkbox" name="checkbox" class="c-card__checklist__input">
                <label for="option_2" class="c-card__checklist__label">Pears</label>
            </li>
        </ul>

    </div>  <!-- .c-card__body -->
</div>      <!-- .c-card -->
```

We have a couple of problems here. One is the grandparent selector that we covered in section 1. The second is that all of the styles applied to ```c-card__checklist__item``` are scoped to this specific use case and won’t be reusable.

Our preference here would be to break out the list itself into a layout module and the checklist items into their own components, enabling them to be used independently elsewhere. This brings our ```l-``` namespacing back into play as well:

```css
<div class="c-card">
    <div class="c-card__header">
        <h2 class="c-card__title">Title text here</h3>
    </div>

    <div class="c-card__body"><div class="c-card__body">

        <p>I would like to buy:</p>

        <!-- Much nicer - a layout module -->
        <ul class="l-list">
            <li class="l-list__item">

                <!-- A reusable nested component -->
                <div class="c-checkbox">
                    <input id="option_1" type="checkbox" name="checkbox" class="c-checkbox__input">
                    <label for="option_1" class="c-checkbox__label">Apples</label>
                </div>

            </li>
            <li class="l-list__item">

                <div class="c-checkbox">
                    <input id="option_2" type="checkbox" name="checkbox" class="c-checkbox__input">
                    <label for="option_2" class="c-checkbox__label">Pears</label>
                </div>

            </li>
        </ul>
        <!-- .l-list -->

    </div>  <!-- .c-card__body -->
</div>      <!-- .c-card -->
```

This saves us from having to repeat the styles, and it means we can use both the l-list and c-checkbox in other areas of our application. It does mean a little more markup, but it’s a small price to pay for readability, encapsulation and reusability. You’ve probably noticed these are common themes!


Thanks for your reading.

Refer:

[http://webuniverse.io/css-organization-naming-conventions-and-safe-extend-without-preprocessors/#To_extend_or_not_to_extend?](http://webuniverse.io/css-organization-naming-conventions-and-safe-extend-without-preprocessors/#To_extend_or_not_to_extend?)

[https://www.smashingmagazine.com/2016/06/battling-bem-extended-edition-common-problems-and-how-to-avoid-them/](https://www.smashingmagazine.com/2016/06/battling-bem-extended-edition-common-problems-and-how-to-avoid-them/)