---
layout: post
title: Coin Change II
bigimg: /img/image-header/yourself.jpeg
tags: [Backtracking, Dynamic Programming]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using backtracking](#use-backtracking)
- [Using Stack to optimize the backtracking version](#using-stack-to-optimize-the-backtracking-version)
- [Using memoization for backtracking version](#using-memoization-for-backtracking-version)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

You are given coins of different denominations and a total amount of money. Write a function to compute the number of combinations that make up that amount. You may assume that you have infinite number of each kind of coin.

```
Example 1:
    Input: amount = 5, coins = [1, 2, 5]
    Output: 4
    Explanation: there are four ways to make up the amount:
    5=5
    5=2+2+1
    5=2+1+1+1
    5=1+1+1+1+1

Example 2:
    Input: amount = 3, coins = [2]
    Output: 0
    Explanation: the amount of 3 cannot be made up just with coins of 2.

Example 3:
    Input: amount = 10, coins = [10] 
    Output: 1
```

Notes:
- 0 <= amount <= 5000
- 1 <= coin <= 5000
- the number of coins is less than 500
- the answer is guaranteed to fit into signed 32-bit integer

<br>

## Using backtracking

To iterate all solutions of this problem, we will use Backtracking to solve it.

```java
public class Solution {
    private int count = 0;    

    public int changeBacktracking(int amount, int[] coins) {
        backtracking(amount, coins, 0);
        return this.count;
    }

    public void backtracking(int amount, int[] coins, int idx) {
        if (amount < 0) {
            return;
        }

        if (amount == 0) {
            ++count;
            return;
        }

        for (int i = idx; i < coins.length; ++i) {
            backtracking(amount - coins[i], coins, i);
        }
    }
}
```


<br>

## Using Stack to optimize the backtracking version

Instead of using backtracking, we will use stack data structure to implement with loop.

```java
public class Solution {
    private int count = 0;

    private void useStack(int amount, int[] coins) {
        Stack<StkNode> stk = new Stack<>();
        stk.push(new StkNode(amount, 0));

        StkNode tmp = null;
        int i = 0;

        while (!stk.isEmpty()) {
            int currentIdx = i;

            while (currentIdx < coins.length) {
                tmp = stk.peek();
                int currentCoins = tmp.amount - coins[currentIdx];
                if (currentCoins < 0) {
                   ++currentIdx;
                } else if (currentCoins == 0) {
                    ++this.count;
                    ++currentIdx;
                } else {
                    stk.push(new StkNode(currentCoins, currentIdx));
                }
            }

            i = stk.peek().idx + 1;
            stk.pop();
        }
    }

    private static class StkNode {
        public int amount;
        public int idx;

        public StkNode(int amount, int idx) {
            this.amount = amount;
            this.idx = idx;
        }

        @Override
        public String toString() {
            return this.amount + "-" + this.idx;
        }
    }
}
```

<br>

## Using memoization for backtracking version

This is a way that my coworker offers to optimize the backtracking version. With this solution, it passed all test case in leetcode.

```java
public class Solution {
        private static class Node implements Comparable<Node> {
        public static final Node ZERO = new Node(0, 0);

        private final int amount;
        private final int index;

        public Node(int amount, int index) {
            this.amount = amount;
            this.index = index;
        }

        public int getAmount() {
            return amount;
        }

        public int getIndex() {
            return index;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Node node = (Node) o;
            return amount == node.amount && index == node.index;
        }

        @Override
        public int hashCode() {
            return Objects.hash(amount, index);
        }

        @Override
        public String toString() {
            return String.format("\"%s-%s\"", amount, index);
        }

        @Override
        public int compareTo(Node o) {
            int cAmount = Integer.compare(this.amount, o.amount);
            return cAmount == 0 ? Integer.compare(this.index, o.index) : cAmount;
        }
    }

    public int change(int amount, int[] coins) {
        long startMs = System.currentTimeMillis();

        List<Integer> list = Arrays.stream(coins).boxed().sorted().collect(Collectors.toList());
        Map<Node, Set<Node>> mem = new HashMap<>();
        mem.put(Node.ZERO, Collections.singleton(Node.ZERO));
        Node root = create(mem, amount, list.size());
        memoise(mem, list, root);

        Map<Node, Integer> count = new HashMap<>();
        count.put(Node.ZERO, 1);
        mem.keySet().stream().sorted()
                .forEach(k -> count.put(k, count.containsKey(k)
                        ? count.get(k)
                        : mem.get(k).stream().sorted().map(count::get).reduce(0, Integer::sum)));
        long timeMs = System.currentTimeMillis() - startMs;
        System.out.println("Time use node: " + timeMs);

        return count.get(root);
    }

    private Node create(Map<Node, Set<Node>> mem, int amount, int idx) {
        Node node = new Node(amount, idx);
        if (!mem.containsKey(node)) {
            mem.put(node, new HashSet<>());
        }
        return node;
    }

    private void memoise(Map<Node, Set<Node>> mem, List<Integer> list, Node root) {
        IntStream.range(0, root.getIndex())
                .forEach(i -> {
                    Set<Node> children = mem.get(root);
                    if (root.getAmount() == 0) {
                        children.add(Node.ZERO);
                        return;
                    }
                    int amount = root.getAmount() - list.get(i);
                    if (amount == 0) {
                        children.add(Node.ZERO);
                    } else if (amount > 0) {
                        Node node = create(mem, amount, i + 1);
                        if (!children.contains(node)) {
                            children.add(node);
                            memoise(mem, list, node);
                        }
                    }
                });
    }
}
```

<br>

## Wrapping up

- Understanding about how to use stack to convert the backtracking to the loop version.

- Thinking carefully about two properties of Dynamic Programming: Optimal substructures and Overlapping problems.

<br>

Refer:

[https://leetcode.com/problems/coin-change-2/](https://leetcode.com/problems/coin-change-2/)