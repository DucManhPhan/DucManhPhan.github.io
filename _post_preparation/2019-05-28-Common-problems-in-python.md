---
layout: post
title: Common problems in Python
bigimg: /img/image-header/california.jpg
tags: [Python]
---



<br>

## Table of contents
- [Merge two tuples into dictionary](#merge-two-tuples-into-dictionary)
- [Check list is null](#check-list-is-null)
- []()

<br>

## Merge two tuples into dictionary
We can use the following way:

```python
keys = ('name', 'age', 'food')
values = ('Bill Gate', '60', 'Hamburger')

map = dict(zip(keys, values))
```

or 

```python
t = ((1, 'a'), (2, 'b'))
map = dict((y, x) for x, y in t)

# OR

map = dict(map(reversed, t))

```

<br>

## Check list is null

```python
if not a:
    print('List is empty.\n')

# OR
if len(a) == 0:
    print('List is empty.\n')

# OR
if a == []:
    print('List is empty.\n')
```




<br>

## Wrapping up




<br>

Refer:

[]()