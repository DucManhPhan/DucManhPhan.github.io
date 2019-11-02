---
layout: post
title: How to write simple scripts in Ubuntu
bigimg: /img/image-header/road-to-solution.jpeg
tags: [Ubuntu, Linux]
---




<br>

## Table of contents





<br>

## Use different interpreter in script file 

- Use bash script

    ```bash
    #!/bin/bash
    echo "Hello, world!"
    echo "User - $USER, Directory - $HOME"
    ```

- Use Python interpreter

    ```bash
    #!/usr/bin/python
    ...
    ```

```#!/bin/bash``` or ```#!/usr/bin/python``` is known as hash bang, or shebang. Basically, it just tells the shell which interpreter to use to run the commands inside the script.

<br>

## Some useful statements in bash script






<br>

## Some necessary operators
- Compare opertor

    ```-eq``` = check whether the value is equal to something.
    
    ```-ne``` = not equal
    
    ```-gt``` = greater than
     
     ```-ge``` = greater than or equal

     ```-lt``` = less than





<br>

## Installing packages in Ubuntu

```bash
#!/bin/bash

# Install Apache if it's not already present
if [ -f /usr/sbin/apache2 ]; then
    sudo apt install -y apache2
    sudo apt install -y libapache2-mod-php7.2
    sudo a2enmod php
    sudo systemctl restart apache2
fi
```

- Check for existence of the apache2 library

    Use ```-f``` option specifies that we're looking for a file.

    If we want to check for existence of a directory, use ```-d``` option.

    ```!``` operator - exclamation mark is an inverse, it means we're checking if something is not present.

- Install packages

    We can use ```-y``` option to omit some confirmation that process's installing package is required.

- ```if``` statement

    We should close out ```if``` statement with the word fi backward - ```fi```. If we forgot to do this, the script will fail.

<br>

## 





<br>

## 




<br>

## Wrapping up





<br>

Refer:

[]()
