---
layout: post
title: Utility in Bootstrap 4
bigimg: /img/path.jpg
tags: [Front-End, Bootstrap]
---

<br>

## Table of contents





<br>

## Spacing
It will be used for responsive margin and padding.

Some breakpoints:
- ```xs``` (<= 576px)
- ```sm``` (>= 576px)
- ```md``` (>= 768px)
- ```lg``` (>= 992px)
- ```xl``` (>= 1200px)

Syntax:

- Use for ```xs```

    ```css
    {property}{sides}-{size}
    ```

- Use for ```sm```, ```md```, ```lg```, and ```xl```

    ```css
    {property}{sides}-{breakpoint}-{size}
    ```

With **propery** is one of ```m``` (margin) or ```p``` (padding).

With **sides** is one of:
- ```t``` (margin-top or padding-top)
- ```b``` (margin-bottom or padding-bottom)
- ```l``` (margin-left or padding-left)
- ```r``` (margin-right or padding-right)
- ```x``` (padding-left and padding-right or margin-left and margin-right)
- ```y``` (padding-top and padding-bottom or margin-top and margin-bottom)
- blank (sets a margin or padding on all 4 sides of the element)

With **size** is one of: 
- ```0``` (sets margin or padding to 0)
- ```1``` (sets margin or padding to .25rem)
- ```2``` (sets margin or padding to .5rem)
- ```3``` (sets margin or padding to 1rem)
- ```4``` (sets margin or padding to 1.5rem)
- ```5``` (sets margin or padding to 3rem)
- ```auto``` (sets margin to auto)


Refer:

[https://www.w3schools.com/bootstrap4/bootstrap_utilities.asp](https://www.w3schools.com/bootstrap4/bootstrap_utilities.asp)

