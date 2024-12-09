# `paste`

[***Table of Contents***](/README.md)

It's used to paste columns into a text document. It could be thought of as a
primitive terminal-based version of performing a paste operation inside of a
spreadsheet program.

`paste` allows you to paste columns of text at the end of lines in a file. 

You can specify one or more files and the lines in these files will be appended
one after another.

Let's say you had two files, one called 'dates.md' with the following contents:

```
11/25/2008 
10/30/2008 
06/19/2008
```

...and the other called 'versions.md' with the following contents:

```
Fedora  10 
Ubuntu  8.10 
SUSE    11.0
```

If you do:

```bash
paste dates.md versions.md > dv.md
cat dv.md
```

You get the combination of two files with their columns combined.

By default, columns will be delimited by tab characters. You can use `-d` to
specify a different custom delimiter:

```bash
paste -d ',' dates.md versions.md
```

`paste` is not capable of directly inserting a column into the middle of
existing lines. However, you can achieve the same result by leveraging `cut`.
Say you have files 'all.txt' and 'age.txt':

```
First   Last    ID
John    Smith   1
Jack    Dough   2
Jessica Lawson  3
```

```
Age
25
50
30
```

If you just run `paste`, the fields will follow each other:

```bash
paste all.txt age.txt
```

If you want to add insert the 'Age' field between 'Last' and 'ID':

```bash
paste <(cut -f 1-2 all.txt) ages.txt <(cut -f 3- all.txt)
```

It extracts the first two columns, followed by the 'Age' column, followed by
the rest (3rd until the last) of the columns.
