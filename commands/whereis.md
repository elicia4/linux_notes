# `whereis`

[***Table of Contents***](/README.md)

`whereis` - find the binary, source, and manual page files for a command:

```bash
whereis tar
```

`whereis` tries to find a program in the standard Linux places & in the places
specified by `$PATH` and `$MANPATH`.

Options:
- `-b` - search for binaries
- `-m` - search for manuals
- `-s` - search for sources

You can combine these:

```bash
whereis -bm tar
```

`-g` - interpret a name as a glob patterns. It's mandatory to use quotes, e.g.:

```bash
whereis -g 'find*'
```

### Searching for Multiple Commands

You can search for multiple commands and narrow down the search for each of
them:

```bash
whereis -bm ls tr -m gcc
```

Any new search restriction resets the search mask. Thus in the example above,
only the manuals & binaries will be found for `ls`, for `gcc` manuals only. 
