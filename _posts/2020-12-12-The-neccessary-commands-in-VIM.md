---
layout: post
title: The neccessary commands in VIM
bigimg: /img/image-header/yokohama-tonight.jpeg
tags: [vim]
---

VIM is one of the best editor that every developer really like to use. It is cross platform editor and available on most popular platforms like Linux, Mac, Windows, ... 

VIM has so powerful multiple commands, and it helps developers to type keyboard very fast. They do not always have to use the mouse, they only focus on the keyboard. It improve the speed and performance of developers. 

In this article, we will find out the most common commands of VIM, and how to memorize the commands quickly.

<br>

## Table of Contents
- [Structure of Editing command in VIM](#structure-of-editing-command-in-VIM)
- [Plaintext Text Objects](#plaintext-text-objects)
- [Adverbs](#adverbs)
- [Programming Language Text Objects](#programming-language-text-objects)
- [Motion - Commands](#motion-commands)
- [Undo and Redo](#undo-and-redo)
- [Commands in Visual Mode](#commands-in-visual-mode)
- [Commands in Normal Mode](#commands-in-normal-mode)
- [Commands with Insert Mode](#commands-with-insert-mode)
- [Commands with Find operation](#commands-with-find-operation)
- [Commands with file](#commands-with-file)
- [Commands with tab](#commands-with-tab)
- [Some interesting commands](#some-interesting-commands)

<br>

## Structure of Editing command in VIM
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

<br>

## Plaintext Text Objects
VIM supplies the three building blocks of text objects: words, sentences, and paragraphs. 

- w - Words
    - aw: a word (includes surrounding white space)
    - iw: inner word (does not include  surrounding white space)

- s - Sentences
    - as: a sentence
    - is: inner sentence

- p - Paragraphs
    - ap: a paragraph
    - ip: inner paragraph

- b - block/parentheses

- t - tag

<br>

## Adverbs
- i --> inside

- a --> around

- t --> till

- f --> till (inclusive)


<br>

## Programming Language Text Objects
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

<br>

## Motion Commands
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
- 1G: go the the start of file
- 123G : move to the line number 123
- w : move cursor to the beginning of the next word
- e : move cursor to the end of the current word
- b : move cursor to the beginning of the previous word
- Ctrl + o : jump back to the previous position
- Ctrl + i : jump to the next position

<br>

## Undo and Redo
- u : undo last change of action, ex: 3u - undo last 3 actions
- Ctrl + r or :red : redo action 
- U : return the last line which was modified to its original state (reverse all changes in last modified line). U is seldom useful in practice, but it often accidentally pressed instead of u, so it is good to know about.

<br>

## Commands in Visual Mode
- If we want to switch to visual mode in VIM, we will type **v**.

<br> 

## Commands in Normal Mode
- y : yank (copy) text specified by motion (!important)
- yy : yank (copy) the current line
- Y : yank (copy) the current line.
- p : put the yanked content. Notice that yanking will move text to a special VIM reserved buffer, and not to your usual clipboard. We can manage two different clipboards. The first way, we can paste from with **Ctrl + Shift + v** in editing mode. The second way, with **p** (in the normal mode).

- d : delete text specified by motion (!important)
- dd : delete the current line
- c : delete text specified by motion and go to insert mode (!important)
- x : delete character under the cursor
- r : replace character under cursor with another character
- s : delete character under cursor and move to insert mode
- d2w. or d2e. : delete 2 words, and repeat the previous command with **.** character.

<br>

## Commands with Insert Mode
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

<br>

## Commands with Find operation
- Type "/" (without double quotes), and then press our word/pattern that we want to search.

    - After that, just hit the Enter key --> Vim will place the cursor on the first line (containing our word).
    - To move on to the next line that containing the searched word, press **n** character.
    - If we want to go back to the previous words, press **N** (Shift + n).

        --> Type **ggn** to jump to the first match.

        --> Type **GN** to jump to the last match.

        Example: In Normal mode, we type: **/commands**

    - If we are at the bottom of a file, and search backwards, type **?**, then press our searched words.

        Example: **?file**

- Search highlighting

    ```javascript
    :set hlsearch
    ```

- Search case insensitive

    The search in VIM is in case insensitive by default.

    ```javascript
    :set ignorecase
    ```
- ```*``` : find the next occurence of the current word.

- fx : go to the next occurrence of 'x' on the current line

- Fx : find the previous 'x' in the current line

- tC : jump till just before the next 'C' in the line

- TC : jump till just after the previous the 'C' in the same line

- Find and replace

    ```javascript
    // Find and replace normal case
    :%s/find_text/replace_text/g

    // Find and replace with confirmation
    :%s/find_text/replace_text/gc

    // Find and replace whole word only
    :%s/\<find_text\>/replace_text/gc

    // Case insensitive find and replace
    :%s/find_text/replace_text/gi

    // Case sensitive find and replace
    :%s/find_text/replace_text/gI

    // Find and replace in the current line only
    :s/find_text/replace_text/g

    // Replace all lines between start-th line and end-th line
    :{START-n},{END-n}s/find_text/replace_text/g
    ```

<br>

## Commands with file
- Save and close the current file

    ```javascript
    :wq
    ```

- Discard all changes in the current file

    ```javascript
    :q!
    ```

Below is commands about working with file in VIM editor.

|         Command          |            Description            |
|------------------------- | --------------------------------- |
| q                        | Quit                              |
| q!                       | Quit without saving changes       |
| r fileName               | Read data from file called fileName |
| w                        | Save file and continue editing    |
| wq                       | Write and quit                    |
| x                        | Same as wq command |
| w fileName               | Write to file called fileName (save as) |
| w! fileName              | Overwrite to file called fileName (save as forcefully) |


<br>

## Commands with tab




<br>

## Some interesting commands
- ciw : change the inside word - delete the whole word under cursor and switches to insert mode, unlike cw which deletes a word from cursor to the end of this word.
- cis : change inside sentence
- ci" : change inside " brace - delete all text between " braces.
- da} : delete around } brace - deletes all text inside curly braces including them.
- vip : visual inside paragraph - selects all paragraph.
- ctp : change till p - delete everything from here to letter p.
- d$ : delete to the end of line
- yG : copy everything through the end of the file
- cf) : change through the next closing parentheses or the next other character
- cw : delete word and enter the insert mode
- dw : delete word and staying in the normal mode
- cfx : change all text till the 'x' (includes the 'x') 
- ctx : change all text tille the 'x'
- dtx : delete all text till the next 'x'
- dfx : same, but include the 'x'
- Yp : duplicate lines 
- 3dk : delete current line and 4 lines in the upward direction.
- :-3,.d : delete 3 lines above and the current line.
- 2iHello <ESC> : insert Hello 2 times.

<br>

## Wrapping up



<br>

Refer: 

[Vim Text Objects: The Definitive Guide](https://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/)

[Wikipedia about VIM](http://vim.wikia.com/wiki/Tutorial)