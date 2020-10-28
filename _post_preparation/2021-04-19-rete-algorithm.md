---
layout: post
title: Rete algorithm
bigimg: /img/image-header/yourself.jpeg
tags: [Algorithm]
---




<br>

## Table of contents





<br>

## Given problem






<br>

## Brute force approach






<br>

## Solution with Rete algorithm

1. Some concepts that use in Rete algorithm

    - Facts
    - Rules
    - Production Memory

        The Production Memory is a set of productions or rules. A production is specified as a set of conditions, collectively called the left-hand side - LHS, and a set of actions, collectively called the right-hand side - RHS.

        Conditions may contain variables.

    - Working Memory

        The Working Memory - WM is a set of items which represent Facts about the system's current situation. Each item in WM is called a Working Memory Element - WME.

        In Rete algorithm, WME has the form of triples that look like: ```identifier ^attribute value```.

        No variables are allowed in WMEs.

    - Token

        The descriptions of WM changes that are passed into the black box are called tokens.

        A token is an ordered pair of a tag and a list of data elements.

        In the simplest implementations of the Rete algorithm, there are only two tags.
        - The tag + indicates that something has been added to the WM.
        - The tag - indicates that something has been deleted from the WM.

        When an element is modified, two tokens are sent to the black box. One token indicates that the old form of the elements has been deleted from WM, and the other the new form of the element has been added.

    - How production matches working memory

        A production is said to match the current WM if all its conditions match items in the current working memory, with any variables in the conditions bound consistently.

        The match algorithm's job is to determine which productions in the system match the current WM, and for each one, to determine which WMEs match which conditions.


2. The structure of Rete algorithm

    There are two parts in this algorithm.
    - Alpha part

        The alpha part performs the constant tests on the WMEs. Its output is stored in the Alpha Memories - AM, each of which holds the current set of WMEs passing all the constant tests of an individual condition.

        ![](../img/drools/rete-algorithm/alpha-network.png)

        In most versions of Rete, the alpha network performs not only constant tests but also intra-condition variable binding consistency tests, where one variable occurs more than once in a single condition.

    - Beta part

        The beta part of the network contains join nodes and beta memories.

        Join nodes perform the tests for consistency of variable bindings between conditions.

        Beta memories store partial instantiations of productions, for example, combinations of WMEs which match some but not all of the conditions of a production. These partial instantiations are called tokens.

    Working memory changes are sent through the alpha network and the appropriate alpha memories are updated. These updates are then propagated over to the attached join nodes, activating those nodes. If any new partial instantiations are created, they are added to the appropriate beta memories and then propagated down the beta part of the network, activating other nodes. Whenever the propagation reaches the bottom of the network, it indicates that a production's conditions are completely matched. This is commonly implemented by having a specical node for each production (called its production node) at the bottom of the network.

    The bulk of the code for the Rete algorithm consists of procedures for handling the various node activations.
    - The activation of an alpha memory node is handled by adding a given WME to the memory, then passing the WME on to the memory's successors (the join nodes attached to it).
    - The activation of a beta memory node is handled by adding a given token to the memory and passing it on to the node's children (join nodes).

    In general, an activation of some nodes from another node in the beta network is called a left activation. An activation of some nodes from an alpha memory is called a right activation.

    A join node can incur two types of activations:
    - a right activation when a WME is added to its alpha memory(i.e, the alpha memory that feeds into it)
    - a left activation when a token is added to its beta memory (the beta memory that feeds into it).

3. 



<br>

## The differences between Rete algorithm and Brute force approach

Belows are the two reasons that Rete algorithm runs faster than naive approach.
- State-saving

    After each change to WM, the state (results) of the matching process is saved in the alpha and beta memories. After the next change to WM, many or most of these results are usually unchanged, so Rete avoids a lot of recomputation by keeping these results around in between successive WM changes.

    Rete is designed for systems where only a small fraction of WMEs change in between successive times rules need to be matched. Rete's state-saving would not be very beneficial in systems where most WMEs change each time.

- Sharing of nodes between productions with similar conditions

    Different kinds of sharing occur in different parts of the network. There can be sharing within the alpha network, when two or more productions have a common condition, Rete uses a single alpha memory for the condition, rather than creating a duplicate memory for each production.


<br>

## 






<br>

## 






<br>

## 






<br>

## 






<br>

## Wrapping up




<br>

Refer:

