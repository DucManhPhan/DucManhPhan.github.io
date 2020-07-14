---
layout: post
title: Understanding about OneToMany relationship with Hibernate
bigimg: /img/image-header/yourself.jpeg
tags: [Hibernate]
---



<br>

## Table of contents

- [Given problem](#given-problem)
- [How to use one-to-many relationship](#how-to-use-one-to-many-relationship)
- [Some concepts that we need to know about relationships](#some-concepts-that-we-need-to-know-about-relationships)
- [Understanding parameters of @JoinColumn annotation](#understanding-parameters-of-@joincolumn-annotation)
- [Understanding parameters of @OneToMany annotation](#understanding-parameters-of-@onetomany-annotation)
- [Understanding parameters of @ManyToOne annotation](#understanding-parameters-of-@manytoone-annotation)
- [Some questions about one-to-many relationship](#some-questions-about-one-to-many-relationship)
- [Best practices for one-to-many relationship](#best-practices-for-one-to-many-relationship)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## How to use one-to-many relationship

To understand how @OneToMany annotation work, we can read about the article [The best way to map a @OneToMany relationship with JPA and Hibernate](https://vladmihalcea.com/the-best-way-to-map-a-onetomany-association-with-jpa-and-hibernate/).




<br>

## Some concepts that we need to know about relationships


1. The owning side




2. The inverse side



3. Bidirectional relationship



4. Unidirectional relationship



<br>

## Understanding parameters of @JoinColumn annotation

Below is the definition of @JoinColumn annotation.

```java
@Repeatable(JoinColumns.class)
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface JoinColumn {
    String name() default "";

    String referencedColumnName() default "";

    boolean unique() default false;

    boolean nullable() default true;

    boolean insertable() default true;

    boolean updatable() default true;

    String columnDefinition() default "";

    String table() default "";

    ForeignKey foreignKey() default @ForeignKey(ConstraintMode.PROVIDER_DEFAULT);
}
```

**@JoinColumn** annotation is used in the owning side - the **child entity** that contains the **foreign key** points to the **primary key** of the **parent entity**.

Supposed that we still have one-to-many relationship between FootballClub and Player.

```java
public class FootballClubEntity {
    @OneToMany(mappedBy = "footballClub", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<PlayerEntity> players;
}

public class Player {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "football_club_id", referencedColumnName="id")
    private FootballClubEntity footballClub;
}
```

The meaning of these parameters:
1. **name** parameter

    This parameter's value will be the foreign key variable's name in a table.
    
    Then the table in which it is found depends upon the context.
    - If the join is for a **OneToOne** or **ManyToOne** mapping using a foreign key mapping strategy, the foreign key column is in the table of the source entity or embeddable.
    - If the join is for a **unidirectional OneToMany** mapping using a foreign key mapping strategy, the foreign key is in the table of the target entity.

        ```java
        // unidirectional one-to-many association using a foreign key mapping
        // In Customer class
        @OneToMany
        @JoinColumn(name="CUST_ID") // join column is in table for Order
        public Set<Order> getOrders() {return orders;}
        ```

        Based on the above example, we can find that the **name** parameter's value - **CUST_ID** is in the foreign key of Order table.

    - If the join is for a **ManyToMany** mapping or for a **OneToOne** or **bidirectional ManyToOne/OneToMany** mapping using a join table, the foreign key is in a join table.
    - If the join is for an element collection, the foreign key is in a collection table.

2. **referencedColumnName** parameter

    This parameter will refer to the primary key's name of the parent entity.

3. **unique** parameter



4. **nullable** parameter



5. **insertable** parameter



6. **updatable** parameter


7. **columnDefinition** parameter




8. **table** parameter



9. **foreignKey** parameter




<br>

## Understanding parameters of @OneToMany annotation

Below is the definition of @OneToMany annotation.

```java
@Target(value={METHOD,FIELD})
@Retention(value=RUNTIME)
public @interface OneToMany {
    Class targetEntity() default void.class;

    CascadeType[] cascade() default {};

    FetchType fetch() default FetchType.LAZY;

    String mappedBy() default "";

    boolean orphanRemoval() default false;
}
```

1. **mappedBy** parameter

    This parameter will be used in Bidirectional relationship. It contains the **variable's name** under the **@ManyToOne** annotation.

    For example, we have the one-to-many relationship between the Football club entity and the Player entity.

    ```java
    public class FootballClubEntity {

        @Id
        @Column(name = "id")
        private Long id;

        @OneToMany(mappedBy = "footballClub")
        private List<PlayerEntity> players;

    }

    // This PlayerEntity has foreign key football_club_id
    public class PlayerEntity {

        @Id
        @Column(name = "id")
        private Long id;

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "football_club_id", referencedColumnName="id")
        private FootballClubEntity footballClub;

    }
    ```

2. **orphanRemoval** parameter

    If we want to remove an entity, then remove automatically **n** other entities based on one-to-many relationship, we need to use this parameter.

3. **fetch** parameter

    This parameter will be used to specify what actions hibernate do when we get an instance of the entity that has one-to-many relationship with the other entities.

    Below is the definition of FetchType type.

    ```java
    public enum FetchType {
        // Hibernate will do not load all entities immediately. It only loads when we want to load them directly.
        LAZY,

        // Hibernate will load all entities immediately when we get an instance that entity.
        EAGER;

        private FetchType() {
        }
    }
    ```

4. **targetEntity** parameter

    Hibernate will use this parameter to know exactly which entity type that it can reference.

5. **cascade** parameter

    Below is the definition of **CascadeType** data type.

    ```java
    public enum CascadeType {
        ALL,
        PERSIST,
        MERGE,
        REMOVE,
        REFRESH,
        DETACH;

        private CascadeType() {
        }
    }
    ```

    The meaning of each type of cascade parameter.

    |    CascadeType   |               Meaning               |
    | ---------------- | ----------------------------------- |
    | ALL              | cascade={PERSIST, MERGE, REMOVE, REFRESH, DETACH} |
    | PERSIST          | This type will implement the perist operation from the parent entity to its child entities. |
    | MERGE            | This type will implement the merge operation from the parent entity to its child entities.  |
    | REMOVE           | This type will implement the remove operation from the parent entity to its child entities. |
    | REFRESH          | This type will re-read the value of the parent entity, then re-read its child entities.     |
    | DETACH           | This type will implement the detach operation from the parent entity to its child entities. |

<br>

## Understanding parameters of @ManyToOne annotation

In @ManyToOne annotation, its definition will look like:

```java
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface ManyToOne {
    Class targetEntity() default void.class;

    CascadeType[] cascade() default {};

    FetchType fetch() default FetchType.EAGER;

    boolean optional() default true;
}
```

This @ManyToOne annotation has the same four parameters with @OneToMany annotation.
- **targetEntity** parameter
- **cascade** parameter
- **fetch** parameter
- **optional** parameter -  Whether the association is optional. If set to **false**, then a non-null relationship must always exist.

To understand their meaning of parameters, we need to read up on the section [Understanding parameters of @OneToMany annotation](#understanding-parameters-of-@onetomany-annotation).

<br>

## Some questions about one-to-many relationship

1. The difference between **orphanRemoval** parameter and **cascade.REMOVE** parameter





2. The difference between **CascadeType.Detach** and **CascadeType.Remove**

    Supposed that we have the one-to-many relationship between Football club entity and Player entity.

    ```java
    public class FootballClubEntity {
        @OneToMany(mappedBy = "footballClub", cascade = CascadeType.ALL, orphanRemoval = true)
        private List<PlayerEntity> players;
    }

    public class Player {
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "football_club_id", referencedColumnName="id")
        private FootballClubEntity footballClub;
    }
    ```

    And we have operations in **EntityManager** that relate to these above **CascadeType**.
    - **detach()** method

        ```java
        // definition of detach() method
        void detach(java.lang.Object entity);

        public static void main() {
            // create football club entity with multiple players.
            // ...

            FootballClubEntity footballClub = buildFootballClub();
            PlayerEntity beckham = buildPlayer("Beckham");
            PlayerEntity ronaldo = buildPlayer("Ronaldo");
            PlayerEntity messi = buildPlayer("Messi");

            footballClub.setPlayers(Arrays.asList(beckham, ronaldo, messi));
            entityManager.detach(footballClub);
        }
        ```

        Because in the FootballClubEntity class's @OneToMany annotation, we use **CascadeType.ALL** for this annotation. So, when we call **entityManager.detach(footballClub);**, the football club entity's instance and multiple player entities will be detach from Persistence Context. But their all records of **FootballClubEntity** and **Player** entities will still remain.

        Then, if we change these entities, it will not reflect to the database.

    - **remove()** method

        ```java
        void remove(java.lang.Object entity);
        ```

        Using **CascadeType.ALL**, **remove()** method of **EntityManager** class to the **FootballClubEntity** will remove both the **FootballClubEntity**'s instance and their **PlayerEntity**'s instances from the **PersistenceContext** and the database.

3. The problem of utilizing the **CascadeType.ALL** in **@ManyToOne** annotation

    For example:

    ```java
    public class User {
        @OneToMany(fetch = FetchType.EAGER)
        protected Set<Address> userAddresses;
    }

    public class Address {
        @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
        protected User addressOwner;
    }
    ```

    In this our problem, if we remove an Address record, then it would lead to remove the related User. As a User can have multiple addresses, the other addresses would become orphans.

    To fix this problem, we can use **mappedBy** parameter in User class's OneToMany, and remove the **CascadeType.ALL** in Address class's @ManyToOne annotation.

<br>

## Best practices for one-to-many relationship





<br>

## Wrapping up




<br>

Refer:

[https://www.baeldung.com/hibernate-one-to-many](https://www.baeldung.com/hibernate-one-to-many)

[https://docs.oracle.com/javaee/6/api/javax/persistence/OneToMany.html](https://docs.oracle.com/javaee/6/api/javax/persistence/OneToMany.html)

[https://www.baeldung.com/jpa-join-column](https://www.baeldung.com/jpa-join-column)

[https://docs.oracle.com/cd/E19798-01/821-1841/6nmq2cpav/index.html](https://docs.oracle.com/cd/E19798-01/821-1841/6nmq2cpav/index.html)

[https://vladmihalcea.com/the-best-way-to-map-a-onetomany-association-with-jpa-and-hibernate/]|(https://vladmihalcea.com/the-best-way-to-map-a-onetomany-association-with-jpa-and-hibernate/)