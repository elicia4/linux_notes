# 09. Vim Tips

[***go back to README***](README.md)

There is in fact a way to do this using Visual block mode. Simply pressing `$A`
in Visual block mode appends to the end of all lines in the selection. The
appended text will appear on all lines as soon as you press `Esc`.

So this is a possible solution:

```
vip<C-V>$A,<Esc>
```

That is, in Normal mode, Visual select a paragraph `vip`, switch to Visual
block mode `CTRL+V`, append to all lines `$A` a comma `,` then press Esc to
confirm.

You can save a keystroke by using `<C-V>ip` in place of `vip<C-V>`.

1. You can quit vim with `ZZ` (same as `:x`, save and quit), or `ZQ` (same as
   `:q!`)

2. To quit all tabs:

    `:qa`
