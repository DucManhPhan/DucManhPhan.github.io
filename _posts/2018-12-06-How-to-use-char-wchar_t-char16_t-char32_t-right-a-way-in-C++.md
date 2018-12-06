---
layout: post
title: How to use char, wchar_t, char16_t and char32_t right a way in C++
bigimg: /img/ravashing-beach.jpg
tags: [test]
---

When you worked with the software that need to use the language which is out of English, such as Japanese, Korean, Chinese. The arduous problem can happen in here. 


## wchar_t


In C/C++, it supports the wchar_t type. It is defined as a wide character type. Unfortunately it's size that depends on the compiler. 

Ex: In MSVC, sizeof(wchar_t) = 2 bytes
In GCC, sizeof(wchar_t) = 4 bytes

Using wchar_t in the program doesn't make it correctly that completely support Unicode.

Eventually, this will make so many troubles when you choose an internal encoding in the program.

To improve it, C++11 provides the better suitable character type - char16_t, but you will still encounter troubles in the way conversion string between many other encodings.


Refer: 

[Should you use std::string, std::u16string, or std::u32string?](https://www.ohadsoft.com/2014/11/should-you-use-stdstring-stdu16string-or-stdu32string/)

http://cppwhispers.blogspot.com/2012/11/unicode-and-your-application-1-of-n.html

