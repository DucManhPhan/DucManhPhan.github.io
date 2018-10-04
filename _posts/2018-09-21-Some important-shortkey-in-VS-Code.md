---
layout: post
title: Some important shortkey in Visual Studio Code
bigimg: /img/path.jpg
tags: [shortkey, Visual studio code]
---

## Open Command Pallete.
  Ctrl + Shift + P

## Clear the content in Terminal.
In order clear screen of terminal in visual studio code with 3 different OS: 
  - In Windows: Ctrl + K.
  - In Mac: Cmd + K.
  - In Linux: 
  
        Use Command Pallete: Ctrl + Shift + P.

        Finally, press "tclear".
       
    Or

        Make the shortkey in keybinding file. 

          ```javascript
            "key": "Ctrl+K",
            "command": "workbench.action.terminal.clear",
            "when": "terminalFocus"
          ```

## Open the Terminal. 
  In Windows: Ctrl + `

## Open the Explorer (or Directory Managment).
  In Windows: Ctrl + Shift + E

## Open the Search Tab. 
  In Windows: Ctrl + Shift + F

## Open the Debug Tab. 
  In Windows: Ctrl + Shift + D

## Open the Extension Tab. 
  In Windows: Ctrl + Shift + X

## Go to the specific line. 
  In Windows: Ctrl + G 

## Go to the next Editor Tab. 
  In Windows: Ctrl + "PageUp"

## Go the the previous Editor Tab.
  In Windows: Ctrl + "PageDown"
  
## Move the line to the above the other line.
  Alt + "Up"

## Move the line to the below the other line. 
  Alt + "Down"

## Copy to the other line up/down.
  Alt + Shift + "Up"/"Down"

## Close Folder
  Ctrl + K F

## Open Folder
  Ctrl + K O