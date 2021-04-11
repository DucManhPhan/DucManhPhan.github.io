---
layout: post
title: The neccessary commands in VIM
bigimg: /img/image-header/yokohama-tonight.jpeg
tags: [Vim]
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

    For example:
    - yiw - yank the current word (excluding surrounding whitespace).

- a --> around

    For example:
    - yaw - yank the current word (including the leading or trailing whitespace).

- t --> till

    For example:
    - ytx - yank the current cursor position up to and before the character (till x).

- f --> till (inclusive)

    For example:
    - yfx - yank the current cursor position up to and including the character (find x).

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

1. Some modes in Visual mode

    There are three visual mode in VIM.
    - v - character-wise visual mode

        It is used to select the individual characters or words.

    - V - line-wise visual mode

        It is used to select lines.

    - Ctrl + v - block wise visual mode

        It helps us select columns or rows in editor.

    To switch between multiple visual modes, pressing v, or V, or Ctrl + v.

    To exist our current visual mode, typing the below keys:
    - ESC
    - Ctrl + c
    - Use the same key that we use to enter the visual mode.

2. Some operators in Visual mode

    - u --> convert to lower case
    - U --> convert to upper case
    - d --> delete
    - c --> change
    - y --> yank
    - **>** --> indent
    - **<** --> dedent

3. Some useful commands in Visual mode

    - Replace multiple lines

        For example:

        ```
        int a = 2;
        int b = 3;
        ```

        Now, we want to change **int** to **float**. First, we will use line-wise visual mode with V character. Then, use replace and find command to substitute **int** with **float** word.

        ```bash
        # change the current lines
        :s/int/float/g
        ```

    - Change texts in the multiple rows with same column

        Assuming that we want to change the name of a and b in the above text to **inta**, **intb**.

        - First, jump the pointer to the position of a character.

        - Then, use block-wise in visual mode with Ctrl+v.

        - Next, use j character to go down the below line of **b** variable.
        
        - Use Shitf + I to enter the Insert mode.

        - Finally, typing ESC key to insert the remained lines that we choose.

    - Insert ; to the end of line.

        Supposed that we have:

        ```
        int a = 2
        int b = 3
        ```

        We can easily find that we need to fill the ; character to the last lines.

        Belows are some steps to aim that.
        - Go to the first line with i character --> O.
        - Choose block-wise visual mode

            Ctrl + v

        - Go down two lines with --> jj.
        - Select from start to end of lines with --> $.
        - Append character --> A
        - Typing --> ;
        - Exit visual mode with --> ESC.

    - To increment number or characters in alphabet table

        + First, we will select block-wise visual mode.
        + Then, Typing g Ctrl+a

<br> 

## Commands in Normal Mode
- y : yank (copy) text specified by motion (!important)

    For example, if we want to copy from the current position to the end of line, then we have:
    - The normal mode command to move to the end of line is $. So we can copy to the end of the line with **y$** and paste with **p**.
    - To copy/paste between different instances, we can use the system clipboard by selecting the * register, so the commands become ```*y$``` for copying and ```*p``` for pasting.

- yy : yank (copy) the current line
- y} : yank text from the cursor to the next paragraph 
- Y : yank (copy) the current line.
- p : put the yanked content after the cursor.

    Notice that yanking will move text to a special VIM reserved buffer, and not to your usual clipboard. We can manage two different clipboards. The first way, we can paste from with **Ctrl + Shift + v** in editing mode. The second way, with **p** (in the normal mode).

    For example, if we want to duplicate multiple line, then we will combine to the Y character with this p. So, we have: **Yp**.

    gp and gP - paste content and move the cursor after that content. 
     
- P: put the copied content before the cursor.

- d : delete text specified by motion (!important)

    For example, d{motion} with motion can be: j, k, $, 0.
    - dj - delete from the current line to the below line.
    - dk - delete from the current line to the above line.
    - d$ - delete from the current cursor to the end of line.
    - d0 - delete from the current cursor the the begin of line.

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

1. Create/Close new tabs

    |        Command        |              Description              |
    | --------------------- | ------------------------------------- |
    | :tabedit file-name    | Open a file in a new tab              |
    | :tabclose             | Close the current tab                 |
    | :wqa                  | Close all tabs                        |
    | :tabonly or :tabo     | Close the other tabs, but still open the current tab |

2. Switch between tabs

    |        Command        |              Description              |
    | --------------------- | ------------------------------------- |
    | gt                    | Move to the next tab                  |
    | gT                    | Move to the previous tab              |
    | ngt                   | Move to the specific tab              |
    | :tabmove              | Move to the end tab                   |

<br>

## Some interesting commands
- ciw : change the inside word - delete the whole word under cursor and switches to insert mode, unlike cw which deletes a word from cursor to the end of this word.
- cis : change inside sentence
- ci" : change inside " brace - delete all text between " braces.
- da} : delete around } brace - deletes all text inside curly braces including them.
- vip : visual inside paragraph - selects all paragraph.
- ctp : change till p - delete everything from here to letter p.
- d$ : delete to the end of line
- yg : copy everything through the end of the file
- cf) : change through the next closing parentheses or the next other character
- cw : delete word and enter the insert mode
- dw : delete word and staying in the normal mode
- cfx : change all text till the 'x' (includes the 'x') 
- ctx : change all text till the 'x'
- dtx : delete all text till the next 'x'
- dfx : same, but include the 'x'
- yp : duplicate lines 
- 3dk : delete current line and 4 lines in the upward direction.
- :-3,.d : delete 3 lines above and the current line.
- 2ihello <esc> : insert hello 2 times.
- \>% - indent text between a pair of parenthes ([{}])

<br>

## wrapping up

- Understanding about the action and objects in VIM.

- Practice all commands makes us better to code.


<br>

Refer: 

[Vim Text Objects: The Definitive Guide](https://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/)

[Wikipedia about VIM](http://vim.wikia.com/wiki/Tutorial)

[https://whileimautomaton.net/2008/11/vimm3/operator](https://whileimautomaton.net/2008/11/vimm3/operator)

[https://learnvimscriptthehardway.stevelosh.com/](https://learnvimscriptthehardway.stevelosh.com/)