# `fold`

[***Table of Contents***](/README.md)

It's used to fold long lines into shorter ones:

```bash
fold file.txt
```

Punch cards used to have a maximum column width of 80, hence the standard
character limit.

`-s` makes line splits happen only at white spaces:

```bash
fold -s file.txt
```

By default, `fold` folds lines that are longer than 80 characters. You can
specify a different width with `-w`:

```bash
fold -s -w 60 file.txt
```

`-b` can be used to consider byte width instead of column width:

```bash
fold -b file.txt
```

This will have different behavior for multi-column characters like tabs.
