---
layout: post
title: The history of Javascript
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Front-End, Javascript]
---

When we worked with Javascript, we always face the keyword ECMAScript 2015 or ES6 or JS6. We usually have some question about What is ECMAScript or JS6? 

So, in this article, we will discuss about the history of Javascript, What is the role of ECMAScript with Javascript?

## Table of contents
- [Introduction to Javascript](#introduction-to-javascript)
- [History of Javascript](#history-of-javascript)
- [Versions of Javascript](#versions-of-javascript)
- [Scripting Engines](#scripting-engines)

<br>

## Introduction to Javascript
JavaScript is a very powerful client-side scripting language. JavaScript is used mainly for enhancing the interaction of a user with the webpage. In other words, we can make our webpage more lively and interactive, with the help of JavaScript. JavaScript is also being used widely in game development and Mobile application development. 

The language was initially called LiveScript and was later renamed JavaScript. There are many programmers who think that JavaScript and Java are the same. In fact, JavaScript and Java are very much unrelated. Java is a very complex programming language whereas JavaScript is only a scripting language. The syntax of JavaScript is mostly influenced by the programming language C. 

Nowadays, based on environment Node.js, especially Chrome V8 library, Javacript can be applied in the server side. It makes us more conveninent to build many projects that only use one language - Javascript. 

<br>

## History of Javascript
All information of this part is copied in the [link](https://tylermcginnis.com/ecmascript/)

In order to describe the history of Javascript,first of all, we need to talk about Netscape Navigator. Looking back to 1995, Netscape Navigator was the most popular web browser with almost 80% market share. The founder of Netscape, the company behind Netscape Navigator, was Mark Andreessen. He had a vision for the future of the web and it was more than just a way to share and distribute documents. He invisioned a more dynamic platform with client side interactivity - a sort of “glue langauge” that was easy to use by both designers and developers. 

This is where **Brendan Eich** comes into the picture. He was recruited by Netscape with the goal of embedding the **Scheme programming language** into Netscape Navigator. But before he could get started, Nescape collaborated with Sun Microsystems to make their up and coming programming langauge Java available in the browser. Now this brings up the question, "If Java was already a suitable language, why bring on Brendan to create another one?". Well if you remember back to Nescape’s goal, they wanted a scripting langauge that was simple enough for designers and amateurs to use - Java wasn’t that. So the idea became that Java could be used by professionals and **Mocha**, which was the initial name of JavaScript, would be used by everyone else.

Because of this collaboration between languages, Netscape decided that **Mocha** needed to compliment Java and should have a relatively similar syntax. Then, in just 10 days, Brendan created the first version of Mocha which still had some functionality from Scheme, the object orientaiton of **SmallTalk**, and the syntax of Java. Eventually the name **Mocha** changed to **LiveScript** and then **LiveScript** changed to **JavaScript** as a marketing ploy to ride the hype of Java. So at this point, JavaScript was marketed as a scripting language for the browser - accessible to both amateurs and designers while Java was the professional tool for building rich web components.

Now, it’s important to understand the context of when these events were happening. Besides Nicolas Cage winning an Oscar, Microsoft was also working on Internet Explorer. Because JavaScript fundamentally changed the user experience of the web, if you were a competing browser you had no choice but to come up with your own JavaScript implementation since it wasn’t standardized yet. So, that’s exactly what Microsoft did and they called it JScript. This lead to a pretty famous problem in the history of the internet. JScript filled the same use case as JavaScript, but its implementation was different. This meant that you couldn’t build one website and expect it to work on both Internet Explorer and Nestscape Navigator. In fact, the two implementations were so different that “Best viewed in Netscape” and “Best viewed in Internet Explorer” logos became common for most companies who couldn’t afford to build for both implementations.

This is where Ecma comes into the picture. Ecma International is “an industry association founded in 1961, dedicated to the standardization of information and communication systems”. In November of 1996, Netscape submitted JavaScript to Ecma to build out a standard specification. By doing this it gave other implementors a voice in the evolution of the language and, ideally, it would keep other implementations consistant across browsers. So let’s dive into how Ecma works. Each new specification comes with a standard and a committee. In JavaScript’s case, the standard is ECMA-262 and the committee who works on the ECMA-262 standard is the TC39. If you look up the ECMA262 standard, you’ll notice that the term “JavaScript” is never used. Instead, they use the term “EcmaScript” to talk about the official language. The reason for this is because Oracle owns the trademark for the term “JavaScript”, so to avoid legal issues, Ecma used the term EcmaScript instead. In the real world, ECMAScript is usually used to refer to the official standard, EMCA-262, while JavaScript is used when talking about the language in practice. As mentioned earlier, the committee which oversees the evolution of the Ecma262 standard is the TC39, which stands for Technical Committee 39. The TC39 is made up of “members” who are typically browser vendors and large companies who’ve invested heavily in the web like Facebook and PayPal. To attend the meetings, “members” (again, large companies and browser vendors) will send “delegates” to represent said company or browser. It’s these delegates who are responsible for creating, approving, or denying language proposals.

When a new proposal is created, that proposal has to go through certain stages before it becomes part of the official specification. It’s important to keep in mind that in order for any proposal to move from one stage to another, a consensus among the TC39 must be met. This means that a large majority must agree while nobody strongly disagrees enough to veto a specific proposal.

Each new proposal starts off at Stage 0. This stage is called the Strawman stage. Stage 0 proposals are “proposals which are planned to be presented to the committee by a TC39 champion or, have been presented to the committee and not rejected definitively, but have not yet achieved any of the criteria to get into stage 1.” So the only requirement for becoming a Stage 0 proposal is that the document must be reviewed at a TC39 meeting. It’s important to note that using a Stage 0 feature in your codebase is fine, but even if it does continue on to become part of the official spec, it’ll almost certainly go through a few iterations before then.

The next stage in the maturity of a new proposal is Stage 1. In order to progress to Stage 1, an official “champion” who is part of TC39 must be identified and is responsible for the proposal. In addition, the proposal needs to describe the problem it solves, have illustrative examples of usage, a high level API, and identify any potential concerns and implementation challenges. By accepting a proposal for stage 1, the committee signals they’re willing to spend resources to look into the proposal in more depth.

The next stage is Stage 2. At this point, it’s more than likely that this feature will eventually become part of the official specification. In order to make it to stage 2, the proposal must, in formal language, have a description of the syntax and semantics of the new feature. In other words, a draft, or a first version of what will be in the official specification is written. This is the stage to really lock down all aspects of the feature. Future changes may still likely occur, but they should only be minor, incremental changes.

Next up is Stage 3. At this point the proposal is mostly finished and now it just needs feedback from implementors and users to progress further. In order to progress to Stage 3, the spec text should be finished and at least two spec complient implementations must be created.

The last stage is Stage 4. At this point, the proposal is ready to be included in the official specification. To get to Stage 4, tests have to be written, two spec complient implementations should pass those tests, members should have significant practical experience with the new feature, and the EcmaScript spec editor must sign off on the spec text. Basically once a proposal makes it to stage 4, it’s ready to stop being a proposal and make its way into the official specification. This brings up the last thing you need to know about this whole process and that is TC39s release schedule.

As of 2016, a new version of ECMAScript is released every year with whatever features are ready at that time. What that means is that any Stage 4 proposals that exist when a new release happens, will be included in the release for that year. Because of this yearly release cycle, new features should be much more incremental and easier to adopt.

<br>

## Versions of Javascript
Below is the table about ECMAScript editions.

|  Version  |              Offical name            |         Description        |
| --------- | ------------------------------------ | -------------------------- |
| 1         | ECMAScript 1 (1997)                  | First Edition              | 
| 2         | ECMAScript 2 (1998)                  | Editorial changes only     | 
| 3         | ECMAScript 3 (1999)                  | Added Regular Expressions and try/catch |
| 4         | ECMAScript 4                         | Never released             |
| 5         | ECMAScript 5 (2009) - ES5            | Added strict mode <br> Added JSON support <br> Added String.trim() <br> Added Array.isArray() <br> Added Arrar Iteration methods |
| 5.1       | ECMAScript 5.1 (2011)                | Editorial changes            |
| 6         | ECMAScript 2015 - ES6                | Added let and const <br> Added default parameter values <br> Added Array.find() <br> Added Array.findIndex() |
| 7         | ECMAScript 2016 - ES7                | Added exponential operator (**) <br> Added Array.prototype.includes |
| 8         | ECMAScript 2017 - ES8                | Added string padding <br> Added new Object properties <br> Added Async functions <br> Added Shared Memory |
| 9         | ECMAScript 2018 - ES9                | Added rest / spread properties <br> Added Asynchronous iteration <br> Added Promise.finally() <br> Additions to RegExp |


ECMAScript 3 is fully supported in all browsers.

ECMAScript 5 is fully supported in all modern browsers.


<br>

## Scripting Engines
An ECMAScript engine is a program that executes source code written in a version of the ECMAScript language standard, for example, Javascript.

These are new generation ECMAScript engines for web browsers, all implementing just-in-time compilation (JIT) or variations of that idea. The performance benefits for just-in-time compilation make it much more suitable for web applications written in JavaScript. 

The belows is the table that describe the scripting engines for Javascript or JScript.

|   Scripting Engines   |           Reference Applications            |    Description     | 
| --------------------- | ------------------------------------------- | ------------------ |
| Chakra                | Microsoft Edge v18                          | |
| Chakra (JScript9)     | Internet Explorer                           | JScript engine     |
| SpiderMonkey          | Firefox v63                                 | A JavaScript engine in Mozilla Gecko applications, including Firefox. The engine currently includes the IonMonkey compiler and OdinMonkey optimization module, has previously included the TraceMonkey compiler (first javascript JIT) and JägerMonkey. |
| Chrome V8             | Google Chrome v70, Opera v57                | A JavaScript engine used in Google Chrome, Node.js, and V8.NET. |
| JavascriptCore (Nitro)| Safari v12                                  |  A JavaScript interpreter and JIT originally derived from KJS. It is used in the WebKit project and applications such as Safari. Also known as Nitro, SquirrelFish and SquirrelFish Extreme. | 
| Tamarin               | Adobe Flash      | An ActionScript and ECMAScript engine used in Adobe Flash.|



<br>

Thank for your reading.

<br>

Refer:

[https://www.w3schools.com/js/js_versions.asp](https://www.w3schools.com/js/js_versions.asp)

[https://www.w3schools.com/js/js_es5.asp](https://www.w3schools.com/js/js_es5.asp)

[https://tylermcginnis.com/ecmascript/](https://tylermcginnis.com/ecmascript/)

[https://codeburst.io/javascript-wtf-is-es6-es8-es-2017-ecmascript-dca859e4821c](https://codeburst.io/javascript-wtf-is-es6-es8-es-2017-ecmascript-dca859e4821c)

[https://auth0.com/blog/a-brief-history-of-javascript/](https://auth0.com/blog/a-brief-history-of-javascript/)

[https://www.codementor.io/sunnyrgupta/origins-of-javascript-or-ecmascript-71hfdyf56](https://www.codementor.io/sunnyrgupta/origins-of-javascript-or-ecmascript-71hfdyf56)

[http://www.benmvp.com/learning-es6-history-of-ecmascript/](http://www.benmvp.com/learning-es6-history-of-ecmascript/)

[https://en.wikipedia.org/wiki/ECMAScript](https://en.wikipedia.org/wiki/ECMAScript)

[https://en.wikipedia.org/wiki/List_of_ECMAScript_engines](https://en.wikipedia.org/wiki/List_of_ECMAScript_engines)

[https://en.wikipedia.org/wiki/List_of_ECMAScript_engines](https://en.wikipedia.org/wiki/List_of_ECMAScript_engines)