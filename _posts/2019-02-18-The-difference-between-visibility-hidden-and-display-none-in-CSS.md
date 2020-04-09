---
layout: post
title: The difference between visibility:hidden and display:none in CSS
bigimg: /img/path.jpg
tags: [Front-End, CSS]
---

When we work on web development, we will cope with some case about hiding elements in our layout. Then, there are two most common ways to hide elements which include using ```display: none``` and ```visibility: hidden```.

<br>

## Table of Contents
- [display: none property](#display:-none-property)
- [visibility: hidden property](#visibility:-hidden-property)
- [Interesting information about visibility: hidden and display: none properties](#interesting-information-about-visibility:-hidden-and-display:-none-properties)
- [Some other ways to hide elements](#some-other-ways-to-hide-elements)

<br>

## display: none property
It will remove the element from the normal flow of the page, allowing other elements to fill in.

It has two specific traits:
- An element will not appear on the page at all but we can still interact with it through the DOM.
- There will be no space allocated for it between the other elements.

<br>

## visibility: hidden property
It will leave the element in the normal flow of the page such that is still occupies space.

It has two specific traits:
- An element is not visible.
- Element's space  is allocated for it on the page.

<br>

## Interesting information about visibility: hidden and display: none properties

When reading about this [link](https://stackoverflow.com/questions/133051/what-is-the-difference-between-visibilityhidden-and-displaynone), we will have a question about performance of the ways to disappear elements in browser.

```visibility: hidden``` and ```display: none``` will be equally performant since they both re-trigger layout, paint and composite. However, ```opacity: 0``` is functionality equivalent to ```visibility: hidden``` and does not re-trigger the layout step.

And css-transition property is also important thing that we need to take care. Because toggling from ```visibility: hidden``` to ```visibility: visible``` allow for css-transitions to be use, whereas toggling from ```display: none``` to ```display: block``` does not. ```visibility: hidden``` has the additional benefit of not capturing javascript events, whereas ```opacity: 0``` captures events.

<br>

## Some other ways to hide elements
- Use ```z-index``` property.

    ```css
    #element {
        z-index: -11111;
    }
    ```
- Move an element off the page.

    ```css
    #element {
        position: absolute; 
        top: -9999em;
        left: -9999em;
    }
    ```

<br>

Thanks for your reading.

Refer:

[http://ageekandhisblog.com/html-css-techniques-for-hiding-elements-and-displaynone-vs-visibilityhidden/](http://ageekandhisblog.com/html-css-techniques-for-hiding-elements-and-displaynone-vs-visibilityhidden/)

[https://medium.com/frontend-fun/css-how-css-display-none-affects-images-on-page-load-dbdf1aaea820](https://medium.com/frontend-fun/css-how-css-display-none-affects-images-on-page-load-dbdf1aaea820)