---
layout: post
title: Copy object in Javascript
bigimg: /img/path.jpg
tags: [Javascript]
---

Everything in Javascript is object. So, the need to copy the object is enomorous. But the copy is really hard work, and it has so many problems in the copy. There are two types in copying object, it includes shadow copy and deep copy.

- With object in Javascript, it is a reference. So when we use the assignment operator, the two reference variable will refer to the same location in memory. It is called shadow copy.
- Deep copy means every properties in the objects has the same value, but the objects refer to the other locations in memory.

In this article, we will look at some ways the real copy object.

<br>

## Table of contents
- [Use Object.assign](#use-object.assign)
- [Use JSON.parse and JSON.stringify](#use-json.parse-and-json.stringify)
- [Use for loop to copy](#use-for-loop-to-copy)

<br>

## Use Object.assign
Consider this below code: 

```Javascript
let obj = {
    age: 10, 
    birthYear: 2009, 
    name: "satoshi"
}

let objCopy = Object.assign({}, obj);

console.log(objCopy);
objCopy['age'] = 100;
objCopy['name'] = "Nakamoto";

console.log(objCopy);
console.log(obj);
```

Run the above code. We can see that, it works perfect. Every enumerable properties can be copied to the other object. 

But what are the drawbacks of Object.assign()?

The answer of this question is that with the non-enumerable properties, using Object.assign() will not copied properties of nested object in the other object. 

We can see this example: 

```Javascript
let nestedObj = {
    age: 10, 
    name: "Bitcoin",
    informationBank: {
        address: "Bank of American", 
        number: 12
    } 
}

let nestedObjCopy = Object.assign(nestedObj);

console.log('When not modifying the properties in objects: ');
console.log(nestedObj);
console.log(nestedObjCopy);


nestedObjCopy.informationBank.number = 100;
nestedObjCopy.informationBank.address = "Wall Street";

console.log('When modified the properties: ');
console.log(nestedObj);
console.log(nestedObjCopy);
```

Run this code. We can see the drawback of this method Object.assign().

So, if our object do not contain nested object, you can use this way. 

<br>

## Use JSON.parse and JSON.stringify

```Javascript
let nestedObj = {
    age: 10, 
    name: "Bitcoin",
    informationBank: {
        address: "Bank of American", 
        number: 12
    } 
}

let nestedObjCopy = JSON.parse(JSON.stringify(nestedObj));

console.log('When not modifying the properties in objects: ');
console.log(nestedObj);
console.log(nestedObjCopy);


nestedObjCopy.informationBank.number = 100;
nestedObjCopy.informationBank.address = "Wall Street";

console.log('When modified the properties: ');
console.log(nestedObj);
console.log(nestedObjCopy);
```

It works like a charm. But sometimes, we will wonder about the performance when using the function of JSON.

In order to check the speed of the way: "Using JSON.parse and JSON.stringify", you can see click the website [Deep Copy vs JSON Stringify / JSON Parse](https://jsperf.com/deep-copy-vs-json-stringify-json-parse/5). This website has so many interesting information, so that we can learn so much.

When working with the function of JSON, we need to take care of structure of string that is represented as JSON file. Because when JSON string contains the commas, it will make the error, and we need to handle this exception. 

<br>

## Use for loop to copy

```Javascript
function clone(obj) {
    if (obj == null || typeof(obj) != 'object')
      return obj;
  
    var temp = new obj.constructor();
    for (var key in obj)
      temp[key] = clone(obj[key]);
  
    return temp;
}

let nestedObj = {
    age: 10, 
    name: "Bitcoin",
    informationBank: {
        address: "Bank of American", 
        number: 12
    } 
}

let nestedObjCopy = clone(nestedObj);

console.log('When not modifying the properties in objects: ');
console.log(nestedObj);
console.log(nestedObjCopy);


nestedObjCopy.informationBank.number = 100;
nestedObjCopy.informationBank.address = "Wall Street";

console.log('When modified the properties: ');
console.log(nestedObj);
console.log(nestedObjCopy);
```

It also works correctly. But this way and the recursiveDeepCopy function in the above website also use recursive, so we have to take care of the case of overflow stack. 

Thanks for your reading.

<br>

Refer: 

[Objects in javascript : object.assign/deep copy](https://medium.com/@tkssharma/objects-in-javascript-object-assign-deep-copy-64106c9aefab)

[Deep Copy vs JSON Stringify / JSON Parse](https://jsperf.com/deep-copy-vs-json-stringify-json-parse/5)

[JSON Parse v JSON Stringify](https://medium.com/bluekiri/json-parse-v-json-stringify-4b9d104c78d0)

[11 Ways to Improve JSON Performance & Usage](https://stackify.com/top-11-json-performance-usage-tips/)

[3 Ways to clone objects in Javascript](https://medium.com/@Farzad_YZ/3-ways-to-clone-objects-in-javascript-f752d148054d)