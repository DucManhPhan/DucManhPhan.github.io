---
layout: post
title: Range Sum Query - Mutable
bigimg: /img/image-header/yourself.jpeg
tags: [Segment Tree, Fenwick Tree]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force algorithm](#using-brute-force-algorithm)
- [Using prefix sum](#using-prefix-sum)
- [Using Segment Tree](#using-segment-tree)
- [Using Fenwick Tree](#using-fenwick-tree)
- [Using MO algorithm](#using-mo-algorithm)
- [Wrapping up](#wrapping-up)

<br>

## Given problem


Given an array nums and two types of queries where you should update the value of an index in the array, and retrieve the sum of a range in the array.

Implement the NumArray class:
- **NumArray(int[] nums)** - Initializes the object with the integer array nums.
- **void update(int index, int val)** - Updates the value of **nums[index]** to be val.
- **int sumRange(int left, int right)** - Returns the sum of the subarray **nums[left, right]** (i.e., **nums[left] + nums[left + 1], ..., nums[right]**).
 
```java
Example 1:
Input:  ["NumArray", "sumRange", "update", "sumRange"]
        [[[1, 3, 5]], [0, 2], [1, 2], [0, 2]]
Output: [null, 9, null, 8]

Explanation:
    NumArray numArray = new NumArray([1, 3, 5]);
    numArray.sumRange(0, 2); // return 9 = sum([1,3,5])
    numArray.update(1, 2);   // nums = [1,2,5]
    numArray.sumRange(0, 2); // return 8 = sum([1,2,5])
```

Constraints:
- 1 <= nums.length <= 3 * 104
- -100 <= nums[i] <= 100
- 0 <= index < nums.length
- -100 <= val <= 100
- 0 <= left <= right < nums.length
- At most 3 * 104 calls will be made to update and sumRange.

<br>

## Using brute force algorithm

To start out with the brute force algorithm, we will iterate through an array to update and find the sum range.

```java

```

The complexity of this solution:
- Time complexity: O(m * n) with m - the number of queries, n - the length of an array
- Space complexity: O(1)

<br>

## Using prefix sum

To reduce the computing of the brute force algorithm, we can use prefix sum array that was calculated the sum of a subarray. Then, when update or query sumRange(), we only call this prefix sum to return a result.

```java

```

The complexity of this solution:
- Time complexity: 
- Space complexity: 

<br>

## Using Segment Tree

Below is the source code that using segment tree:

```java
class NumArray {
    private SegmentTree tree;
    
    public NumArray(int[] nums) {
        if(nums.length > 0){
            tree = new SegmentTree(nums);
        }
    }
    
    public void update(int i, int val) {
        if(tree == null) return;
        tree.updateTree(tree.root, i, val);
    }
    
    public int sumRange(int i, int j) {
        if(tree == null) return 0;
        return tree.sumRange(tree.root, i, j);
    }
    
    public class Node {
        public Node leftNode;
        public Node rightNode;
        public int leftRange;
        public int rightRange;
        public int sum;     // define fields for problem

        public Node(int leftRange, int rightRange) {
            this.leftRange = leftRange;
            this.rightRange = rightRange;
        }
    }
    
    public class SegmentTree {
        public Node root;

        public SegmentTree(int[] nums) {
            this.root = new Node(0, nums.length - 1);
            this.buildSegmentTree(this.root, nums);
        }

        private Node buildSegmentTree(Node root, int[] nums) {
            if (root.leftRange == root.rightRange) {
                root.sum = nums[root.leftRange];
                return root;
            }

            // use this expression to reduce overflow when number is big
            int mid = root.leftRange + (root.rightRange - root.leftRange) / 2;
            Node left = this.buildSegmentTree(new Node(root.leftRange, mid), nums);
            Node right = this.buildSegmentTree(new Node(mid + 1, root.rightRange), nums);

            root.leftNode = left;
            root.rightNode = right;
            root.sum = left.sum + right.sum;

            return root;
        }

        public void updateTree(Node root, int i, int val) {
            if(root.leftRange == i && root.rightRange == i) {
                root.sum = val;
                return;
            }

            int md = root.leftRange + (root.rightRange - root.leftRange) / 2;
            if (i <= md) {
                updateTree(root.leftNode, i, val);
            } else {
                updateTree(root.rightNode, i, val);
            }

            root.sum = root.leftNode.sum + root.rightNode.sum;
        }

        public int sumRange(Node root, int i, int j) {
            if(root.leftRange == i && root.rightRange == j) {
                return root.sum;
            }

            int md = root.leftRange + (root.rightRange - root.leftRange) / 2;
            if (j <= md) {
                return sumRange(root.leftNode, i, j);
            }
            else if (i > md) {
                return sumRange(root.rightNode, i, j);
            }

            return sumRange(root.leftNode, i, md) + sumRange(root.rightNode, md + 1, j);
        }
    }    
}
```

The complexity of this solution:
- Time complexity: 
- Space complexity: 

<br>

## Using Fenwick Tree

Below is the source code that utilizes Fenwick Tree.

```java

```

The complexity of this solution:
- Time complexity: 
- Space complexity: 

<br>

## Using MO algorithm

Below is the source code that utilizes MO algorithm.

```java

```

The complexity of this solution:
- Time complexity: 
- Space complexity: 

<br>

## Wrapping up

- Understanding about the core of this problem is that it depends largely on the number of queries, and the number elements in an array.

    To reduce the complexity of this problem, we can use Binary Indexed Tree, Segment Tree, or even MO algorithm to deal with it.

<br>

Refer:

[https://leetcode.com/problems/range-sum-query-mutable/](https://leetcode.com/problems/range-sum-query-mutable/)

[https://www.geeksforgeeks.org/mos-algorithm-query-square-root-decomposition-set-1-introduction/](https://www.geeksforgeeks.org/mos-algorithm-query-square-root-decomposition-set-1-introduction/)

[https://vnoi.info/wiki/algo/data-structures/mo-algorithm.md](https://vnoi.info/wiki/algo/data-structures/mo-algorithm.md)