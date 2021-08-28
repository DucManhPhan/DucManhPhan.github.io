---
layout: post
title: Aggregate Pattern
bigimg: /img/image-header/yourself.jpeg
tags: [DDD]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of Aggregate pattern](#solution-of-aggregate-pattern)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution of Aggregate pattern

Each bounded context has its own domain model. A domain model is made up of entities and value objects.
- An entity is something that has inherent identity and that can change over time.

    - Identity
    - Mutalbe

- A value object has no identity of its own, and it's immutable.

When modeling the entities and value objects in a bounded context, Evans describes them in terms of aggregates. An aggregate is made up of several different objects composed into a single business unit. Business operations are performed on this aggregate rather than on the individual entities and value objects within the unit. The top level entity within this unit of objects is called the aggregate root. There are a few rules that Evans lays out related to aggregates and aggregate roots. We can categorize these rules as identity rules, reference rules, and operation rules.

- Identity

    The root of an aggregate is an entity, not a value object, and the root has global identity whereas other entities within the aggregate have a local identity. So, the root is an entity, and the root has global identity.

    Remember the difference between entities and value objects. Entities have identity, and value objects don't.

    Identity is the property of an object that uniquely differentitates it from other objects. It allows us to act upon one object without affecting another one, so this first rule ensures that we can uniquely identify the root of an aggregate and differentiate it from any other aggregate root in the system. That second rule is further starting that we cannot global identify any other identity in the aggregate. We can't search for one of the child objects in order to find which aggregate it belongs to. We have to identity the root, and then we can walk down to the child.

- Reference

    - The root is the only member of an aggregate that outside objects can hold a reference to.
    - Objects within an aggregate can hold references to one another.
    - Objects within an aggregate can hold references to other aggregate root.

    So if we take these three rules together, then we should be able to draw a boundary around an aggregate where only the root is on the boundary. All the other objects are completely inside the boundary and wholly owned by the root. Any references, any arrows that are coming into the aggregate can only point at the root. They can't cross the boundary and point at any of the children. Now, we could have references coming from the children out of the aggregate pointing to other aggregate roots, but we can't have any arrows that are pointing into the boundary.

- Operation

    - First of all, the query operation. Only aggregate roots can be obtained through database queries.
    - And then we have the update operations. Invariants are enforced only within the scope of a single aggregate.
    - Finally, it's the delete operation. Deleting an aggregate root must delete all other objects within the boundary.

So this set of rules tell us how we can query, alter, and delete aggregates. We can only query for aggregate roots. We cannot query for children.

Remember only the aggregate root has global identity, so all of other entities must have local identity, and that means we can't query for them. Second, when we alter the aggregate, the aggregate root is responsible for validating its invariants. An invariant is a rule that relates all the objects within the aggregate, and this rule must always be true. An aggregate root can relate the objects within the aggregate, but it cannot enforce behaviors outside of the aggregate boundary. And then the third rule. Since a child object is wholly owned by the aggregate root, then deleting the root must also delete all of the objects within the aggregate, all of the children.

So, these are the three sets of rules.
- Identity rules say that the root has global identity whereas all of the other entities only have local identity.
- With Reference rules, we can't have any arrows coming through the boundary to the children.
- With Operation rules, it tell us how we can query alter, and delete an aggregate.


<br>

## When to use





<br>

## Benefits and Drawbacks





<br>

## Wrapping up




<br>

Refer:

[https://labs.septeni-technology.jp/design-2/domain-driven-design/domain-driven-design-cho-moi-nguoi/](https://labs.septeni-technology.jp/design-2/domain-driven-design/domain-driven-design-cho-moi-nguoi/)

[https://enterprisecraftsmanship.com/posts/classes-internal-to-an-aggregate-entities-or-value-objects/](https://enterprisecraftsmanship.com/posts/classes-internal-to-an-aggregate-entities-or-value-objects/)