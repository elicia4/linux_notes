# Advanced Motions P1

[***Table of Contents***](./ToC.md)

### Horizontal Motions

To select text within parentheses (without the parentheses themselves): `vi(`,
`vi[`, `vi{`

To select text within parentheses (with the parentheses themselves): `va(`,
`va[`, `va{`

Note that it doesn't matter exactly where you are on the line to do these
selections, e.g., if you're at the first `T` in:

```
To select text within parentheses (without the parentheses themselves): `vi(`,
`vi[`, `vi{`
```

...and do `vi(`, all the text within the next round brackets will be selected.
This won't work if you're inside braces that are not closed. If it doesn't
work, you can always jump to the bracket and select from there.

You can do the same thing with `d` to delete, `y` to copy and `c` to change.

To select a word from any position in it, use `viw`. Again, this can be done
with `d`, `y`, and `c` as well.

`yiw` and `yiW` are especially useful. They remove the need to use `f` and `t`
all the time to go to a position. It doesn't matter what you need to select up
to, you can just select it and correct the little details after.

### `<leader>p Remap`

Whenever you paste over text, you lose whatever was in your paste buffer, since
whatever gets replaced is inserted into it. A nice remap to have is the
following:

```bash
xnoremap("<leader>p", "\"_dP)
```

If you are in some sort of visual mode and you do `<leader>p`, it will do a
delete to the underscore register (which makes it disappear) and will `P` back
into that paste. Essentially, it keeps whatever was in the register before
pasting inside it.

### Double Tapping

It's better to visual select and then do a command, e.g., it's better `VY`
instead of `yy`, `VD` instead of `dd` etc.

### Taking Advantage Of Existing Text

It's better to take existing text and edit it instead of fully rewriting it. If
you already have a line, use it!

Never forget to have fun along the way! :)
