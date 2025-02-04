# `dir` & `vdir`

[***Table of Contents***](/README.md)

According to `info dir`, `dir` does exactly the same thing as `ls -C -b`:
- `-C` - list entries by columns
- `-b` - print C-style escapes for non-graphical characters

The source code of `ls` shows that `dir` and `vdir` are simply thin wrappers
around `ls`.

```bash
dir
```

`vdir` = `ls -l -b`:

> that is, by default files are listed in long format and special characters
> are represented by backslash escape sequences.

```bash
vdir
```
