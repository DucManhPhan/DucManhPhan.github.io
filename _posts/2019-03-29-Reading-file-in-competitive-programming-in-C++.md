---
layout: post
title: Reading file in competitive programming in C++
bigimg: /img/image-header/california.jpg
tags: [C++]
---

In competive programming, reading file is a basic technique that we have to implement. So, in this article, we will discuss about reading file in competitive programming in C++.

<br>

## Table of contents
- [Use fast I/O](#use-fast-i/o)
- [Some ways to read data in C++](#some-ways-to-read-data-in-c++)
- [Advantages of \<iostream\> over \<cstdio\>](#advantages-of-<iostream>-over-<cstdio>)


<br>

## Use fast I/O
When we're working with file, it is often recommended to use ```scanf``` / ```printf``` instead of ```cin``` / ```cout``` for a fast input and output. However, we can still use ```cin``` / ```cout``` that have still the same speed as ```scanf``` / ```printf``` by including two lines in the beginning of main function:
- ```ios_base::sync_with_stdio(false);```

    It toggles on or off the synchronization of all the C++ standard stream with their corresponding standard C streams if it is called before the program performs its first input or output operation.

    Adding ```ios_base::sync_with_stdio(false);``` (which is true by default) before any I/O operation avoids this synchronization. It is a static member of function ```std::ios_base```.

- ```cin.tie(NULL);```

    ```tie()``` is a method which simply gurantees the flushing of ```std::cout``` before ```std::cin``` accepts an input. This is useful for interactive console programs which require the console to be updated constantly but also slows down the program for large I/O.

For example:

```C++
#include <iostream>


int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    ...
}
```

<br>

## Some ways to read data in C++
Assuming that our data has the following format:

```
5 3
6 4
7 1
10 5
11 6
12 3
12 4
```

The below is two ways to read data:
- Read token by token

    ```C++
    #include <fstream>

    std::ifstream infile("file.txt");
    if (!infile.is_open()) {
        return;
    }

    int a, b;
    while (infile >> a >> b) {
        // process data here
    }
    ```

- Line-based parsing, using string stream

    ```C++
    #include <fstream>
    #include <sstream>
    #include <string>

    std::ifstream infile("file.txt");
    if (!infile.is_open()) {
        return;
    }

    std::string line;
    while (std::getline(infile, line)) {
        std::stringstream iss(line);
        int a, b;

        if (!(iss >> a >> b)) {
            break;
        }

        // process data here
    }
    ```

- Use Boost's file_descritpion_source

    ```C++
    #include <boost/iostreams/device/file_descriptor.hpp>
    #include <boost/iostreams/stream.hpp>
    #include <fcntl.h>

    namespace io = boost::iostreams;

    void readLineByLineBoost() {
        int fdr = open(FILENAME, O_RDONLY);
        if (fdr >= 0) {
            io::file_descriptor_source fdDevice(fdr, io::file_descriptor_flags::close_handle);
            io::stream <io::file_descriptor_source> in(fdDevice);
            if (fdDevice.is_open()) {
                std::string line;
                while (std::getline(in, line)) {
                    // using printf() in all tests for consistency
                    printf("%s", line.c_str());
                }
                fdDevice.close();
            }
        }
    }
    ```

- Use C code

    ```C
    FILE* fp = fopen(FILENAME, "r");
    if (fp == NULL)
        exit(EXIT_FAILURE);

    char* line = NULL;
    size_t len = 0;
    while ((getline(&line, &len, fp)) != -1) {
        // using printf() in all tests for consistency
        printf("%s", line);
    }

    fclose(fp);

    if (line)
        free(line);
    ```

<br>

## Some pitfalls of cin / cout
- By default, cin / cout waste time synchronizing themselves with the C library's stdio buffers, so that we can freely intermix calls to scanf / printf with operations on cin / cout.

    ```C++
    std::ios_base::sync_with_stdio(false);
    ```

- Many C++ tutorials tell us to write ```std::cout << std::endl;``` instead of ```cout << "\n";```. But ```std::endl``` is actually slower because it forces a flush, which is usually unnecessary (We'd need to flush if we were writing an interactive progress bar, but not when writing a million lines of data).

- There was a bug in very old versions of ```GCC``` (pre-2004) that significantly slowed down C++ ```iostreams```. Don’t use ancient compilers.

Avoid these pitfalls, ```cin``` / ```cout``` will be just as fast as ```scanf``` / ```printf```. This is probably because ```scanf``` / ```printf``` need to interpret their format string argument at runtime and incur the overhead of ```varargs``` for the other arguments, while the overhead resolution for ```cin``` / ```cout``` all happens at compile time. In any case, the difference is small enough that we do not have to care either way, since almost no reasonable code performs so much input / output for that differences to matter.

<br>

## Advantages of \<iostream\> over \<cstdio\>
==> Increase type safety, reduce errors, allow extensibility, and provide inheritability.

```printf()``` is arguably not broken, and ```scanf()``` is perhaps livable despite being error prone, however both are limited with respect to what C++ I/O can do. C++ I/O (using << and >>) is, relative to C (using ```printf()``` and ```scanf()```):

- More type-safe: With \<iostream\>, the type of object being I/O’d is known statically by the compiler. In contrast, \<cstdio\> uses "%" fields to figure out the types dynamically.

- Less error prone: With \<iostream\>, there are no redundant "%" tokens that have to be consistent with the actual objects being I/O’d. Removing redundancy removes a class of errors.

- Extensible: The C++ \<iostream\> mechanism allows new user-defined types to be I/O’d without breaking existing code. Imagine the chaos if everyone was simultaneously adding new incompatible "%" fields to ```printf()``` and ```scanf()```?!

- Inheritable: The C++ \<iostream\> mechanism is built from real classes such as ```std::ostream``` and ```std::istream```. Unlike \<cstdio\>’s ```FILE*```, these are real classes and hence inheritable. This means you can have other user-defined things that look and act like streams, yet that do whatever strange and wonderful things you want. You automatically get to use the zillions of lines of I/O code written by users you don’t even know, and they don’t need to know about your “extended stream” class.

<br>

Thanks for your reading.

<br>

Refer:

[https://stackoverflow.com/questions/7868936/read-file-line-by-line-using-ifstream-in-c](https://stackoverflow.com/questions/7868936/read-file-line-by-line-using-ifstream-in-c)

[http://www.cplusplus.com/doc/tutorial/files/](http://www.cplusplus.com/doc/tutorial/files/)

[http://www.parashift.com/c++-faq-lite/iostream-vs-stdio.html](http://www.parashift.com/c++-faq-lite/iostream-vs-stdio.html)

[https://gehrcke.de/2011/06/reading-files-in-c-using-ifstream-dealing-correctly-with-badbit-failbit-eofbit-and-perror/](https://gehrcke.de/2011/06/reading-files-in-c-using-ifstream-dealing-correctly-with-badbit-failbit-eofbit-and-perror/)