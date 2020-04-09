---
layout: post
title: Some websites for clean code
bigimg: /img/image-header/california.jpg
tags: [Clean Code]
---


In order to write readable code, easily maintainable code, we will read about some interesting websites:

- [https://medium.com/better-programming/the-art-of-refactoring-5-tips-to-write-better-code-3bc1f6f7689](https://medium.com/better-programming/the-art-of-refactoring-5-tips-to-write-better-code-3bc1f6f7689)

    - Get rid of switch statements --> Use Object literal (in Javascript) or use Map.

    - Make our conditional descriptive --> Use function to make our complicated conditions easy readable, understandable.

    - Use guard clauses to avoid nested if statements --> Use early return to make our code easy to read.

    - Avoid code duplication.

    - Functions should only do one thing.

- [https://medium.com/@dangoslen/my-top-4-patterns-for-writing-simple-code-466705ac0b97](https://medium.com/@dangoslen/my-top-4-patterns-for-writing-simple-code-466705ac0b97)

- [https://medium.com/qualyteam-engineering/chain-of-responsibility-in-a-real-world-refactoring-example-a31486862c46](https://medium.com/qualyteam-engineering/chain-of-responsibility-in-a-real-world-refactoring-example-a31486862c46)

    Use Chain of Responsibility to make our conditionals such as if-else statements easy to maintain by separating each conditional to each subclass of Handler - parent class.

    A problem happens when we split our conditionals is that we have to share data context between subclass handlers.

- [https://www.codingdojo.com/blog/clean-code-techniques](https://www.codingdojo.com/blog/clean-code-techniques)

    - Keep it simple.

    - Understand your code.

    - Comments Are Your New Best Friends.

    - Don’t Repeat Yourself (DRY).

    - Indent Your Code.

    - Naming Convention.

    - Explore.

    - Use Your Brain.

    - Test Runs.

    - Practice Your Art.

- [https://www.baeldung.com/java-replace-if-statements](https://www.baeldung.com/java-replace-if-statements)

    - Factory Class

    - Use of Enums

    - Command Pattern

    - Rule Engine