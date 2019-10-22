---
layout: page
sidebar: right
subheadline: Tips-Code
title: "Vim notes"
excerpt: ""
teaser: "Notes mostly from the web-forums about vim configurations.    "
breadcrumb: true
tags: [vim]
categories:
    - computing-blog
header:
    title: Vim notes
    pattern: pattern_jquery-dark-grey-tile.png
---


## Vim copy-paste

### From askubuntu web:

1.    If you want to **copy paste contents within the same file**, use yank and paste.

2.    If you want to **copy paste contents across terminals**, open the first file, 
      yanking the text you want, then open your second file within vim 
      (e.g. :tabnew /path/to/second/file) and press p to paste it.

3.    If you want to** copy paste contents from vim to an external program**, you need 
      to access the system clipboard. The GUI version of vim always has clipboard 
      support, however, if you like to use Vim from a terminal, you will have to 
      check for X11-clipboard support.

      From the console, type:
       ```
       $ vim --version | grep xterm
       ```
       
      If you find -xterm_clipboard, you have two options:

       a. Compile vim yourself, with the xterm_clipboard flag on

       b. Uninstall vim, install gvim (vim-gtk or vim-gnome) instead. You can stick to 
          non-gui vim by calling vim from the terminal, the same way you did before. This 
          time when you check you should find +xterm_clipborad.

       Now, when you yank some text in the + register inside your vim editor (e.g. "+yy), 
       it also gets copied to the system clipboard which you can retrieve from your 
       external program like gedit editor, by using Ctrl+V.

4.  If you want to **copy paste contents from an external program into vim**, first copy 
    your text into system clipboard via Ctrl+C, then in vim editor insert mode, click 
    the mouse middle button (usually the wheel) or press Ctrl+Shift+V to paste.

    These are 4 basic copy & paste conditions related to vim. I hope this helps.

