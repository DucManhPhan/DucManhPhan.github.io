---
layout: post
title: Data binding in KnockoutJS
bigimg: /img/image-header/california.jpg
tags: [Front-End, KnockoutJs, Javascript]
---

In this article, we will introduce about data binding in KnockoutJS and some important properties that is used frequently and it is relavant to data binding.

Let's go.

<br>

## Table of contents
- [Data binding with KnockoutJS](#data-binding-with-knockoutjs)
- [Observable in KnockoutJS](#observable-in-knockoutjs)
- [Wrapping up](#wrapping-up)


<br>

## Data binding with KnockoutJS
If we want bind data to some DOM elements, we need to include a ```data-bind``` attribute in the specific tag elements. Or we can even provide a DOM element if we only want to bind this view model to one part of our overall UI.

In KnockoutJS, there are several built-in binding types that we can use for data binding.

|         Binding          |               Description                 |
| ------------------------ | ----------------------------------------- |
| text                     | This binding sets the text the associated element to the value of our parameter. This is the equivalent of setting the ```innterText``` or ```textContent``` property of the DOM element. If our parameter is something other than a number or string, then the binding will assign the results of toString() to the element. |
| html                     | This binding sets the HTML of the associated element to the value of our parameter and is the equivalent of setting the ```innerHTML``` property on the DOM element. If our parameter is something other than a number or string then the binding will assign the results of toString() to the element. |
| value                    | This binding sets the value of the associated to the value of our parameter. This is typically used for form elements like the ```input```, ```select``` and ```textarea```. If our parameter is something other than a number or string then the binding will assign the results of toString() to the element. |
| checked                  | This binding sets the checked state of ```radio buttons``` and ```checkboxes```. For ```checkboxes```, the binding attempts to convert any parameter into a boolean value.  For ```radio buttons```, the binding compares the buttons value attribute to the binding parameter. |
| visible                  | This binding sets the visibility of the associated element based on the binding parameter value. The binding attempts to convert any parameter to a boolean value. |
| enable                   | This binding sets the disabled attribute on the associated element based on the supplied value.  This is typically used for form elements like the input, select and textarea. The binding attempts to convert any parameter to a boolean value. |
| disable                  | This binding sets the disabled attribute on the associated element based on the supplied value and is a mirror image of the enable binding. |
| style                    | This binding sets one or more style values for the associated element. The parameter should be an object whose properties correspond to CSS styles. Typically this parameter value is declared using JSON. |
| css                      | This binding sets one or more CSS classes for the associated element. The parameter should be a JavaScript object where the property names correspond to the desired CSS classes and the property values evaluate to true or false indicating whether the class should be applied. |
| attr                     | This binding sets one or more attributes for the associated element.  The parameter should be a JavaScript object where the property names are the attributes and the property values are the value that will be bound to the attribute. |
| options                  | This binding sets the options which will appear in a drop-down list element.  The value should be an array. | 


<br>

## Observeable in KnockoutJS
To update our UI automatically when the view model changes, we should declare our model properties as observables. 

```javascript
let viewmodel = function(name) {
    this.name = ko.observable(name);
};
```

- Reading and writing observables

    - To read the observable’s current value, just call the observable with no parameters. 

        For example: ```viewmodel.name();```
        
    - To write a new value to the observable, call the observable and pass the new value as a parameter. 

        For example: ```viewmodel.name("Hello, world");```

    - To write values to multiple observable properties on a model object, we can use ```chaining syntax```. For example, ```myViewModel.personName('Mary').personAge(50)``` will change the name value to 'Mary' and the age value to 50.

- Use computed values 

    Sometimes, we need to combine or convert multiple observable values to make others. To handle this, KnockoutJS has a concept of **computed properties** - these are observable (E.x: they notify on change) and they are computed based on the values of other observables.

    For example: In file index.html, we have:

    ```javascript
    <p>First name: <input data-bind="value: firstName"/></p>
    <p>Last name: <input data-bind="value: lastName"/></p>
    <h2>Hello, <span data-bind="text: fullName"></span>!</h2>
               
    <script src="./js/knockout-3.5.0.js"></script>
    <script src="./js/view-model.js"></script>
    ```

    In file view-model.js, we have:

    ```javascript
    let ViewModel = function(first, last) {
        this.firstName = ko.observable(first);//"Google"; 
        this.lastName = ko.observable(last);//"Facebook";

        this.fullName = ko.computed(function() {
            return this.firstName() + " " + this.lastName();
        }, this);
    };

    ko.applyBindings(new ViewModel("Plannet", "Earth"));
    ```

<br>

## Wrapping up
- Remember some important properties in data binding and how to use it.


<br>



Refer:

[https://www.dnnsoftware.com/community-blog/cid/134710/an-introduction-to-knockoutjs-ndash-part-1](https://www.dnnsoftware.com/community-blog/cid/134710/an-introduction-to-knockoutjs-ndash-part-1s)

[https://knockoutjs.com/documentation/binding-syntax.html](https://knockoutjs.com/documentation/binding-syntax.html)

[https://knockoutjs.com/documentation/computedObservables.html](https://knockoutjs.com/documentation/computedObservables.html)