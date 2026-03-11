---
layout: post
title: Leetcode 1365 - How Many Numbers Are Smaller Than the Current Number
bigimg: /img/image-header/yourself.jpeg
tags: [Binary Search]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- []()
- []()
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Given a 2D matrix `matrix`, handle multiple queries of the following type:

- Calculate the sum of the elements of `matrix` inside the rectangle defined by its upper left corner `(row1, col1)` and lower right corner `(row2, col2)`.

Implement the NumMatrix class:

- `NumMatrix(int[][] matrix)` Initializes the object with the integer matrix `matrix`.
- `int sumRegion(int row1, int col1, int row2, int col2)` Returns the sum of the elements of `matrix` inside the rectangle defined by its upper left corner `(row1, col1)` and lower right corner `(row2, col2)`.

You must design an algorithm where `sumRegion` works on `O(1)` time complexity.

Example 1:

- Input:

    ```
    ["NumMatrix", "sumRegion", "sumRegion", "sumRegion"]
    [[[[3, 0, 1, 4, 2], [5, 6, 3, 2, 1], [1, 2, 0, 1, 5], [4, 1, 0, 1, 7], [1, 0, 3, 0, 5]]], [2, 1, 4, 3], [1, 1, 2, 2], [1, 2, 2, 4]]
    ```

- Output:

    ```
    [null, 8, 11, 12]
    ```

- Explanation:

    ```
    NumMatrix numMatrix = new NumMatrix([[3, 0, 1, 4, 2], [5, 6, 3, 2, 1], [1, 2, 0, 1, 5], [4, 1, 0, 1, 7], [1, 0, 3, 0, 5]]);
    numMatrix.sumRegion(2, 1, 4, 3); // return 8 (i.e sum of the red rectangle)
    numMatrix.sumRegion(1, 1, 2, 2); // return 11 (i.e sum of the green rectangle)
    numMatrix.sumRegion(1, 2, 2, 4); // return 12 (i.e sum of the blue rectangle)
    ```


<br>

## Using Prefix Sum

```Java
class NumMatrix {

    private int[][] matrix;
    private int[][] prefixSum;

    public NumMatrix(int[][] matrix) {
        this.matrix = matrix;
        this.prefixSum = this.calculatePrefixSum(matrix);
    }
    
    public int sumRegion(int row1, int col1, int row2, int col2) {
        int nRows = matrix.length;
        int nCols = matrix[0].length;

        if ((row1 < 0 ||row1 > nRows) || (row2 < 0 || row2 > nRows) || row1 > row2) {
            return Integer.MIN_VALUE;
        }

        if ((col1 < 0 || col1 > nCols) || (col2 < 0 || col2 > nCols) || col1 > col2) {
            return Integer.MIN_VALUE;
        }

        int sum = 0;
        for (int i = row1; i <= row2; ++i) {
            sum += prefixSum[i][col2 + 1] - prefixSum[i][col1];
        }

        System.out.println("Row1: " + row1 + ", Col1: " + col1 + ", Row2: " + row2 + ", Col2: " + col2 + " --> Sum: " + sum);
        return sum;
    }

      private int[][] calculatePrefixSum(int[][] matrix) {
        int[][] prefix = new int[matrix.length][matrix[0].length + 1];

        for (int i = 0; i < matrix.length; ++i) {
            int[] sum = new int[matrix[0].length + 1];
            sum[0] = 0;

            for (int j = 0; j < matrix[0].length; ++j) {
                sum[j + 1] = sum[j] + matrix[i][j];
            }

            prefix[i] = sum;
        }

        return prefix;
    }
}

/**
 * Your NumMatrix object will be instantiated and called as such:
 * NumMatrix obj = new NumMatrix(matrix);
 * int param_1 = obj.sumRegion(row1,col1,row2,col2);
 */
```

The complexities of this solution:

- Time complexity:
- Space complexity:


<br>

## 





<br>

## Wrapping up




<br>

Refer:

[304. Range Sum Query 2D - Immutable](https://leetcode.com/problems/range-sum-query-2d-immutable/description/)
