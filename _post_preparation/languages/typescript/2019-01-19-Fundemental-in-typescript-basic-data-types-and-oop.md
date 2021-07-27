---
layout: post
title: Fundemental in Typescript - Basic data types and OOP
bigimg: /img/image-header/home-office-1.jpg
tags: [Typescript]
---

Before Javascript is used only for client side, nowadays, it can used in server side with Node.js environment.

<br>

## Table of contents
- [Basic Data Types](#basic-data-types)
- [Object Oriented Programming](#object-oriented-programming)
- [Wrapping up](#wrapping-up)


<br>

## Basic Data Types
The following is basic data types that we need to know:
- ```boolean```

    It has two values: true / false.

    For example: 
    ```javascript
    let isDone : boolean = false;
    ```

- ```number```

    All numbers in Typescript are floating point values. In addition to hexadecimal and decimal literals, TypeScript also supports binary and octal literals introduced in ECMAScript 2015.

    For example:
    ```javascript
    let decimal : number = 6;
    let hex: number = 0xf00d;
    let binary: number = 0b1010;
    let octal: number = 0o744;
    ```

- ```string```

    To represent a variable is a string, we can use double quotes ("), single quotes ('), and template string - use backtick/backquote (`) character.

    With template string, we can embedded expression are of the form ```${expr}```.

    For example: 
    ```javascript
    let color : string = 'blue';
    let sentence : string = `Hello, ${fullName}`;
    let address : string = "Washington DC";
    ```

- ```Array```

    There are two ways to express array of values:
    - Use the type of the elements followed by ```[]```.

        ```javascript
        let list: number[] = [1, 2, 3];
        ```

    - Usea generic array type - ```Array<elemType>```.

        ```javascript
        let list: Array<number> = [1, 2, 3];
        ```

- Tuple

    Tuple types allow you to express an array where the type of a fixed number of elements is known, but need not be the same. 

    ```javascript
    // Declare a tuple type
    let x: [string, number];

    // Initialize it
    x = ["hello", 10]; // OK

    // Initialize it incorrectly
    x = [10, "hello"]; // Error

    console.log(x[0].substr(1)); // OK
    console.log(x[1].substr(1)); // Error, 'number' does not have 'substr'    
    ```

    When accessing an element outside the set of known indices, a union type is used instead:
    ```javascript
    x[3] = "world"; // OK, 'string' can be assigned to 'string | number'
    console.log(x[5].toString()); // OK, 'string' and 'number' both have 'toString'
    x[6] = true; // Error, 'boolean' isn't 'string | number'
    ```

- ```enum```

    ```javascript
    enum Color {Red, Green, Blue}
    let c: Color = Color.Green;
    ```

    By default, enums begin numbering their members starting at 0.

    A handy feature of enums is that we can also go from a numeric value to the name of that value in the enum.

    ```javascript
    enum Color {Red = 1, Green, Blue}
    let colorName: string = Color[2];

    console.log(colorName); // Displays 'Green' as its value is 2 above
    ```

- ```any```

    When we do not know about the type ofs some interesting variables, for instance, variables from the use or a 3rd in interface party library, we need to use ```any``` data type.

    ```javascript
    let num:    any = 4;
    num = "accepted";
    ```

    And, variables of type ```Object```s have the same influence with ```any``` data type. But ```Object``` type only allow us to assign any value to them,  you can’t call arbitrary methods on them, even ones that actually exist:

    ```javascript
    let notSure: any = 4;
    notSure.ifItExists(); // okay, ifItExists might exist at runtime
    notSure.toFixed(); // okay, toFixed exists (but the compiler doesn't check)

    let prettySure: Object = 4;
    prettySure.toFixed(); // Error: Property 'toFixed' doesn't exist on type 'Object'.
    ```

- ```void```

    There are two ways to use ```void``` type:
    - use for returned value in functions

        ```javascript
        function printSomething() : void {
            ...
        }
        ```

    - Use for declaring variables.

        It is not useful simply because we can only assign ```undefined```, ```null``` for it. 

        ```javascript
        let nothingProb: void = undefined;
        ```

- ```never```

    The ```never``` type represents the type of values that never occur. 

    The ```never``` type is a subtype of, and assignable to, every type; however, no type is a subtype of, or assignable to, ```never``` (except ```never``` itself). Even ```any``` isn’t assignable to ```never```.

    ```javascript
    function printSomething() : never {
            ...
    }
    ```

- ```object```

    ```object``` is a type that represents the non-primitive type, i.e. any thing that is not ```number```, ```string```, ```boolean```, ```symbol```, ```null```, or ```undefined```.

    ```javascript
    declare function create(o: object | null): void;

    create({ prop: 0 }); // OK
    create(null); // OK

    create(42); // Error
    create("string"); // Error
    ```

- Type assertions

    Type assertions are a way to tell the compiler “trust me, I know what I’m doing.” A type assertion is like a type cast in other languages, but performs no special checking or restructuring of data. 
    
    It has no runtime impact, and is used purely by the compiler. TypeScript assumes that you, the programmer, have performed any special checks that you need.

    There are two forms of type assertions:
    - Angle-bracket syntax

        ```javascript
        let someValue: any = "this is a string";
        let strLength: number = (<string>someValue).length;
        ```

    - ```as``` - syntax

        ```javascript
        let someValue: any = "this is a string";

        let strLength: number = (someValue as string).length;
        ```
    When using TypeScript with JSX, only ```as```-style assertions are allowed.
<br>

## Object Oriented Programming
### Interface
Interfaces are used at design time to provide auto completion and at compile time to provide type checking.

```javascript
interface LabeledValue {
    label: string;
}

function printLabel(labeledObj : {label: string}) {
    console.log(labeledObj.label);
}

function printLabelInterface(labeledObj : LabeledValue) {
    console.log(labeledObj.label);
}

let myObj = {size: 10, label: "Size 10 Object"};
printLabel(myObj);
```

With the above example, the type checker checks the call to ```printLabel()```. The ```printLabel()``` function has a single parameter that requires that the object passed in has a property called ```label``` of type ```string```. Our object actually has more properties than this, but the compiler only checks that at least the ones present and match the types required. There are some cases where Typescript isn't as lenient.

Typescript also supports some interesting features in interface:
- Optional properties

    ```javascript
    interface SquareConfig {
        color?: string;
        width?: number;                            
    }

    function createSquare(config: SquareConfig) : {color: string, area: number} {
        let newSquare = {color: "white", area: 100};

        if (config.color) {
            newSquare.color = config.color;
        }

        if (config.with) {
            // Error: Property 'with' does not exist on type 'SquareConfig'
            newSquare.area = config.with * config.with;
        }

        return newSquare;
    }
    ```

    These optional properties are popular when creating patterns like **option bags** where we can pass an object to a function that **only has a couple of properties filled in**.

    The advantage of optional properties is that we can describe these possibly available properties while still also preventing use of properties that are not part of the interface. 

    For example, had we mistyped the name of the ```width``` property in **createSquare()**.

- Function types
- Array types
- Class types
- Extending interfaces
- Hybrid types




<br>

### Class
Some key features for classes in Typescript:
- Inheritance
- Private / public modifiers
- Accessors
- Static properties
- Constructor functions
- Using class as an interface



<br>

## Wrapping up






<br>

Thanks for your reading.

<br>

Refer:

[https://www.typescriptlang.org/docs/handbook/basic-types.html](https://www.typescriptlang.org/docs/handbook/basic-types.html)

[https://codeburst.io/understanding-typescript-basics-e003dbad2191](https://codeburst.io/understanding-typescript-basics-e003dbad2191)

[https://angularfirebase.com/lessons/typescript-the-basics/](https://angularfirebase.com/lessons/typescript-the-basics/)

[https://angularfirebase.com/lessons/object-oriented-programming-with-typescript/](https://angularfirebase.com/lessons/object-oriented-programming-with-typescript/)