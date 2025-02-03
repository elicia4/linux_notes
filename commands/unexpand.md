# `unexpand`

[***Table of Contents***](/README.md)

Replace spaces with tabs:

```bash
unexpand -a file.txt
```

`-a` = convert all blanks, instead of just initial blanks.

Here's an `echo` that prints 8 space characters. See what happens when you pipe
it to `unexpand`:

```bash
echo -n '        ' | xxd
echo -n '        ' | unexpand | xxd
```

Here's another `echo` that prints out a sequence of seven spaces between 'a'
and 'b':

```bash
echo -e "a       b"
echo -e "a       b" | xxd
echo -e "a       b" | unexpand
echo -e "a       b" | unexpand | xxd
```

`unexpand` does not replace any spaces that appear after the first non-blank
character unless `-a` is added. This behavior is different from its
counterpart, `expand`. 

Both `expand` and `unexpand` support `-t` to describe tab widths or tab
locations.

However, `unexpand` WILL NOT perfectly undo the work of `expand`.
