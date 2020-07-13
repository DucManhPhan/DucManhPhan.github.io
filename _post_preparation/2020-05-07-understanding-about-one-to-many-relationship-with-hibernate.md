---
layout: post
title: Understanding about OneToMany relationship with Hibernate
bigimg: /img/image-header/yourself.jpeg
tags: [Hibernate]
---



<br>

## Table of contents





<br>

## Given problem






<br>

## How to use @OneToMany annotation

To understand how @OneToMany annotation work, we can read about the article [The best way to map a @OneToMany relationship with JPA and Hibernate](https://vladmihalcea.com/the-best-way-to-map-a-onetomany-association-with-jpa-and-hibernate/).




<br>

## Some concepts that we need to know about relationships


1. The owning side




2. The inverse side



3. Bidirectional relationship



4. Unidirectional relationship



<br>

## Understanding parameters of @JoinColumn annotation 

1. 



2. 


3. 



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


<br>

## Understanding parameters of @ManyToOne annotation 





<br>

## Some questions about one-to-many relationship

1. The difference between **orphanRemoval** parameter and **cascade.REMOVE** parameter





2. 



<br>

## Wrapping up




<br>

Refer:

[https://www.baeldung.com/hibernate-one-to-many](https://www.baeldung.com/hibernate-one-to-many)

[https://docs.oracle.com/javaee/6/api/javax/persistence/OneToMany.html](https://docs.oracle.com/javaee/6/api/javax/persistence/OneToMany.html)

[https://www.baeldung.com/jpa-join-column](https://www.baeldung.com/jpa-join-column)

[https://docs.oracle.com/cd/E19798-01/821-1841/6nmq2cpav/index.html](https://docs.oracle.com/cd/E19798-01/821-1841/6nmq2cpav/index.html)