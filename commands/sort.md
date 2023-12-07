# The `sort` command

[***Table of Contents***](/README.md)

Say you wanted to see the binaries of two directories in a sorted order. To do
that you can use `sort`:

    ls /usr/bin /bin | sort

`sort` will sort the lists of files and output the result.

It accepts standard input as well:

    sort > file.txt

`sort` can accept multiple files:

    sort 1.txt 2.txt 3.txt > final.txt

`sort` options:
- `-b` - ignore leading spaces in lines, calculates sorting based on the first
  non-whitespace character on the line
- `-f` - make sorting case-insensitive
- `-n` - allows sorting to be performed on numeric values rather than
  alphabetic values
- `-r` - reverse order
- `-k` - `--key=field1[,field2]` - sort based on a key field located from
  field1 to field2 rather than the entire line. Explained in detail later
- `-m` - merge already sorted files; do not sort
- `-o` - send sorted output to file rather than standard output
- `-t` - define the field-separator character. By default fields are separated
  by spaces or tabs

`-n`:

    /usr/bin/du -s /usr/share/* | head 
    /usr/bin/du -s /usr/share/* | sort -nr | head

But what if we want to sort a list based on some value found within the line?
The fifth size value in the output of `ls -l` indicates file size, use `-k` to
sort based on it:

    ls -l /usr/bin | sort -nrk 5 | head

Remember that `ls` itself can sort by size, this is just for the sake of
demonstration. `sort` sees whitespace characters (spaces and tabs) as
delimiters. 

You can sort multiple fields, and perform different types of sort on them. For
example, to perform an alphabetic sort on the first field and a numeric sort on
the second:

    sort -k 1,1 -k 2n file.txt

`1,1` specified the range, starting from 1st field and ending at 1st field.
`2n` indicates 2nd field, numeric sort. `n` is the option letter, they are:
- `b` - ignore leading blanks
- `n` - numeric sort
- `r` - reverse sort
You can specify multiple option letters, e.g. `nbr`.

Let's say you had a file `dates.txt` full of dates in the American format, how
would you sort it? Regular sorting won't work.

```
03/20/2006 
10/24/2006 
05/31/2007 
11/08/2007 
05/13/2008 
11/25/2008 
05/11/2006 
12/07/2006 
10/04/2007 
06/19/2008 
06/01/2006 
10/26/2006 
04/19/2007 
10/18/2007 
04/24/2008 
10/30/2008
```

You can specify offsets with the key option:

```
sort -k 1.7nbr -k 1.1nbr -k 1.4nbr dates.txt
```

Say you wanted to sort a non-standard file for example the `/etc/passwd` file.
Its fields are delimited with `:`, you can specify it with the `-t` option:

    sort -t ":" -k 7 /etc/passwd | head
