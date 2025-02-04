# `ptx`

[***Table of Contents***](/README.md)

Produce a permuted index of a text file:

```bash
ptx file.txt
```

A permuted index, also known as 'Key Word In Context' (KWIC), is part of an
obsolete method of organizing keywords in a piece of documentation. 

The first words on the will be sorted. You can specify an ignore file to ignore
common English words:

```bash
ptx --ignore-file=ignore.txt file.txt
```

You can also use `--format` to format the permuted index into a type setting
language like TEX for further processing:

```bash
ptx --ignore-file=ignore.txt --format=text file.txt
```
