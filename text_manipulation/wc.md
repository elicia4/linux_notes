# `wc`

[***Table of Contents***](/README.md)

`wc` prints newline, word, and byte counts for each file. By default, it prints
out all three:

```bash
wc file
```

By default, it will output all three numbers. To limit output only to lines:

```bash
wc -l file
```

To count words:

```bash
wc -w file
```

To count bytes:

```bash
wc -c file
```

You can run the command on multiple files at once to see individual and
aggregate counts:

```bash
wc -l story.txt main.c
```
