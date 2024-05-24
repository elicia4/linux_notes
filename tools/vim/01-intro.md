# 01. Introduction

[***Table of Contents***](./ToC.md)

These are notes on [the series of vim guides by Mental
Outlaw](https://youtube.com/playlist?list=PL3cu45aM3C2DJVGfCjSBB1yD9YkC7q27-)
and many other sources.

These notes also include my own additions, as well as those suggested in the
comment sections of the videos.

## Why use `vim`?

Most common editor, most available editor.  
Most powerful editor.  
Dates back to 1976, `vim` is here to stay.  

`vim` is a modal text editor, by default it opens in the normal mode.

- Normal mode - navigating through the document  
- Insert mode - editing text  
- Visual mode - copying/deleting text

- `i` - enter insert mode before the current symbol  
- `I` - enter insert mode at the beginning of the line  
- `o` - enter insert mode on the line below current line  
- `O` - enter insert mode on the line above current line  
- `a` - enter insert mode after the current symbol  
- `A` - enter insert mode at the end of the line  
- `C` - delete from cursor to the end of the line and enter insert  

- `Esc` - enter normal mode  
- `Ctrl + [` - enter normal mode, lets you stay on home row  

Moving around:

```
    k
    ^
h <   > l
    v
    j
```

You can also pass arguments to movement commands, for example `5j` will move
cursor down 5 lines.

WORDS = combinations of all symbols except for the whitespace,  
words = combinations of all symbols except for the whitespace and the
punctuation symbols

`w` - forward to the beginning of the next word  
`W` - forward to the beginning of the next WORD  
`b` - backward to the beginning of the next word  
`B` - backward to the beginning of the next WORD  
`e` - forward to the end of the next word  
`E` - forward to the end of the next WORD  
`0` - beginning of the current line
`^` or `_` - first non-whitespace character of the current line
`$` - the end of the current line
`Ctrl-f` - down one page
`Ctrl-b` - up one page

You can repeat the command by entering the number of times you'd like a command
to be repeated:

```
[n]<command>
```

### Most Important Tip

...by Bram Moolenaar with some personal additions

Using `vim` is a skill. Every 5 minutes think about all of the repetitive stuff
you did and figure out how you can improve on it. It is a skill than can always
be improved upon. *Record yourself editing files, it's just as efficient as it
is in video games.*

1. Detect inefficiency
   - Find out what you waste time on
1. Find a quicker way
   - read the online help
   - read the quick reference, books, etc.
   - ask friends and colleagues. Formulate your questions *properly* (not
   *perfectly*)
   - search the internet
   - do it yourself
1. Make it a habit
   - do it
   - keep on improving

How **not** to edit effectively:

- You have to get the text ready right now. No time to read documentation or
learn a new command. *You will keep on using primitive commands.*
- You want to learn every feature the editor offers and use the most efficient
command all the time. *You will waste a lot of time learning things you will
never use.*

Make everything *a habit*. Make sure that every useful little thing you learn
you implement into your workflow. Otherwise you will just forget it. *Don't try
to learn everything.*

[***Go to Next Note***](02-searching.md)
