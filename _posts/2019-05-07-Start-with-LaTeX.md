---
layout: post
title: Start with LaTeX
bigimg: /img/image-header/california.jpg
tags: [LaTeX]
---

In this article, we will find something out about the beginning of the LaTeX structure.

<br>

## Table of contents
- [The structure of LaTeX](#the-structure-of-latex)
- [Commands to split document into smaller parts](#commands-to-split-document-into-smaller-parts)


<br>

## The structure of LaTeX
Every LaTeX files contains the following common commands:

```sql
\documentclass[10pt, a4paper]{article}
\usepackage[utf8]{vietnam}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{graphicx}
\usepackage[left=3.00cm, right=2.00cm, top=2.00cm, bottom=2.00cm]{geometry}
\usepackage{url}
\usepackage[colorlinks, urlcolor=black]{hyperref}
 
\begin{document}
\title{How to use LaTeX} 
\author{ManhPD}
\date{2019-05-04}       % Instead, using \date will get today's date by default.
\maketitle              % Finish top matter with the \maketitle command.

\begin{abstract}
...
\end{abstract}

% Use \renewcommand{\abstractname}{Our title} will change the word Abstract as a title for its abstract.

\end{document}
```

The space between ```\documentclass{...}``` and ```\begin{document}``` is called the preamble. It will affect the entire document.

All the content of our LaTeX files will be written between ```\begin{document}``` and ```\end{document}```.

In layour standard, we will setup in ```\documentclass[options]{class}``` with values of ```class``` and ```options```.

- Some fields of ```class``` property.

    |   Values      |                         Description               |
    | ------------- | ------------------------------------------------- |
    |    article    | For articles in scientific journals, presentations, short reports, program documentation, invitations, ... |
    |    IEEEtran   | For articles with the IEEE Transactions format. |
    |    proc       | A class for proceedings based on the article class. |
    |    report     | For longer reports containing several chapters, small books, thesis, ... |
    |    book       | For real books. |
    |    slides     | For slides. The class uses big sans serif letters. |
    |    memoir     | For changing sensibly the output of the document. It is based on the book class, but we can create any kind of document with it. |
    |    letter     | For writing letters. |
    |    beamer     | For writing presentations. |

- Some fields of ```options``` property.

    |    Values    |                    Description                      |
    | ------------ | --------------------------------------------------- |
    | 10pt, 11pt, 12pt, ... | Sets the size of the main font in the document. If no option is specified, 10pt is assumed. |
    | a4paper, letterpaper, ... | Defines the paper size. The default size is letterpaper; However, many European distributions of TeX now come pre-set for A4, not Letter, and this is also true of all distributions of pdfLaTeX. Besides that, a5paper, b5paper, executivepaper, and legalpaper can be specified. |
    | fleqn       | Typesets displayed formulas left-aligned instead of centered. |
    | leqno       | Places the numbering of formulas on the left hand side instead of the right. |
    | titlepage, notitlepage | Specifies whether a new page should be started after the document title or not. The article class does not start a new page by default, while report and book do. |
    | twocolumn | Instructs LaTeX to typeset the document in two columns instead of one. |
    | twoside, oneside | Specifies whether double or single sided output should be generated. The classes article and report are single sided and the book class is double sided by default. Note that this option concerns the style of the document only. The option twoside does not tell the printer you use that it should actually make a two-sided printout. |
    | landscape   |	Changes the layout of the document to print in landscape mode. |
    | openright, openany | Makes chapters begin either only on right hand pages or on the next page available. This does not work with the article class, as it does not know about chapters. The report class by default starts chapters on the next page available and the book class starts them on right hand pages. |
    | draft   | makes LaTeX indicate hyphenation and justification problems with a small square in the right-hand margin of the problem line so they can be located quickly by a human. It also suppresses the inclusion of images and shows only a frame where they would normally occur. |

In order to easily use LaTeX, we will use some packages with different effection. The syntax of package is ```\usepackage[option]{package}```.

<br>

## Commands to split document into smaller parts

Some commands that will be used to separate our document or report into subparts.
- ```\chapter{Introduction}```
- ```\section{Structure}```
- ```\subsection{Top Matter}```
- ```\subsubsection{Article Information}```

LaTeX provides 7 levels for defining sections:

|     Command   | Level |        Comment        |
| ------------- | ----- | --------------------- |
| ```\part{"Part"}``` | -1 | not in letters  |
| ```\chapter{"chapter"}``` |	0  | only books and reports |
| ```\section{"section"}``` |	1  | not in letters |
| ```\subsection{"subsection"}``` | 2 | not in letters |
| ```\subsubsection{"subsubsection"}``` |	3 | not in letters |
| ```\paragraph{"paragraph"}``` | 4 | not in letters |
| ```\subparagraph{"subparagraph"}``` | 5  | not in letters |

```\setcounter{secnumdepth}{3}``` changes the depth to which section numbering occurs. It means that we only want parts, chapters and sections numbered.

```\setcounter{tocdepth}{3}``` specifies what depth to take the Table of Contents.

To get an unnumbered section which does not go into the Table of Contents, follow the command name with an asterisk before the opening curly before:

```\subsection*{Introduction}```

When we want to unnumber section to be in the table of contents, use package ```unnumberedtotoc```. It has the command ```\addsec{Introduction}```.

<br>

Refer:

[https://en.wikibooks.org/wiki/LaTeX/Document_Structure](https://en.wikibooks.org/wiki/LaTeX/Document_Structure)