---
layout: post
title: Understanding about QString in Qt
bigimg: /img/image-header/california.jpg
tags: [Qt]
---


<br>

## Table of contents
- [Introduction to QString](#introduction-to-qstring)
- [Encoding in Qt](#encoding-to-qt)
- [Some must-known methods in QString](#some-must-known-methods-in-qstring)
- [Convert between UTF-16 and UTF-8](#convert-between-utf-16-and-utf-8)
- [Display Japanese in QTextBox](#display-japanese-in-qtextbox)


<br>

## Introduction to QString 





<br>

## Encoding in Qt
Encoding standards specify how strings are represented in memory. 

- Controls in Qt

    All controls in Qt are enabled for 16-bit characters. That means that content of a ```QTextEdit``` is ```Unicode``` (or ```UTF-32``` / ```UCS-4```).

    When getting the content of a ```QTextEdit``` control (via ```plainText()```), you get back a ```QString``` which contains Unicode.

    From there on, you can convert to other format as you like: ```toUTF8()```, ```toUCS4()```, ...

- Some supported encoding in ```QTextCodec```

    When we want to know about how many encoding that is supported in ```QTextCodec```, then, we will use ```QTextCodec::availableCodecs();``` to get the output:

    ```bat
    ("UTF-8", "ISO-8859-1", "latin1", "CP819", "IBM819", "iso-ir-100", "csISOLatin1", "ISO-8859-15", "latin9", "UTF-32LE", "UTF-32BE", "UTF-32", "UTF-16LE", "UTF-16BE", "UTF-16", "System", "roman8", "hp-roman8", "csHPRoman8", "TIS-620", "ISO 8859-11", "WINSAMI2", "WS2", "Apple Roman", "macintosh", "MacRoman", "windows-1258", "CP1258", "windows-1257", "CP1257", "windows-1256", "CP1256", "windows-1255", "CP1255", "windows-1254", "CP1254", "windows-1253", "CP1253", "windows-1252", "CP1252", "windows-1251", "CP1251", "windows-1250", "CP1250", "IBM866", "CP866", "csIBM866", "IBM874", "CP874", "IBM850", "CP850", "csPC850Multilingual", "ISO-8859-16", "iso-ir-226", "latin10", "ISO-8859-14", "iso-ir-199", "latin8", "iso-celtic", "ISO-8859-13", "ISO-8859-10", "iso-ir-157", "latin6", "ISO-8859-10:1992", "csISOLatin6", "ISO-8859-9", "iso-ir-148", "latin5", "csISOLatin5", "ISO-8859-8", "ISO 8859-8-I", "iso-ir-138", "hebrew", "csISOLatinHebrew", "ISO-8859-7", "ECMA-118", "greek", "iso-ir-126", "csISOLatinGreek", "ISO-8859-6", "ISO-8859-6-I", "ECMA-114", "ASMO-708", "arabic", "iso-ir-127", "csISOLatinArabic", "ISO-8859-5", "cyrillic", "iso-ir-144", "csISOLatinCyrillic", "ISO-8859-4", "latin4", "iso-ir-110", "csISOLatin4", "ISO-8859-3", "latin3", "iso-ir-109", "csISOLatin3", "ISO-8859-2", "latin2", "iso-ir-101", "csISOLatin2", "KOI8-U", "KOI8-RU", "KOI8-R", "csKOI8R", "Iscii-Mlm", "Iscii-Knd", "Iscii-Tlg", "Iscii-Tml", "Iscii-Ori", "Iscii-Gjr", "Iscii-Pnj", "Iscii-Bng", "Iscii-Dev", "TSCII", "GB18030", "GBK", "GB2312", "CP936", "MS936", "windows-936", "EUC-JP", "ISO-2022-JP", "Shift_JIS", "JIS7", "SJIS", "MS_Kanji", "EUC-KR", "cp949", "Big5", "Big5-HKSCS", "Big5-ETen", "CP950")
    ```

<br>

## Some must-known methods in QString





<br>

## Convert between UTF-16 and UTF-8




<br>

## Advantage of QString over std::string 
When programming Qt, I'm really surprised at ```QString``` simply because it has so many traits to improve performance of system. In this part, we will find something out about advantages of ```QString``` that is compared to ```std::string```.

In ```QString```, we have:
- ```QString``` uses ```implicit-sharing``` / ```copy-on-write``` mechanisms.
- ```QString``` allows us to work with ```Unicode```, has more useful methods and integrates with Qt well.

In ```std::string```, we have:
- ```std::string``` just stores the bytes as we give them to it, it doesn't know anything about encodings. It uses one byte per character, but it's not enough for all the languages in the world. The best way to store our texts would probably be ```UTF-8``` encoding, in which characters can take up different number of bytes, and ```std::string``` just can't handle that property.

    For example, the ```length()``` method of ```std::string``` would return the number of bytes, not characters.

- Technically, there is a standard string class to store any type of character - std::basic_string. std::string and std::wstring are nothing but specializations of std::basic_string for char and wchar. There are also the specilizations std::u16string and std::u32string that are meant for UTF-16 and UTF-32 storage.

    Anyway, if you have to work with Qt, QString will probably always be a better alternative than any standard library string since the whole Qt framework is designed to work with it.


In the other article, we will discuss about ```implicit sharing``` mechanism in Qt.

<br>

## Display Japanese in QTextBox
- Problem's context

    We have a problem about reading file that is encoding in ```UTF-8```. In Qt, we utilize ```QSetting``` class to read this ```.INI``` file. Then, we will display all information to a ```QTextBox``` in ```QWidget```.

    Normally, we will use the below segment code to read .INI file.

    ```C++
    QSettings* settings         = new QSettings(path, QSettings::IniFormat);

    this->NameUser              = settings->value("NameUser").toString();
    ...

    ui->txtNameUser->setText(NameUser);
    ```

    This is not working. We always have ? awkard characters in textbox.

- Solution

    The first thing we have to notice is that our .INI file is encoding in UTF-8. So how do QSetting class read about it? and what encoding is QSetting using? 

    When I'm digging into problem, I have a surprised result:

    ```
    Sets the codec for accessing INI files (including .conf files on Unix) to codec. The codec is used by decoding any data that is read from the INI file, and for encoding any data that is written to the file. By default, no codec is used, and non-ASCII characters are encoded using standard INI escape sequences.
    ```

    We can see that ```By default, no codec is used, and non-ASCII characters are encoded using standard INI escape sequences```. 

    So, we have to set codec for instance of QSettings class. Therefore, we have solution looks like this:

    ```C++
    QSettings* settings         = new QSettings(path, QSettings::IniFormat);
    settings->setIniCodec("UTF-8");

    this->NameUser              = settings->value("NameUser").toString();
    ...

    ui->txtNameUser->setText(NameUser);
    ```

<br>

## Wrapping up
- After creating instance of QSettings class, we must call ```setIniCodec()``` method immediately and before accessing any data.



<br>

Thanks for your reading.

<br>

Refer:

[https://stackoverflow.com/questions/4853134/what-is-qstringtoutf8-doing](https://stackoverflow.com/questions/4853134/what-is-qstringtoutf8-doing)

[https://lost-contact.mit.edu/afs/rhic.bnl.gov/i386_redhat72/opt/star/rh80_gcc32/qt-x11-free-3.3.1/doc/html/i18n.html](https://lost-contact.mit.edu/afs/rhic.bnl.gov/i386_redhat72/opt/star/rh80_gcc32/qt-x11-free-3.3.1/doc/html/i18n.html)

[http://www.informit.com/articles/article.aspx?p=1405555](http://www.informit.com/articles/article.aspx?p=1405555)

[http://d.hatena.ne.jp/QtCoder/20111017/1319037498](http://d.hatena.ne.jp/QtCoder/20111017/1319037498)

[https://wiki.qt.io/Strings_and_encodings_in_Qt](https://wiki.qt.io/Strings_and_encodings_in_Qt)

[https://doc.qt.io/qt-5/unicode.html](https://doc.qt.io/qt-5/unicode.html)

[https://wiki.qt.io/QString](https://wiki.qt.io/QString)

[https://stackoverflow.com/questions/8047321/qsettings-doesnt-handle-unicode-well](https://stackoverflow.com/questions/8047321/qsettings-doesnt-handle-unicode-well)

[https://www.qtcentre.org/threads/38855-unicode-character-displays-ok-on-Windows-not-on-Linux](https://www.qtcentre.org/threads/38855-unicode-character-displays-ok-on-Windows-not-on-Linux)

[https://stackoverflow.com/questions/37548520/qt-convertion-of-a-qstring-from-utf16-to-utf8](https://stackoverflow.com/questions/37548520/qt-convertion-of-a-qstring-from-utf16-to-utf8)

[https://stackoverflow.com/questions/11028948/advantage-of-qstring-over-stdstring](https://stackoverflow.com/questions/11028948/advantage-of-qstring-over-stdstring)