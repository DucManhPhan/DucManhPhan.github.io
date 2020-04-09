---
layout: post
title: How to use char, wchar_t, char16_t and char32_t right a way in C++
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Unicode, C++]
---

When you worked with the software that need to use the language which is out of English, such as Japanese, Korean, Chinese. The arduous problem can happen in here.

So today, I will find something out about character types that is supported in C++. When having deep understand about all character types, you will easily convert between utf8, utf16 and utf32.

<br>

## Table of Contents
- [General information about char, wchar_t, char16_t, char32_t](#general-information-about-char-wchar_t-char16_t-char32_t)
- [char type](#char-type)
- [wchar_t type](#wchar_t-type)
- [char16_t type](#char16_t-type)
- [char32_t type](#char32_t-type)
- [Wrapping up](#wrapping-up)

<br>

## General information about char, wchar_t, char16_t, char32_t

To talk about the character types, we have to come back to the time that C and C++ are created. In the 1960s, the C programming language is invented by Dennis Ritchie (September 9, 1941 – c. October 12, 2011), with long-time colleague Ken Thompson.

At this time, C language only supported for the char type. Because during the 1960s, mainframe and mini-computer manufactures began to standardize around the 8-bit byte as their smallest datatype. 

In 1989, the ISO (the abbreviation of **International Organization for Standardization**) began work on the Universal Character Set (UCS), a multilingual character set that could be encoded using either a 16-bit or 32-bit. These larger values required the use of a data type larger than 8-bits to store the new character values in memory. Therefore, the *wide character* was used to differentiate them from traditional 8-bit character data types, but it involves some compiler issues. 

Wide characters aren't necessarily Unicode. Unicode is one possible wide-character encoding.

So, in 1990, the wide character are defined using datatype ```wchar_t```, which in the original ```C90 standard``` was defined as: 

```
"An integral type whose range of values can represent distinct codes for all members of the largest extended character set specified among the support locales."
```

In order to reduce the limit of ```wchar_t``` data type, in 2011, both C11 and C++11 (ISO/IEC 14882:2011) support 16-bit and 32-bit characters, suitable to be encoded using UTF-16 and UTF-32. 

In C, the header file \<cuchar\> defines two macro: char16_t and char32_t, which map to unsigned integral types of the appropriate size. In C++, char16_t and char32_t are fundamental types.

And the header file \<cuchar\> also leaves some functions that support to convert between multibyte sequence and 16-bit, 32-bit character. 

The problem with char16_t and char32_t is that they are not supported, not even in the standard C++ library. For example, there are no streams supporting these types directly and it will works more than just instantiating the stream for these types.

Ex: Code C/C++

```C++
char     ch1{ 'a' };  // or { u8'a' }
wchar_t  ch2{ L'a' };
char16_t ch3{ u'a' };
char32_t ch4{ U'a' };

ypedef basic_string<char> string;
typedef basic_string<char16_t> u16string;
typedef basic_string<char32_t> u32string;
```

<br>

## char type

The ```char``` type is the original type in C/C++. The size of ```char``` data type is 1 byte. With ANSI character set or any of the ISO-8859 character sets, you usually uses the ```char``` type when processing the character type. 

In ```UTF-8``` encoding, the ```char``` type is the most compatible with it.

<br>

## wchar_t type

In C/C++, it supports the ```wchar_t``` type. It is defined as a wide character type. Unfortunately, its size that depends on the compiler. 

The ISO/IEC 10646:2003 Unicode standard 4.0 says that: 

```
"The width of wchar_t is compiler-specific and can be as small as 8 bits. Consequently, programs that need to be portable across any C and C++ compiler should not use wchar_t for storing Unicode text. The wchar_t type is intended for storing compiler-defined wide characters, which may be Unicode characters in some compilers."
```

You can see that if you use Microsoft's compiler on Windows, ```wchar_t``` will be 16-bit type holding ```UTF-16LE``` Unicode. On Linux, ```wchar_t``` will more often be a 32-bit type, holding ```UCS-4``` / ```UTF-32``` encoded Unicode.

There is, however, no guarantee of that. At least in theory an implementation on Linux could use 16 bits, or one on Windows could use 32 bits, or either one could decide to use 64 bits (though I'd be a little surprised to see that in reality).

So, using ```wchar_t``` in the program doesn't make it correctly that completely support Unicode. Eventually, this will make so many troubles when you choose an internal encoding in the program.

To improve it, C++11 provides the better suitable character type - ```char16_t```, but you will still encounter troubles in the way conversion string between many other encodings.

If you're programming with C/C++ on Windows OS, you can confidently use the wchar_t data type to conversion between UTF-16 and UTF-8. 

<br>

## char16_t type

According to the definition of cppreference.com, ```char16_t``` is a type for UTF-16 character representation, required to be large enough to represent any UTF-16 code unit (16-bit). It has the same size, signedness, and alignment as std::uint_least16_t, but is a distinct type.

When searching about UTF-16, I find that UTF-16 encoding has so many wrong points. So, using the char16_t type is something that you need to consider carefully. 

You can refer to the previous article [Encoding in Unicode](2018-11-06-Encoding-Unicode).

<br>

## char32_t type

According to the definition of cppreference.com, char32_t is a type for UTF-32 character representation, required to be large enough to represent any UTF-32 code unit (32 bits). It has the same size, signedness, and alignment as std::uint_least32_t, but is a distinct type. 

<br>

## Wrapping up

- The Unicode standard defines three encoding forms, UTF-8, UTF-16, and UTF-32, for storing Unicode in strings with base types that are 8, 16, or 32 bits wide, respectively. UTF-16 is the preferred form because it is easy to handle, and most characters fit into single 16-bit code units. UTF-32 has the advantage of being a fixed-width encoding form, but it uses a lot more memory. UTF-8 is designed for systems that need byte-based strings; it is the most complicated Unicode encoding form. It uses less memory than UTF-16 for Western European languages, but almost the same amount for Greek, Cyrillic, and Middle-Eastern languages, and more for all East Asian languages.

- Strings of the types char16_t and char32_t, and wchar_t are all referred to as **wide strings** , though the term often refers specifically to strings of wchar_t type.

- Strings of char types are referred to as **narrow string**, even when used to encode multibyte characters.

- Many applications, frameworks and APIs use UTF-16, such as Java's String, C#'s String, Win32 APIs, Qt GUI libraries, the ICU Unicode library, etc.

<br>

Refer: 

[Should you use std::string, std::u16string, or std::u32string?](https://www.ohadsoft.com/2014/11/should-you-use-stdstring-stdu16string-or-stdu32string/)

http://cppwhispers.blogspot.com/2012/11/unicode-and-your-application-1-of-n.html

https://www-user.tu-chemnitz.de/~heha/viewchm.php/hs/petzold.chm/petzoldi/ch02c.htm

[char, wchar_t, char16_t, char32_t](https://docs.microsoft.com/en-us/cpp/cpp/char-wchar-t-char16-t-char32-t?view=vs-2017)

[Wide character](https://en.wikipedia.org/wiki/Wide_character)

[History of C++](https://en.cppreference.com/w/cpp/language/history)

[Fundamental types in C++](https://en.cppreference.com/w/cpp/language/types)

[Null terminated multibyte strings](https://en.cppreference.com/w/cpp/string/multibyte)

[Unicode Character Encoding Model - Unicode Technical Report #17](http://www.unicode.org/reports/tr17/)

[wchar_t string on Linux, OS X and Windows](http://www.firstobject.com/wchar_t-string-on-linux-osx-windows.htm)

[The difference between UTF-8 and Unicode?](http://www.polylab.dk/utf8-vs-unicode.html)

[Programming with wide characters](https://www.linux.com/news/programming-wide-characters)

[How to: Convert Between Various String Types](https://docs.microsoft.com/en-us/cpp/text/how-to-convert-between-various-string-types?view=vs-2017)

[Make char16_t/char32_t string literals be UTF-16/32](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p1041r1.html)