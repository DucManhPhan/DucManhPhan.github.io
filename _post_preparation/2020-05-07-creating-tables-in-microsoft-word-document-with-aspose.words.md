---
layout: post
title: Creating tables in Microsoft Word Document with Aspose.Words
bigimg: /img/image-header/yourself.jpeg
tags: [Aspose]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Understanding about the structure of Aspose.Words](#understanding-about-the-structure-of-aspose.words)
- [Using the hierarchy structure](#using-the-hierarchy-structure)
- [Using DocumentBuilder class](#using-documentbuilder-class)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

In some Java project, we have data and we want to create the report for our customers. Supposed that we need to create a report file that looks like a below image.

![](../img/Java/aspose/table-examples.png)

In this article, we will use Aspose to overcome it. But to utilize Aspose jar file, it is necessary to have license.

<br>

## Understanding about the structure of Aspose.Words

Before jumping into coding a report in Java project, we will take some time to look at **Aspose.Words**'s structure.

![](../img/Java/aspose/Object-Model-Overview.png)

It means that **Aspose.Words** uses the **Composite pattern**.
- All node classes ultimately derive from the **Node** class, which is the basic class in the **Aspose.Words** Document Object Model.

- Nodes that can contain other nodes, for example, **Section** and **Paragraph**, derive from the **CompositeNode** class, which in turn derives from Node.

Below is the class diagram of **Aspose.Words**.

![](../img/Java/aspose/aspose-words-class-diagram.png)

About the logical levels in a document, we have:

|     Node Level      |               Classes               |                              Description                           |
| ------------------- | ----------------------------------- | ------------------------------------------------------------------ |
| Document level      | Section                             | The top level Document node contains only Section objects. A Section is a container for stories (independent flows of text) for the main text and optionally headers and footers. |
| Block level         | Paragraph, Table, StructuredDocumentTag, CustomXmlMarkup | Tables and paragraphs are block-level elements and contain other elements. Custom markup nodes can contain nested block-level nodes. |
| Inline level        | Run, FormField, SpecialChar, FieldChar, FieldStart, FieldSeparator, FieldEnd, Shape, GroupShape, Comment, Footnote, CommentRangeStart, CommentRangeEnd, SmartTag, StructuredDocumentTag, CustomXmlMarkup, BookmarkStart and BookmarkEnd. | Inline occur inside a Paragraph and represent the actual content of the document.Footnote, Comment and Shape can contain block-level elements. Custom markup nodes can contain nested inline-level elements. |

Then, continue to work with node level, we have:
1. Document level

    ![](../img/Java/aspose/document-level.png)

2. Block level

    ![](../img/Java/aspose/block-level.png)

3. Inline level

    ![](../img/Java/aspose/inline-level.png)

<br>

## Using the hierarchy structure



```java

```


<br>

## Using DocumentBuilder class



```java

```


<br>

## Wrapping up

- Understanding about the hierarchy structure of Aspose.Words makes us confident to work with it.

- Using **DocumentBuilder** helps our code more concise.


<br>

Refer:

[https://docs.aspose.com/display/wordsnet/Aspose.Words+Document+Object+Model](https://docs.aspose.com/display/wordsnet/Aspose.Words+Document+Object+Model)

[https://apireference.aspose.com/words/java/com.aspose.words/ParagraphFormat](https://apireference.aspose.com/words/java/com.aspose.words/ParagraphFormat)

[https://docs.aspose.com/display/wordsjava/Creating+Tables](https://docs.aspose.com/display/wordsjava/Creating+Tables)

[https://apireference.aspose.com/words/java/com.aspose.words/Row](https://apireference.aspose.com/words/java/com.aspose.words/Row)

[https://apireference.aspose.com/words/java/com.aspose.words/Document](https://apireference.aspose.com/words/java/com.aspose.words/Document)

[https://www.itread01.com/content/1547886273.html](https://www.itread01.com/content/1547886273.html)

[https://www.tutorialspoint.com/guava/index.htm](https://www.tutorialspoint.com/guava/index.htm)