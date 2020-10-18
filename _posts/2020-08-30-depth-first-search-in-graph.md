---
layout: post
title: Depth First Search in Graph
bigimg: /img/image-header/yourself.jpeg
tags: [Graph]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Definition of Graph](#definition-of-graph)
- [Using recursive version](#using-recursive-version)
- [Using iterative version](#using-iterative-version)
- [Applications of DFS](#applications-of-dfs)
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

1. Use adjacency list version

    ```java
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

    public class Demo {
        public static void main(String[] args) {
            int capacity = 7;
            ALGraph graph = initALGraph(capacity);
            boolean[] visited = new boolean[capacity];

            dfs(graph, visited, new Node(1));
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
    ```

2. Using adjacency matrix version

    ```java
    public class AMGraph {
        private int[][] graph;
        private int capacity;

        public AMGraph(int capacity) {
            this.capacity = capacity;
            this.graph = new int[capacity][capacity];
        }

        public int getCapacity() {
            return this.capacity;
        }

        public boolean isAnEdge(int u, int v) {
            return this.graph[u][v] == 1;
        }

        public void addEdge(int u, int v) {
            this.graph[u][v] = 1;
            this.graph[v][u] = 1;
        }

        public void display() {
            for (int i = 1; i < this.capacity; ++i) {
                System.out.println("Vertex " + i + " connect with: ");

                for (int j = 1; j < this.capacity; ++j) {
                    if (this.graph[i][j] == 1) {
                        System.out.print(" --> " + j + " ");
                    }
                }

                System.out.println();
            }
        }
    }

    public class Demo {
        public static void main(String[] args) {
            int capacity = 7;
            AMGraph graph = new AMGraph(capacity);
            boolean[] visited = new boolean[capacity];

            dfs(graph, visited, 1);
        }

        public void initAMGraph(int capacity) {
            AMGraph graph = new AMGraph(capacity);

            graph.addEdge(1, 2);
            graph.addEdge(1, 3);
            graph.addEdge(2, 4);
            graph.addEdge(2, 5);
            graph.addEdge(3, 5);
            graph.addEdge(4, 5);
            graph.addEdge(4, 6);
            graph.addEdge(5, 6);
            return graph;
        }
    }
    ```

<br>

## Using recursive version

1. In adjacency list version

    ```java
    /**
    * Using recursive version
    *
    * Result: 1 --> 2 --> 4 --> 5 --> 3 --> 6
    *
    * @param graph
    * @param visited
    * @param node
    */
    public static void dfs(ALGraph graph, boolean[] visited, Node node) {
        Objects.requireNonNull(node);

        if (visited[node.value]) {
            return;
        }

        visited[node.value] = true;
        System.out.print("" + node.value + " --> ");

        List<Node> nodes = graph.getNodesWith(node.value);
        for (Node tmpNode : nodes) {
            dfs(graph, visited, tmpNode);
        }
    }
    ```

    The dfs in the recursive version is as same as the source code in [Preorder traversal in Binary Tree](https://ducmanhphan.github.io/2020-01-09-Preorder-traversal-in-Binary-Tree/).

    Using a boolean array - **visited** to mark nodes that is iterated. It makes us do not touch it in twice times.

2. In adjacency matrix version

    ```java
    public static void dfs(AMGraph graph, boolean[] visited, int node) {
        System.out.print("" + node + " --> ");
        visited[node] = true;

        for (int i = 1; i < graph.getCapacity(); ++i) {
            if (graph.isAnEdge(node, i) && !visited[i]) {
                dfs(graph, visited, i);
            }
        }
    }
    ```


<br>

## Using iterative version

1. In adjacency list version

    ```java
    public static void dfsUnRecursive(ALGraph graph, boolean[] visited) {
        Stack<Node> stkNodes = new Stack<>();
        stkNodes.push(new Node(1));

        while (!stkNodes.isEmpty()) {
            Node topNode = stkNodes.pop();

            // prepare for the node iterate in twice times
            if (!visited[topNode.value]) {
                visited[topNode.value] = true;
                System.out.print("" + topNode.value + " --> ");
            }

            List<Node> childNodes = graph.getNodesWith(topNode.value);
            for (Node tmpNode : childNodes) {
                if (!visited[tmpNode.value]) {
                    stkNodes.push(tmpNode);
                }
            }
        }
    }
    ```

<br>

## Applications of DFS

- Minimum spanning tree

- Detecting cycle in the graph

- Find path between the two vertices

- Topological sorting

- Check bipartite graph

- Find the strongly connected components

- Maze solution

<br>

## Wrapping up

- Understanding how to use DFS algorithm.

- This DFS algorithm has so many applications, we can refer [Applications of Depth First Search](https://www.geeksforgeeks.org/applications-of-depth-first-search/).
