---
layout: post
title: Breadth First Search in Graph
bigimg: /img/image-header/yourself.jpeg
tags: [Graph]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Definition of Graph](#definition-of-queue)
- [Using BFS with Queue](#using-bfs-with-queue)
- [When to use](#when-to-use)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Assuming that we have a graph that is described in a below image.

```
   1
 /   \
2     3
|  \  |
4 -- 5
 \  /
  6
```


<br>

## Definition of Graph

Belows are the source code that uses the adjacency list version.

```java
public class Demo {
    public static void main(String[] args) {
        int capacity = 7;
        ALGraph graph = initALGraph(capacity);

        bfs(graph, new Node(1), capacity);
    }

    public static ALGraph initALGraph(int capacity) {
        ALGraph graph = new ALGraph(capacity);

        graph.addEdge(new Node(1), new Node(2));
        graph.addEdge(new Node(1), new Node(3));
        graph.addEdge(new Node(2), new Node(4));
        graph.addEdge(new Node(2), new Node(5));
        graph.addEdge(new Node(3), new Node(5));
        graph.addEdge(new Node(4), new Node(5));
        graph.addEdge(new Node(4), new Node(6));
        graph.addEdge(new Node(5), new Node(6));
        return graph;
    }
}

public class ALGraph {
     private ArrayList<List<Node>> graphs;

     public ALGraph(int capacity) {
         this.graphs = new ArrayList<>(capacity);
         for (int i = 0; i < capacity; ++i) {
             this.graphs.add(new LinkedList<>());
         }
     }

     public List<Node> getNodesWith(int vertex) {
         return this.graphs.get(vertex);
     }

     /**
     * an edge from u vertex to v vertex and vice versa
     *
     * @param u
     * @param v
     */
     public void addEdge(Node u, Node v) {
         Objects.requireNonNull(u);
         Objects.requireNonNull(v);

         this.graphs.get(u.value).add(v);
         this.graphs.get(v.value).add(u);
     }

     public void display() {
         int len = this.graphs.size();
         for (int i = 1; i < len; ++i) {
             List<Node> nodes = this.graphs.get(i);

             System.out.println("Vertex " + i + " connect with: ");
             for (Node node : nodes) {
                 System.out.print(" --> " + node.value + " ");
             }

             System.out.println();
         }
     }
}
```


<br>

## Using BFS with Queue

```java
public static void bfs(ALGraph graph, Node beginNode, int capacity) {
    boolean[] visited = new boolean[capacity];
    Queue<Node> queue = new LinkedList<>();
    queue.add(beginNode);

    while (!queue.isEmpty()) {
        Node currentNode = queue.poll();
        if (visited[currentNode.value]) {
            continue;
        }

        visited[currentNode.value] = true;
        List<Node> nodes = graph.getNodesWith(currentNode.value);

        for (Node tmpNode : nodes) {
            queue.add(tmpNode);
        }

        System.out.print("" + currentNode.value + " --> ");
    }
}
```

<br>

## When to use

- When we want to find the relationship between multiple nodes that has the same level.

<br>

## Wrapping up

- Understanding about the BFS algorithm works.

- How BFS algorithm can be apply in some application --> [Applications of Breadth First Traversal](https://www.geeksforgeeks.org/applications-of-breadth-first-traversal/?ref=lbp).

