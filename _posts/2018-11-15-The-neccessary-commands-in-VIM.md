---
layout: post
title: The neccessary commands in VIM
bigimg: /img/path.jpg
tags: [vim]
---

VIM is one of the best editor that every developer really like to use. It is cross platform editor and available on most popular platforms like Linux, Mac, Windows, ... 

VIM has so powerful multiple commands, and it helps developers to type keyboard very fast. They do not always have to use the mouse, they only focus on the keyboard. It improve the speed and performance of developers. 

In this article, we will find out the most common commands of VIM, and how to memorize the commands quickly.


## Table of Contents
- [Structure of Editing command in VIM](#structure-of-editing-command-in-VIM)
- [Plaintext Text Objects](#plaintext-text-objects)
- [Programming Language Text Objects](#programming-language-text-objects)
- [Motion - Commands](#motion-commands)
- [Undo and Redo](#undo-and-redo)
- [Commands in Visual Mode](#commands-in-visual-mode)
- [Commands in Normal Mode](#commands-in-normal-mode)
- [Commands with Insert Mode](#commands-with-insert-mode)
- [Commands with Find operation](commands-with-find-operation)
- [Commands with file](#commands-with-file)
- [Commands with tab](#commands-with-tab)
- [Some interesting commands](#some-interesting-commands)


# Structure of Editing command in VIM
When we know the structure of commands, means we can use so many commands. We do not remember the detail of each command. 

```
<number><command><text object or motion>
```

- **number**: used to perform the command over multiple text objects or motions. 

Ex: backward three words, forward two paragraphs.

The **number** is optional and can appear either before or after the command. 

- **command**: an operation. 

Ex: change, delete (cut), or yank (copy). 

The **command** is optional, but without it, you only have a motion command, not and edit command. 

- **text object** or **motion**: can either be a text construct, Ex: a word, a sentence, a paragraph, ... or a motion, Ex: forward a line, back one page, end of the line. 


# Plaintext Text Objects
VIM supplies the three building blocks of text objects: words, sentences, and paragraphs. 

- Words
    - aw: a word (includes surrounding white space)
    - iw: inner word (does not include  surrounding white space)

- Sentences
    - as: a sentence
    - is: inner sentence

- Paragraphs
    - ap: a paragraph
    - ip: inner paragraph


# Programming Language Text Objects
VIM also provides some text objects based on common programming language constructs. 

- Strings
    - a": a double quote string
    - i": inner double quoted string
    - a': a single quoted string
    - i': inner single quoted string
    - a`: a back quoted string
    - i`: inner back quoted string

- Parentheses
    - a): a parentheses block
    - i): inner parentheses block

- Brackets
    - a]: a bracketed block 
    - i]: inner bracketed block

- Braces
    - a}: a brace block
    - i}: inner brace block

- Markup Language Tags
    - at: a tag block
    - it: inner tag block 

Or something will not happen. So we can try to use the other way: 
    - a>: a single tag
    - i>: inner single tag

- Indent Object
    - ai: the current indentation level and the line above
    - ii: the current indentation level excluding the line above

# Motion Commands
In order to push the usage of VIM, we should learn something about command in movement with cursor. 
- h : move cursor to left by one position, ex: 10h - move to left by 10 character.
- l : move cursor to right by one position
- k : move cursor to upward direction by one line, ex: 10k - move 10 line upward from current line.
- j : move cursor to downward direction by one line
- 0 : move cursor to the beginning of current line
- $ : move cursor to the end of current line
- Ctrl + f : scroll down entire page
- Ctrl + b : scroll up entire page
- :n : jump to the nth line
- :0 : jump to the start of file
- :$ : jump to the end of file
- gg : move to the first line
- G : go to the end of file
- 123G : move to the line number 123
- w : move cursor to the beginning of the next word
- e : move cursor to the end of the current word
- b : move cursor to the beginning of the previous word
- Ctrl + o : jump back to the previous position
- Ctrl + i : jump to the next position


# Undo and Redo
- u : undo last change of action, ex: 3u - undo last 3 actions
- Ctrl + r or :red : redo action 
- U : return the last line which was modified to its original state (reverse all changes in last modified line). U is seldom useful in practice, but it often accidentally pressed instead of u, so it is good to know about.


# Commands in Visual Mode


# Commands in Normal Mode
- d : delete text specified by motion (!important)
- c : delete text specified by motion and go to insert mode (!important)
- y : yank (copy) text specified by motion (!important)
  
- x : delete character under the cursor
- r : replace character under cursor with another character
- s : delete character under cursor and move to insert mode
- yy : yank (copy) the current line
- dd : delete the current line
- fx : go to the next occurrence of 'x' on the current line
- Fx : find the previous 'x' in the current line
- tC : jump till just before the next 'C' in the line
- TC : jump till just after the previous the 'C' in the same line


# Commands with Insert Mode
- i : insert at the current location
- a : insert after the current location (append)
- I : insert at the start of the current line
- A : insert after the end of the current line
- o : insert line below the current line
- O : insert line above the current line
- s : delete character under cursor and start inserting in its place (substitute text) 
- S : delete all text on line and start inserting in its place (substitute line) 
- cw : delete to the end of current word and start inserting in its place (any movement command can be substituted for w) 
- cc : same as S (change line) 
- C : delete from the cursor to the end of line and start inserting at the cursor position 


# Commands with Find operation



# Commands with file



# Commands with tab


# Some interesting commands
- ciw : change the inner word
- d$ : delete to the end of line
- yG : copy everything through the end of the file
- cf) : change through the next closing parentheses or the next other character
- cw : delete word and enter the insert mode
- dw : delete word and staying in the normal mode
- cfx : change all text till the 'x' (includes the 'x') 
- ctx : change all text tille the 'x'
- dtx : delete all text till the next 'x'
- dfx : same, but include the 'x'




Refer: 

[Vim Text Objects: The Definitive Guide](https://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/)

[Wikipedia about VIM](http://vim.wikia.com/wiki/Tutorial)