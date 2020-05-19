---
layout: post
title: Odd Even Linked List
bigimg: /img/image-header/yourself.jpeg
tags: [Data Structure, Linked List]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Brute force solution](#brute-force-solution)
- [The optimization way](#the-optimization-way)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Brute force solution

To use brute force algorithm, we will do some steps:
- Create odd linked list
- At the odd position, push this node into odd linked list.

- Create even linked list
- At the even position, push this node into even linked list.

Below is the source code of this way:

```java
public static void main(String[] args) {
    ListNode first = new ListNode(1);
    ListNode second= new ListNode(2);
    ListNode third= new ListNode(3);
    ListNode four = new ListNode(4);
    ListNode five = new ListNode(5);
    ListNode six = new ListNode(6);

    first.next = second;
    second.next = third;
    third.next = four;
    four.next = five;

    ListNode head = oddEvenList(first);
    print(head);
}

public static ListNode oddEvenList(ListNode head) {
    if (head == null || head.next == null || head.next.next == null) {
        return head;
    }

    // odd list
    ListNode oddHeadNode = new ListNode(head.val);;
    ListNode tmp = head.next.next;
    ListNode tmpOddNode = oddHeadNode;
    ListNode endOddNode = null;

    while (tmp != null) {
        tmpOddNode.next = new ListNode(tmp.val);

        if (tmp.next == null) {
            endOddNode = tmpOddNode.next;
            break;
        }

        tmp = tmp.next.next;
        endOddNode = tmpOddNode.next;
        tmpOddNode = tmpOddNode.next;
    }

    // even list
    ListNode evenHeadNode = new ListNode(head.next.val);
    ListNode tmpEvenNode = evenHeadNode;
    tmp = head.next.next.next;

    while (tmp != null) {
        tmpEvenNode.next = new ListNode(tmp.val);

        if (tmp.next == null) {
            break;
        }

        tmp = tmp.next.next;
        tmpEvenNode = tmpEvenNode.next;
    }

    // combine odd and even list
    endOddNode.next = evenHeadNode;
    return oddHeadNode;
}

public static void print(ListNode head) {
    ListNode tmp = head;
    while (tmp != null) {
        System.out.print("" + tmp.val + " --> ");
        tmp = tmp.next;
    }

    System.out.println("null");
}

class ListNode {
    int val;
    ListNode next;

    ListNode() {
    }

    ListNode(int val) {
        this.val = val;
    }

    ListNode(int val, ListNode next) {
        this.val = val;
        this.next = next;
    }
}
```

The complexity of this problem:
- Time complexity: O(n)
- Space complexity: O(n)


<br>

## The optimization way


```java

```


The complexity of this problem:
- Time complexity: O(n)
- Space complexity: O(1)

<br>

## Wrapping up




