---
layout: post
title: How to use JaxB to work with Xml
bigimg: /img/image-header/california.jpg
tags: [Java]
---



<br>

## Table of contents
- [Introduction about other tools](#introduction-about-other-tools)
- [JAXB](#jaxb)
- [XML and namespaces](#xml-and-namespaces)
- [Benefits and drawbacks](#benefits-and-drawbacks)
- [Java code example](#java-code-example)
- [Wrapping up](#wrapping-up)


<br>

## Introduction about other tools
Java has different APIs for working with XML, which means that there are different ways that we can read or write data in XML in Java. Which one of the API is best for the job depends on what exactly we need to do with XML.

We have the lower level APIs such as DOM, SAX, StAX, and the higher level such as JAXB.

- DOM - Document Object Model

    When we use DOM API to read an XML file, we are building a tree in memory that consists of nodes that directly correspond to the elements, attributes, text and other items in the XML.

    This is a straightforward and relatively easy way to work with the XML. We read the XML and then we get a tree of nodes that we can process as needed in our application. The DOM API consists of the ```org.w3c.dom``` package in the JDK, which contains interfaces such as document, elements, and attr, which are representations of an XML document, element, and attribute.

    Advantage:
    - The DOM API is easy to use.

    Disadvantage:
    - It does not scale well to large documents. Before our program can process the XML, the whole document is loaded into memory. If the document is very large, this can take up a lot of memory. Therefore, if we need to process large documents, we can choose to use the SAX or StAX instead.

- SAX - Simple API for XML

    SAX works in a completely different way than the DOM API. Instead of converting the XML document into a tree of nodes in-memory, it's an ```event-based``` API. The SAX parser reads the XML and calls callback methods in our program whenever it encounters.

    For example: the start tag, text, and end tag or something else in the XML.

    The callback methods in our program then inspect what is found and take the appropriate action. The SAX API consists of the package ```org.xml.sax``` and related packages in the JDK. If we use the SAX API, we'll most likely want to implement the ContentHandler interface, which defines the callback methods that the SAX parser will call.

    Advantage:
    - Since it does not need to load the whole document in memory, it works on large XML files just as well as on small XML files.

    Disadvantage:
    - The SAX API is a bit more cumbersome to use than the DOM API.

- StAX - Streaming API for XML

    StAX APIs is similar to that of the SAX APIs. It's ```event-based```. The main difference between the SAX and the StAX APIs is that ```SAX is push based``` while ```StAX is pull based```.
    
    This means that with SAX, it's the parser that is in control and that calls the callback methods in our application, so it pushes events to our application. While StAX, our program is in control, and it calls the StAX API to get the next event out of the XML that's being processed, so we are pulling the events out of the parser.

    The StAX API consists of the package ```javax.xml.stream``` and related packages in the JDK. The most important intefaces are ```XMLStreamReader``` and ```XMLStreamWriter``` for reading and writing XML. StAX API is a bit more convenient to use than the SAX API in many cases, but it's still ```low level API```, which means that we have to deal with all the details of parsing, we'll likely end up writing a lot of boilerplate code, even for parsing relatively simple XML documents.

- JAXB - Java Architecture for XML Binding

<br>

## JAXB
JAXB is an acronym that stands for Java Architecture for XML binding. What we can do with JAXB is to convert Java objects to XML and vice versa.

The word binding refers to the mapping between Java classes and fields to structures in XML such as elements and attributes. JAXB works with XML schema files. When we work with JAXB, we are working with two representations of our domain model.

On the Java side, we have a number of Java classes that define the domain model, and on the XML side, we have an XML schema that defines the same domain model. It would, of course, be cumbersome if we had to manually keep the Java and XML domain models synchronized. It's better to start from either Java or an XML schema and then generate either schema from our Java classes or generate Java from our schema. This corresponds to the two approaches to work with JAXB:
- The code first approach

    We will generate an XML schema, an XSD file, from our Java domain model classes. We give this XSD file to our business partner who needs to work with the XML that our software produces, so that we know that the XML looks like.

- The schema first approach

    We will start with an XML schema, an XSD file, and we generate the source code for our Java domain model classes from the schema. This is useful, for example, if we get the XSD file from a business partner or from an information analyst or architect in our own company.

<br>

## XML and namespaces
XML stands for Extensible Markup Language





<br>

## Benefits and drawbacks
1. Benefits
- JAXB is fairly useful for many applications that need to work with XML. It's especially useful if we have a more elaborate domain model because we do not need to write a lot of boilerplate code to convert our domain model objects from and to XML.

- Having an XSD that describes our domain model is also a good thing, especially if we use XML to exchange data with systems built by other people who need to know what our domain model looks like. We can then just give them our XSD.

2. Drawbacks
- For writing XML, the low level APIs give us more precise control over what the XML looks like since they are closer to the XML itself. For example, normally, it should not matter to our application if text is in a CDATA section or represented in a different way in the XML since semantically the meaning of the XML is the same. But if for some reasons, it matters, the low level APIs will let us make the distinction, while JAXB tends to hide such details.
    
- When we need to deal with very large XML documents, the SAX or StAX APIs might be more suitable than DOM or JAXB since SAX and StAX do not require loading the complete document into memory.

<br>

## Java code example




<br>

## Wrapping up




<br>

Refer:

[Working with XML in Java using JAXB](https://app.pluralsight.com/library/courses/xml-java-using-jaxb/table-of-contents)

