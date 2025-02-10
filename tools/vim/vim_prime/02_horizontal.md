# Horizontal Movement

[***Table of Contents***](./ToC.md)

Couple new motions:
- `_` to the beginning of the current line (first non-whitespace character)
- `$` to the end of the current line
- `0` to the 1st character of the current line

You can mix these. `d$` will delete everything from cursor all the way to the
end.

It's possible to move to a specific character in the current line. To jump to
the next `(` symbol, use `f(`. `f` goes *forward* to the character you say. To
jump up to (but not *on*), use `t`: `t(`. 

If you want to repeat:
- `;` to go forward
- `,` to go backward

Play around with it. To do the same thing but to search backwards on the
current line: `F` and `T`.

The anatomy of a motion: `command` + `count` + `motion`. 

- To delete all characters from cursor up to and including `(`, use `df(`.
- To delete all characters from cursor up to but not including `(`, use `dt(`.

Same thing with yank. Imagine how useful it can be with functions:

```py
def very_long_func_name().expect("to exist"):
    ...
```

For example, to delete the name of the function, you can do `dt(`. If you want
to delete everything up to the second `(`, you can do `d2t(`. Don't forget the
anatomy of a motion!

- `I` goes to the beginning of the line and enters insert mode
- `A` goes to the end of the line and enters insert mode
- `o` creates a new line below and enters insert mode
- `O` creates a new line above and enters insert mode

### Buffers

A buffer is something that contains text. It can contain a view of the file
system (if you open a directory with `vim`), but you will usually work with
text.

A buffer is contained in a window. If you opened the same thing multiple times
in different windows, the windows' IDs would be different, but the buffer would
be the same. A buffer is the in-memory representation of the file below it.

### Basic Vim Navigation Tips

NOTE: The `.vimrc` video mentioned in the video no longer exists. [There's a
newer version though, try it out.](https://www.youtube.com/watch?v=w7i4amO_zaE)

If you do `vim .`, the current directory will be opened. `netrw` allows you
to do basic file system manipulation with `vim`.

To open up a file tree, use `:Ex`.

- *Telescope* is a much better tool for navigation though. It allows you to do
fuzzy finding with vim. It is also highly customizable.
- Another great tool for file navigation is *Harpoon*. It allows you to have
"sticky" files, allowing you to navigate between them quickly.

Dive into navigation! Find the right plugins for you! Think about how you want
to interact with git, find files, open files, create files etc.

General rules for installing plugins:
1. Have a need for somethings (in this case, `fzf`)
1. Find that thing! If it doesn't exist, attempt to create it yourself (but
   more likely than not, a solution already exists)
