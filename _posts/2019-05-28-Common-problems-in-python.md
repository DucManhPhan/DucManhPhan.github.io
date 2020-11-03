---
layout: post
title: Common problems in Python
bigimg: /img/image-header/california.jpg
tags: [Python]
---

Python is created by Guido van Rossum in 1991 and developed by Python Software Foundation. It was primarily enhanced for emphasis on code readability, and its syntax allows programmers to express concepts in fewer lines of code.

So, nowadays, Python can be programmed in many applications such as:
- Web development: Web framework Django, Flask.
- Machine Learning
- Data Analysis
- Scripting
- Game development
- Embedded applications
- Desktop applications

Therefore, Utilizing Python will always cope with many common problems, and some tricks. In this article, we will discuss about some problems that we need to know.

<br>

## Table of contents
- [Merge two tuples into dictionary](#merge-two-tuples-into-dictionary)
- [Check list is null](#check-list-is-null)
- [Swap values of two variables](#swap-values-of-two-variables)
- [Get input from command line](#get-input-from-command-line)
- [Working with modules](#working-with-modules)
- [Wrapping up](#wrapping-up)

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

## Swap values of two variables

```python
a, b = b, a
```

<br>

## Get input from command line

```python
name = raw_input('What is your name?')
number = int(raw_input('Number of children: '))
```

The variable that recieve data from ```raw_input()``` method has string data type. So, we need to convert it to use it.

<br>

## Loops in Python
- ```for``` loop

    ```python
    for x in range(0, 3):
        print("The value of x is: " + x)

    # OR
    for x in range(1, 10):
        for y in range(1, 10):
            print('%d * %d = ' %(x, y, x * y))
    ```

- ```while``` loop

    ```python
    x = 1
    while True:
        if x > 10:
            break

        x += 1
    ```

- Loop with indexes

    ```python
    presidents = ["Washington", "Adams", "Jefferson", "Madison", "Monroe", "Jackson"]
    for i in range(len(presidents)):
        print("President {}: {}".format(i + 1, presidents[i]))

    # OR using enumerate
    for num, name in enumerate(presidents, start = 1):
        print("President {}: {}".format(num, name))

    ```

    The ```enumerate``` function creates an iterable where each element is a tuple that contains the index of the item and the original item value. The ```start = 1``` option to ```enumerate``` is optional. By default, it will start counting at ```0```.

    This function will solve the task of:
    - Accessing each item in a list (or another iterable).
    - Getting the index of each item accessed.

- Loop over multiple lists at the same time --> Use zip

    ```python
    colors = ["red", "green", "blue", "purple"]
    ratios = [0.2, 0.3, 0.1, 0.4]

    for color, ratio in zip(colors, ratios):
        print("{}% {}".format(ratio * 100, color))
    ```

Note about ```range``` and ```xrange```: 
- In Python 2.x, we can use both ```range``` and ```xrange```. But in Python 3, we only use ```range```.
- In Python 2.x, ```range()``` returns a list of numbers --> So, ```range``` return a ```list``` object. To Python 3, ```range``` returns a range object.
- ```xrange()``` returns the generator object that can be used to display numbers only by looping. Only particular range is displayed on demand and hence called ```lazy evaluation``` --> So, ```xrange``` returns ```xrange``` object.
- ```xrange``` use less memory, and should the for loop exit early, there's no need to waste time creating the unused numbers. This effect is tiny in smaller lists, but increases rapidly in larger lists.

--> ```range``` is faster if iterating over the same sequence multiple times.

--> ```xrange``` has to reconstruct the integer object every time, but ```range``` will have real integer objects.

<br>

## Convert dynamic Python object to JSON

```python
json.dumps(data, default = lambda o: o.__dict__)
```

<br>

## Reversing string

```python
str = 'abc'
str = str[::-1]
```

<br>

## Get common element in two sets

```python
s1= {4, 5, 7, 6}
s2 = {1, 2, 4, 5, 6}

s_common = s1.intersection(s2)
```

<br>

## Get the differences between two sets

```python
s1= {4, 5, 7, 6}
s2 = {1, 2, 4, 5, 6}

s_differ = s1.difference(s2)
```

<br>

## Get distinct combined set of two sets

```python
s1= {4, 5, 7, 6}
s2 = {1, 2, 4, 5, 6}

s_union = s1.union(s2)
```

<br>

## Pass unknown arguments

```python
def func(*args):
    return first_arg

func(first_arg)
func(first_arg, second_arg)
func(first_arg, second_arg, third_arg)
```

<br>

## Working with modules
All information in this section is referred from this [link](https://stackoverflow.com/questions/419163/what-does-if-name-main-do).

```python
# Suppose this is foo.py.

print("before import")
import math

print("before functionA")
def functionA():
    print("Function A")

print("before functionB")
def functionB():
    print("Function B {}".format(math.sqrt(100)))

print("before __name__ guard")
if __name__ == '__main__':
    functionA()
    functionB()
print("after __name__ guard")
```

Whenever the Python interpreter reads a source file, it does two things:
- It sets a few special variables like ```__name__```, and then
- It executes all of the code found in this file.

1. When your module is the main program

    If you are running your module (the source file) as the main program, e.g.

    ```python
    python foo.py
    ```

    The interpreter will assign the hard-coded string ```"__main__"``` to the ```__name__``` variable, i.e.

    ```python
    # It's as if the interpreter inserts this at the top
    # of your module when run as the main program.
    __name__ = "__main__" 
    ```

2. When your module is imported by another

    On the other hand, suppose some other modules is the main program and it imports your module. This means there's a statement like this in the main program, or in some other module the main program imports:

    ```
    # Suppose this is in some other main program.
    import foo
    ```

    In this case, the interpreter will look at the filename of your module, foo.py, strip off the .py, and assign that string to your module's ```__name__``` variable, i.e.

    ```
    # It's as if the interpreter inserts this at the top
    # of your module when it's imported from another module.
    __name__ = "foo"
    ```

3. Executing the module's code

    After the special variables are set up, the interpreter executes all the code in the module, one statement at a time. You may want to open another window on the side with the code sample so you can follow along with this explanation.

    - Always

        - In prints the string ```before import``` (without quotes).
        - It loads the ```math``` module and assigns it to a variable called ```math```. This is equivalent to replacing ```import math``` with the following (note that ```__import``` is a low level function in Python that takes a string and triggers the actual import).

            ```python
            # Find and load a module given its string name, "math",
            # then assign it to a local variable called math.
            math = __import__("math")
            ```
        - It prints the string ```before functionA```.
        - It executes the ```def``` block, creating a function object, then assigning that function object to a variable called ```functionA```.
        - It prints the string ```before functionB```.
        - It executes the ```def``` block, creating another function object, then assigning that function object to a variable called ```functionB```.
        - It prints the string ```before __name__ guard```.

    - Only when your module is the main program

        - If your module is the main program, then it will see that ```__name__``` was indeed set to ```__main__``` and it calls the two functions, printing the strings "Function A" and "Function B 10.0".

    - Only when your module is imported by another

        - If your module is not the main program but was imported by another one, then ```__name__``` will be "foo", not ```__main__```, and it'll skip the body of the if statement.

    - Always

        - It will print the string ```after __name__ guard``` in both situations.

<br>

## Wrapping up




<br>

Refer:

[https://snakify.org/en/lessons/for_loop_range/](https://snakify.org/en/lessons/for_loop_range/)

[https://treyhunner.com/2016/04/how-to-loop-with-indexes-in-python/](https://treyhunner.com/2016/04/how-to-loop-with-indexes-in-python/)