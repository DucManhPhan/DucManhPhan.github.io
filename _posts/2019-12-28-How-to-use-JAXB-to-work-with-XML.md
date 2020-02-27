---
layout: post
title: How to use JaxB to work with Xml
bigimg: /img/image-header/california.jpg
tags: [Java]
---

In this article, we will learn how to use JAXB for working with XML, especially when we utilize JAX-WS framework. Let's get started.

<br>

## Table of contents
- [Introduction about other tools](#introduction-about-other-tools)
- [JAXB](#jaxb)
- [XML structure](#xml-structure)
- [Understanding the JAXB API](#understanding-the-jaxb-api)
- [Java code example](#java-code-example)
- [Benefits and drawbacks](#benefits-and-drawbacks)
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

## XML structure
1. XML and namespaces
- XML
    XML stands for Extensible Markup Language. It's the standard text-base format for storing arbitrary structure data.

    An XML document contains elements, and each element starts and ends with a tag. The start tag consists of the name of the element between angle brackets. The end tag is the same as the start tag except that there is a forward slash before the element name. The start tag can optionally have attributes, such as orderDate attribute on this purchaseOrder start tag, which are specified after the element name and separated by spaces. Attributes have a name and a value. The content of an element is what's between the start and end tags. This can be text or other elements. The element's productName, quantity, price, and so on, have text content ...

    For example:

    ```java
    <?xml version="1.0" encoding="UTF-8" ?>
    <purchaseOrder xmlns="http://www.jesperdj.com/ps/jaxb" orderDate="2017-09-10">
        <items>
            <item>
                <productName>Ballpoint Pen</productName>
                <quantity>20</quantity>
                <price>8.95</price>
                <comment>Blue ink</comment>
            </item>
        </items>

        <customer>
            <name>John Doe</name>
            <shippingAddress>
                <street>123 Main Street</street>
                <city>Exampleville</city>
            </shippingAddress>
        </customer>
    </purchaseOrder>
    ```

    The fact that we can nest elements is a very powerful idea, and that's what makes it possible to store almost any kind of structure data in XML.

    If an element has no content, the start and end tag can be combined into a single tag with a forward slash after the element name. That's just a shorter way to write the start and end tag right next to each other with nothing in between.

- Namespaces

    Namespaces in XML are a bit like packages in Java. A namespace keeps a set of related tag names together, just like a Java package keeps related classes together. When we define a set of tag names for our application, it's good idea to define a namespace to contain our tag names.

    Let's look at the syntax that is used to refer to namespaces. A start tag can have a special attribute with a name xmlns. The value of this attribute is the name of a namespace, and it specifies that the tag and its child tags belong to that namespace. The name of a namespace is a URI, a uniform resource identifier. It often looks like a URL, and it's good idea to choose a URL that refers to a world wide web domain name that we own. This is exactly the same as with Java package names where we usually use a package name that corresponds to a web domain, like com.mycompany.mysoftware. 

    URL does not need to point to any real resource on the web, so we do not need to have a server running that responds to the URL. Through the XML parser, it's just a string that uniquely identifies the namespace. Sometimes we'll need to use text from multiple different namespaces in our XML document. We can use namespace prefixes to indicate explicitly to which namespace a tag belongs. The declare a namespace with a prefix, we have to modify the xmlns attribute slightly by putting a colon and then a prefix name after it. We can use this prefix name in front of tag names that should be in that namespace.

2. XML schema

    ```JAXB``` makes use of XML schema, so it's important that we understand what XML schema is. Let's take a quick look at the most important concepts of XML schema.

    ```XML```, unlike ```HTML```, does not have a fixed set of tags. When we're going to use ```XML``` for our application, we'll be inventing our own set of tags that have meaning in the context of our application. An ```XML schema``` describes the data model of an XML file, what elements can appear in the XML, what the content of these elements can be, and what attributes they can have.

    ```XML processing tool``` can use the schema, for example, to check if an XML document is valid according to the schema.
    
    There are different standard schema languages for XML. The original schema language, which was invented together with XML itself, is ```DTD```, which stands for ```Document Type Definition```, but DTD has limitations. For example, it does not support namespaces and it does not support data types for the content of elements and attributes. So, there is, for example, no way to specify in a ```DTD``` that a certain element should contain a number of a date. 
    
    The most widely used standard schema language is ```XML schema```. If we are working with JAXB, it's important to understand the ```XML schema``` because JAXB heavily makes use of it. ```XML schema``` files are XML files themselves and have the extension ```XSD```, which stands for ```XML schema Definition```.

    If we want to know everything about ```XML schema```, we can look up the specifications on the website of the ```World Wide Web Consortium```, the ```W3C```, but be aware that the official specification is a very dry and technical document, which is hard to read. Fortunately, the ```W3C``` also has a more easy-to-read tutorial, the ```XML schema Primer```.

    For example ```XSD``` file which defines a small domain model for ```purchaseOrder```:

    ```xml
    <?xml version="1.0" encoding="UTF-8" ?>
    <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
        <xs:element name="purchaseOrder">
            <xs:complexType>
                <xs:sequence>
                    <xs:element name="items" type="Items" />
                    <xs:element name="customer" type="Customer" />
                    <xs:element ref="comment" minOccurs="0" />
                </xs:sequence>
                <xs:attribute name="orderDate" type="xs:date" use="required" />
            </xs:complexType>
        </xs:element>

        <xs:complexType name="Items">
            <xs:sequence>
                <xs:element name="item" minOccurs="0" maxOccurs="unbounded">
                    <xs:complexType>
                        <xs:sequence>
                            <xs:element name="productName" type="xs:string" />
                            <xs:element name="quantity">
                                <xs:simpleType>
                                    <xs:restriction base="xs:positiveInteger">
                                        <xs:maxExclusive value="100">
                                    </xs:restriction>
                                </xs:simpleType>
                            </xs:element>
                            <xs:element name="price" type="xs:decimal" />
                            <xs:element ref="comment" minOccurs="0" />
                        </xs:sequence>
                    </xs:complexType>
                </xs:element>
            </xs:sequence>
        </xs:complexType>

        <xs:complexType name="Customer">
            <xs:sequence>
                <xs:element name="name" type="xs:string" />
                <xs:element name="shippingAddress" type="Address" />
                <xs:element name="billingAddress" type="Address" />
                <xs:element name="loyalty" type="Loyalty" />
            </xs:sequence>
        </xs:complexType>

        <xs:complexType name="Address">
            <xs:sequence>
                <xs:element name="street" type="xs:string" />
                <xs:element name="city" type="xs:string" />
                <xs:element name="postalCode" type="xs:string" />
                <xs:element name="country" type="xs:string" />
            </xs:sequence>
        </xs:complexType>

        <xs:complexType name="Loyalty">
            <xs:restriction base="xs:string">
                <xs:enumeration value="BRONZE">
                <xs:enumeration value="SILVER">
                <xs:enumeration value="GOLD">
            </xs:restriction>
        </xs:complexType>

        <xs:element name="comment">
            <xs:simpleType>
                <xs:restriction base="xs:string">
                    <xs:maxLength value="1000">
                </xs:restriction>
            </xs:simpleType>
        </xs:element>
    </xs:schema>
    ```

    The tags that can be used in XML schema are defined in the standard namespace that is defined by the URI. We are using the namespace prefix ```xs``` for the XML schema tags.

    Note that we can, in principle, choose any prefix we like within our document, but ```xs``` is what is conventionally used for XSD files. The root element is an ```xs:schema``` element. We can define a handful of different things at the root level.

    The most important things that it can define at root level are ```xs:element```, ```xs:attribute```, ```xs:simpleType``` and ```xs:complexType```.

    Let's take a look at the definition of ```purchaseOrder``` element. This element has a complex type. There are two kinds of types in XML schema. There are simple types, which are for the text content of elements and attributes. We will take a look at those in a moment. Complex types are primarily for elements that can contain other nested elements. What we see here is that a ```purchaseOrder``` element must contain a sequence of three other elements: an items, a customer, and a comment element. 

    Note that because it's a sequence, the elements must appear in the ```purchaseOrder``` element exactly in this order. If the XML would contain the ```customer``` element before the ```items``` element, for example, then that would be an error and the XML would not be valid. The type of ```purchaseOrder``` element is defined directly in the definition of the element itself. Another thing we can do is define the type separately, and then in the element definition, point to the definition of the type. That's what done here for the ```items``` and ```customer``` elements.

    The advantage of this is that it makes it possible to reuse types. So if we have multiple elements that have the same type, then we do not have to copy and paste the type definition, and it also makes the schema more readable. We can also define the element itself somewhere else, which is what we've done with the ```comment``` element.

    Instead of a ```name``` attribute, it has a ```ref``` attribute and no type. The type is specified at the actual definition of the element somewhere else in the file. To indicate how often an element may appear in the XML, we can use the ```minOccurs``` and ```maxOccurs``` attributes. The ```comment``` element has ```minOccurs``` set to 0, which means that it's optional. The defaults for ```minOccurs``` and ```maxOccurs``` is 1. So if we omit these attributes, then the element must appear exactly once. Finally in the definition of the ```purchaseOrder``` element, it's specified that the ```purchaseOrder``` element must have an ```orderDate``` attribute. The type of this attribute is ```xs:date```, which is one of the built-in simple types of XML schema. ```xs:date``` is a date in ```ISO-8601``` format, which means that it's a year, month and date separated by dashes. 

    The type of ``items`` element in a ```purchaseOrder``` is ```Items```. This type is a complex type, which is defined at the root level of the XSD. It contains a sequence of at least 0 item elements. Note that ```maxOccurs``` is set to unbounded, which is a special value to indicate that there's no limit to the number of times this element may appear in the XML. 
    
    The type of the ```item``` element is defined in-line here. It's again a complex type that consists of a sequence of a few other elements, ```productName```, ```quantity```, ```price``` and ```comment```. The ```productName``` is just a string. Note that ```xs:string``` is another one of the built-in simple types. The ```quantity``` element has a slightly more elaborate simple type. It's based on ```xs:positiveInteger```, which is, again, one of the built-in simple types, and it has a restriction added to it. The value must be less than ```100```. Then there is the ```price``` element, which is of type ```xs:decimal``` which is built-in simple type for numbers with a decimal digit. Finally, we allow an item to have a ```comment```, which is represented by the ```comment``` element, which we used before in the ```purchaseOrder```.

    The ```Customer``` complexType has the name of the ```customer```, the ```shippingAddress``` and ```buildingAddress``` and a loyalty element.

    The ```Loyalty``` simple type looks like a Java enum. It's a simple type based on ```xs:string``` that has three possible enumeration values.

    Finally, there is the definition of the ```comment``` element, which is a string with a maximum length of 1000 characters. That's our simple XML schema for ```purchaseOrder```.

<br>

## Understanding the JAXB API

The ```JAXB``` API is in the package ```javax.xml.bind``` and related packages in Java SE. The entry point into the API is the class ```JAXBContext```. The first thing we need to do if we want to use the JAXB API is to get an instance of class ```JAXBContext```. The ```JAXBContext``` object will give us access to everything else in the API. We get an instance of ```JAXBContext``` by calling one of the new instance static factory methods in the class itself.

When we have a ```JAXBContext``` object, we can call a number of other factory methods on it to create other JAXB objects. The two most important ones are the ```Marshaller```, ```Unmarshaller``` objects.

- In JAXB terminology, converting from Java objects to XML is called marshalling. So when we want to write XML, what we need to do is create a Marshaller object, which has methods that we can call to marshall our Java objects into XML.

- Vice versa, converting XML back to Java objects is called unmarshalling. When we want to read XML, we create an ```Unmarshaller``` object, which, of course, has methods for unmarshalling XML into Java objects.

Besides factory methods to create ```Marshaller``` and ```Unmarshaller``` objects, class ```JAXBContext``` has a few more methods to create ```Binder```, and ```JAXBIntrospector``` objects.

The reason that creating all these objects works via factory methods is because the JAXB API was designed to have multiple possible implementations. Besides the default implementation, which is included with Java SE, there are indeed other implementations available, for example, ```EclipseLink MOXy```. Reasons to use a different implementation of JAXB rather than the default are because a different implementation might offer extra features that are not part of the default or because of different implementation might have better performance.

There are one important thing to mention about ```JAXBContext```, ```Marshaller```, ```Unmarshaller``` objects. We should normally create a ```JAXBContext``` object only once in our application and then reuse the same object whenever we need it. The ```JAXBContext``` object is guaranteed to be thread-safe, so it's safe to reuse the same instance for multiple threads. Creating a ```JAXBContext``` object is a relatively heavy operation. So if we would do that every time our application needs it, then it will degrade the performance of our application.

```Marshaller```, ```Unmarshaller``` objects are not guaranteed to be thread-safe, so we should not use these objects for multiple threads. Creating ```Marshaller``` and ```Unmarshaller``` objects are not heavy operations, so creating them when needed does not cause a performance problem.

<br>

## Java code example

The sample code in this section will be put in this [link](https://github.com/DucManhPhan/J2EE/tree/master/src/Utils/xml-utils).

With:
- ```@XmlRootElement```: This annotation is used at the top level class to indicate the root element in the XML document. The ```name``` attribute in the annotation is optional. If not specified, the class name is used as the root XML element in the document.

- ```@XmlAttribute```: This annotation is used to indicate the attribute of the root element.

- ```@XmlElement```: This annotation is used on the properties of the class that will be the sub-elements of the root element.

- ```@XmlElementWrapper```

    - This annotation generates a wrapper element around XML representation.
    - This is primarily intended to be used to produce a wrapper XML element around collections.
    - This annotation can be used with the following annotations: ```XmlElement```, ```XmlElements```, ```XmlElementRef```, ```XmlElementRefs```, ```XmlJavaTypeAdapter```.
    - The ```@XmlElementWrapper``` annotation can be used with the following program elements:
        - JavaBean property
        - non static, non transient field

- ```@XmlType```: define the order in which the fields are written in the XML file

- ```@XmlTransient```: annotate fields that we don't want to be included in XML

- ```@XmlElementRef```: Maps a JavaBean property to a XML element derived from property's type.

    Refer some example in this [link](https://docs.oracle.com/javaee/7/api/javax/xml/bind/annotation/XmlElementRef.html).

<br>

## Benefits and drawbacks
1. Benefits
- JAXB is fairly useful for many applications that need to work with XML. It's especially useful if we have a more elaborate domain model because we do not need to write a lot of boilerplate code to convert our domain model objects from and to XML.

- Having an XSD that describes our domain model is also a good thing, especially if we use XML to exchange data with systems built by other people who need to know what our domain model looks like. We can then just give them our XSD.

2. Drawbacks
- For writing XML, the low level APIs give us more precise control over what the XML looks like since they are closer to the XML itself. For example, normally, it should not matter to our application if text is in a CDATA section or represented in a different way in the XML since semantically the meaning of the XML is the same. But if for some reasons, it matters, the low level APIs will let us make the distinction, while JAXB tends to hide such details.
    
- When we need to deal with very large XML documents, the SAX or StAX APIs might be more suitable than DOM or JAXB since SAX and StAX do not require loading the complete document into memory.

<br>

## Wrapping up
- ```JAXB 1.0``` was developed under the Java Community Process as ```JSR 31```. ```JAXB 2.0``` was released under ```JSR 222``` and becomes part of JDK since ```Java 6``` to add support for the ```Web Services stack``` (under package ```javax.xml.bind```). It's still part of standard JDK in ```Java 7``` and ```Java 8```.

    In ```Java 9```, the modules which contain Java EE technologies were deprecated for removal in a future release. The flag --add-modules=java.xml.bind can be used in ```Java 9``` and ```Java 10``` to resolve these modules.

    In ```Java 11```, ```JAXB``` has been removed from ```JDK``` (together with other JEE related modules based on ```JEP 320```) and we need to add it to the project as a separate library via ```Maven``` or ```Gradle```.

- To get schema-to-java mapping in JAXB, refer [link](https://docs.oracle.com/cd/E19316-01/819-3669/bnazf/index.html).

<br>

Refer:

[Working with XML in Java using JAXB](https://app.pluralsight.com/library/courses/xml-java-using-jaxb/table-of-contents)

[https://docs.oracle.com/cd/E19316-01/819-3669/bnazf/index.html](https://docs.oracle.com/cd/E19316-01/819-3669/bnazf/index.html)

[https://dzone.com/articles/writing-and-reading-xml-file?fromrel=true](https://dzone.com/articles/writing-and-reading-xml-file?fromrel=true)

[https://dzone.com/articles/introduction-to-jaxb-20?fromrel=true](https://dzone.com/articles/introduction-to-jaxb-20?fromrel=true)

[https://dzone.com/articles/xml-marshalling-and-unmarshalling-using-spring-and?fromrel=true](https://dzone.com/articles/xml-marshalling-and-unmarshalling-using-spring-and?fromrel=true)

[https://howtodoinjava.com/jaxb/xmlelementwrapper-annotation/](https://howtodoinjava.com/jaxb/xmlelementwrapper-annotation/)