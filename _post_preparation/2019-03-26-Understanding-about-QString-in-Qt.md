---
layout: post
title: Understanding about QString in Qt
bigimg: /img/image-header/california.jpg
tags: [Qt]
---


<br>

## Table of contents



<br>

## Introduction to QString 





<br>

## Encoding in Qt
Encoding standards specify how strings are represented in memory. 




When we want to know about how many encoding that is supported in ```QTextCodec```, then, we will use ```QTextCodec::availableCodecs();``` to get the output:

```bat
("UTF-8", "ISO-8859-1", "latin1", "CP819", "IBM819", "iso-ir-100", "csISOLatin1", "ISO-8859-15", "latin9", "UTF-32LE", "UTF-32BE", "UTF-32", "UTF-16LE", "UTF-16BE", "UTF-16", "System", "roman8", "hp-roman8", "csHPRoman8", "TIS-620", "ISO 8859-11", "WINSAMI2", "WS2", "Apple Roman", "macintosh", "MacRoman", "windows-1258", "CP1258", "windows-1257", "CP1257", "windows-1256", "CP1256", "windows-1255", "CP1255", "windows-1254", "CP1254", "windows-1253", "CP1253", "windows-1252", "CP1252", "windows-1251", "CP1251", "windows-1250", "CP1250", "IBM866", "CP866", "csIBM866", "IBM874", "CP874", "IBM850", "CP850", "csPC850Multilingual", "ISO-8859-16", "iso-ir-226", "latin10", "ISO-8859-14", "iso-ir-199", "latin8", "iso-celtic", "ISO-8859-13", "ISO-8859-10", "iso-ir-157", "latin6", "ISO-8859-10:1992", "csISOLatin6", "ISO-8859-9", "iso-ir-148", "latin5", "csISOLatin5", "ISO-8859-8", "ISO 8859-8-I", "iso-ir-138", "hebrew", "csISOLatinHebrew", "ISO-8859-7", "ECMA-118", "greek", "iso-ir-126", "csISOLatinGreek", "ISO-8859-6", "ISO-8859-6-I", "ECMA-114", "ASMO-708", "arabic", "iso-ir-127", "csISOLatinArabic", "ISO-8859-5", "cyrillic", "iso-ir-144", "csISOLatinCyrillic", "ISO-8859-4", "latin4", "iso-ir-110", "csISOLatin4", "ISO-8859-3", "latin3", "iso-ir-109", "csISOLatin3", "ISO-8859-2", "latin2", "iso-ir-101", "csISOLatin2", "KOI8-U", "KOI8-RU", "KOI8-R", "csKOI8R", "Iscii-Mlm", "Iscii-Knd", "Iscii-Tlg", "Iscii-Tml", "Iscii-Ori", "Iscii-Gjr", "Iscii-Pnj", "Iscii-Bng", "Iscii-Dev", "TSCII", "GB18030", "GBK", "GB2312", "CP936", "MS936", "windows-936", "EUC-JP", "ISO-2022-JP", "Shift_JIS", "JIS7", "SJIS", "MS_Kanji", "EUC-KR", "cp949", "Big5", "Big5-HKSCS", "Big5-ETen", "CP950")
```

<br>

## Convert between QString and UTF-8




<br>



Refer:

[https://lost-contact.mit.edu/afs/rhic.bnl.gov/i386_redhat72/opt/star/rh80_gcc32/qt-x11-free-3.3.1/doc/html/i18n.html](https://lost-contact.mit.edu/afs/rhic.bnl.gov/i386_redhat72/opt/star/rh80_gcc32/qt-x11-free-3.3.1/doc/html/i18n.html)

[http://www.informit.com/articles/article.aspx?p=1405555](http://www.informit.com/articles/article.aspx?p=1405555)

[http://d.hatena.ne.jp/QtCoder/20111017/1319037498](http://d.hatena.ne.jp/QtCoder/20111017/1319037498)

[https://wiki.qt.io/Strings_and_encodings_in_Qt](https://wiki.qt.io/Strings_and_encodings_in_Qt)

[https://doc.qt.io/qt-5/unicode.html](https://doc.qt.io/qt-5/unicode.html)

[https://wiki.qt.io/QString](https://wiki.qt.io/QString)