# Introduction

[***Table of Contents***](./ToC.md)

There are:
- vim motions, these make you extremely efficient
- vim the program, highly configurable

To begin with, use the vim mode in whatever IDE you're already using.

Vim is a modal editor, you can be in various modes:
- Normal, you can move in it
- Insert, you can type in it
- Visual, kind of like selecting with your cursor
- Command, accessed by pressing colon (`:`):
    - `:w` - save the current file
    - `:q` - quit

### Normal Mode

The most fundamental movements are:
- `j` - up
- `k` - down
- `l` - right
- `h` - left 

Try it out with [`:VimBeGood`](https://github.com/ThePrimeagen/vim-be-good),
the game is `hjkl`.

These are slow. You can go forward by word with `w`, backward by word with
`b`. These movements are called *motions*. A motion is anything that moves the
cursor. 

You can augment any motion with a *command* and a *count*. With the *count* you
can make `vim` repeat the motion multiple times. Try `3j`, `5w`, `2k` etc. Try
the `relative` game in `:VimBeGood`.

You can do various commands. The `d` command stands for delete. To delete a
line, use `dd`. To undo the delete, use `u`. Use `Ctrl-r` to redo your previous
action. `u` is like `Ctrl-z`, `Ctrl-r` is like `Ctrl-y`. 

`d`'s can be used with motions: 

- to delete a single word: `dw`
- to delete the current line and 5 lines below: `d5j`
- to yank the current line and 3 lines below: `y3j`

### Insert Mode

To enter insert mode on the left side of your cursor, use `i`. To quit insert
mode:

- `Esc`
- `Ctrl-[`
- `Ctrl-c`, may cause some weirdness is visual block mode, but insubstantial.

To enter insert mode on the right side of your cursor, use `a`.

### Visual Mode

To go into visual mode, press `v`. In visual mode, you can use any of the
motions you've learned so far. At this point, you can copy and paste the
selected text: 
- `y` yanks (copies) the text, 
- `p` pastes it.

To go into visual line mode, press `Shift-v` (`V`). In this mode, you can copy
and paste entire lines.

You can paste over a highlighted region: 
- Select the text you want to copy, copy it
- Select the text you want to paste over
- Paste
- Note that if you paste now, you will get the last thing you deleted. Yanking
and deleting go to the same buffer.
