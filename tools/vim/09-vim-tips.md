# 09. Vim Tips

[***Table of Contents***](./ToC.md)

### Appending to Each Line in a Block of Text

There is in fact a way to do this using Visual block mode. Simply pressing `$A`
in Visual block mode appends to the end of all lines in the selection. The
appended text will appear on all lines as soon as you press `Esc`.

So this is a possible solution:

```bash
vip<C-V>$A,<Esc>
```

That is, in Normal mode, Visual select a paragraph `vip`, switch to Visual
block mode `CTRL+V`, append to all lines `$A` a comma `,` then press Esc to
confirm.

You can save a keystroke by using `<C-V>ip` in place of `vip<C-V>`.

1. You can quit vim with `ZZ` (same as `:x`, save and quit), or `ZQ` (same as
   `:q!`)

1. To quit all tabs: `:qa`

1. To only substitute from current line to the end of the file:

   ```bash
   :.,$s/foo/bar/gi
   ```

### Create a Number Sequence with `g <CTRL-a>`

1. Create a sequence of numbers, e.g. of 0's:

```bash
0
0
0
0
```

This can be simply done: 
- `CTRL-v`
- select multiple empty lines
- `I`, enter `0`
- exit insert mode

Or:
- enter `0` on an new line
- `yy`
- `3p`

1. Select previously selected area with `gv`.
1. Finally, press `g CTRL-a` to create a sequence.

- *Use `<n>g CTRL-a` to use a step count of `<n>`*
- You can change the initial number (`<i>`) to any other integer, the first
selected number will always be `<i> + <n>`

So if you wanted to create a sequence of numbers starting with 4 and increase
every next occurrence by 10, you know what to do :)

### Paragraphs

vim understands the concept of a "paragraph". vim's definition of a paragraph
is a block of text surrounded by blank lines. There are several motions and
text objects to work with this.

- `[count]}` – Move `[count]` paragraphs forward. You can use `<S-v>}` to
select all lines from the current line to the next blank line. This will
include the blank line, so you may want to use `<S-v>}k`.
- `[count]ip` – Select `[count]` paragraphs. It's like `iw` (inner word) except
for, well, paragraphs. Using `vip` will select all of the paragraph though,
rather than from the current line to the end of the paragraph.
- `[count]ap` – like `ip`, except that this will include the blank lines
surrounding the paragraph.

One caveat here is that vim *doesn't* consider a line with only whitespace as a
"blank line". So make sure to check this (e.g. with `:set list`) if it doesn't
appear to work.
