---
layout: post
title: Common problems in JQuery
bigimg: /img/image-header/california.jpg
tags: [Front-End], JQuery
---




<br>

## Table of contents
- [Prevent refresh of page when click button inside form](#prevent-refresh-of-page-when-click-button-inside-form)
- 
- [Wrapping up](#wrapping-up)

<br>

## Prevent refresh of page when click button inside form
For example, we have a form that includes checkbox and button. The problem is that when we clicked button, page will be refresh.

```html
<form action="" class="form-btn">
    <label for="I accept">
        <input type="checkbox" name="I accept" id="ckbox"> Enable button
    </label>

    <div class="btn-submit">
        <input type="submit" id="btn" disabled="disabled" value="Click me">
    </div>
</form>
```

Solution:

```javascript
$(document).ready(function() {
    // first way
    $("#ckbox").click(function() {
        if ($("#btn").is(":disabled")) {
            $("#btn").removeAttr('disabled');
        } else {
            $("#btn").attr('disabled', 'disabled');
        }
    });

    // second way
    $("#ckbox").click(function() {
        if ($("#btn").is(":disabled")) {
            $("#btn").prop('disabled', false);
        } else {
            $("#btn").prop('disabled', true);
        }
    });

    $("#btn").click(function(e) {
        e.preventDefault();

        alert("Hey, what is your name?");
        return false;
    })
});
```

<br>

## 





<br>

## Wrapping up



<br>

Refer:

