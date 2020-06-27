---
layout: post
title: Common problems in JPA
bigimg: /img/image-header/ravashing-beach.jpg
tags: [JPA]
---



<br>

## Table of contents
- [The difference between CascadeType.REMOVE and orphanRemoval = true](#the-difference-between-cascadetype.remove-and-orphanRemoval-=-true)
- [Delete item that do not exists in database](#delete-item-that-do-not-exists-in-database)
- [Some ways to delete orphans in JPA](#some-ways-to-delete-orphans-in-jpa)
- [StackOverflowError when merge/persist an object into database](#stackoverflowerror-when-merge/persist-an-object-into-database)


<br>

## The difference between CascadeType.REMOVE and orphanRemoval = true

|       Action         | ```orphanRemoval = true``` |     ```CascadeType.ALL```    |
| -------------------- | -------------------------- | ---------------------------- |
| Delete parent        | Deletes parent and orphans | Deletes parent and orphans   |
| Change children list | Delete orphans             | Nothing                      |

<br>

## Delete item that do not exists in database
In RDBMS, if we try to delete an non-existing entry from database using SQL, database does not throw any ```exception/error```. This statement succeeds with message that zero records impacted. 

Hibernate provides just a layer on top of database, and does not create new behaviors.

<br>

## Some ways to delete orphans in JPA




<br>

## Common errors in JPA when working with project

1. ```StackOverflowError``` when merge/persist an object into database

    Assuming that we have two class ```Product``` and ```Category``` that are relevant together by ```@One-to-Many``` annotation.

    ```java
    @Entity
    @NamedQueries({
        @NamedQuery(name= "findAllCategory", query="SELECT c FROM Category c")        
    })
    public class Category implements Serializable
    {
        private static final long serialVersionUID = 1L;

        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        private int category_id;

        ...

        // Remove this relationship.
        @OneToMany(mappedBy = "category_fk")
        private List<Product> product_fk;

        ...

        @Override
        public boolean equals(Object obj) {
            if (obj == null) {
                return false;
            }
            if (getClass() != obj.getClass()) {
                return false;
            }
            final Category other = (Category) obj;
            if (this.category_id != other.category_id) {
                return false;
            }

            ...

            if (this.product_fk != other.product_fk && (this.product_fk == null || !this.product_fk.equals(other.product_fk))) {
                return false;
            }
            return true;
        }
    }

    public class Product implements Serializable
    {
        private static final long serialVersionUID = 1L;

        ...

        @ManyToOne
        private Category category_fk;

        @ManyToOne
        private SaleDetails saleDetails_fk;

        ...

        @Override
        public boolean equals(Object obj) {
            if (obj == null) {
                return false;
            }
            if (getClass() != obj.getClass()) {
                return false;
            }
            final Product other = (Product) obj;
            ...

            if (this.category_fk != other.category_fk && (this.category_fk == null || !this.category_fk.equals(other.category_fk))) {
                return false;
            }
            if (this.saleDetails_fk != other.saleDetails_fk && (this.saleDetails_fk == null || !this.saleDetails_fk.equals(other.saleDetails_fk))) {
                return false;
            }
            return true;
        }
    }
    ```

    We can see that ```Category``` class has list of ```Products``` and in the ```equals()``` method of the ```Category``` class, we are doing like this:

    ```java
    if (this.product_fk != other.product_fk && (this.product_fk == null || !this.product_fk.equals(other.product_fk))) {
        return false;
    }
    ```

    which invokes the ```equals()``` method on the **Product** class, the ```equals()``` method on the **Product** class which does:

    ```java
    if (this.category_fk != other.category_fk && (this.category_fk == null || !this.category_fk.equals(other.category_fk))) {
        return false;
    }
    ```
    which invokes the ```equals()``` method on the ```Category``` once again and the whole process repeats causing an ```Stack overflow```.

    So, we have solution for this problem:
    - Remove the bi-direction dependency.
    - Fix the ```equals()``` method and ```hashCode()``` method.

<br>

## Wrapping up




<br>

Refer:

[https://www.objectdb.com/java/jpa/persistence/delete](https://www.objectdb.com/java/jpa/persistence/delete)

[https://vladmihalcea.com/jpa-persist-and-merge/](https://vladmihalcea.com/jpa-persist-and-merge/)

[https://www.codejava.net/frameworks/hibernate/hibernate-basics-3-ways-to-delete-an-entity-from-the-datastore](https://www.codejava.net/frameworks/hibernate/hibernate-basics-3-ways-to-delete-an-entity-from-the-datastore)

[https://vladmihalcea.com/the-best-way-to-soft-delete-with-hibernate/](https://vladmihalcea.com/the-best-way-to-soft-delete-with-hibernate/)

[https://www.baeldung.com/hibernate-save-persist-update-merge-saveorupdate](https://www.baeldung.com/hibernate-save-persist-update-merge-saveorupdate)

[https://www.eclipse.org/eclipselink/documentation/2.5/jpa/extensions/a_privateowned.htm](https://www.eclipse.org/eclipselink/documentation/2.5/jpa/extensions/a_privateowned.htm)

[https://volute.g-vo.org/svn/tags/vocabularies-1.10/projects/theory/snapdm/external/eclipselinkJpaExtensions/index.html](https://volute.g-vo.org/svn/tags/vocabularies-1.10/projects/theory/snapdm/external/eclipselinkJpaExtensions/index.html)

[https://stackoverflow.com/questions/306144/jpa-cascadetype-all-does-not-delete-orphans/19645397](https://stackoverflow.com/questions/306144/jpa-cascadetype-all-does-not-delete-orphans/19645397)

[https://www.mkyong.com/jpa/jpa-optimistic-lock-exception-in-java-development/](https://www.mkyong.com/jpa/jpa-optimistic-lock-exception-in-java-development/)