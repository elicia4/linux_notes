# `sort`

[***Table of Contents***](/README.md)

The command can be used to sort the lines in a file/stream.

Say you wanted to see the binaries of two directories in a sorted order. To do
that you can use `sort`:

```bash
ls /usr/bin /bin | sort
```

`sort` will sort the lists of files and output the result.

It accepts standard input as well:

```bash
sort > file.txt # type in some lines, end input with `Ctrl-d`
```

```bash
echo -e " b \n c \n d \n a" | sort
```

`sort` can accept multiple files:

```bash
sort 1.txt 2.txt 3.txt > final.txt
```

`sort` does not modify the original file(s).

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
- `-u` - ignore duplicate fields, this one is especially useful for log entries
  that have duplicate entries
- `-R` - provide the output in a random order, but group identical keys

`-u`:

```bash
sort -u /var/log/syslog | wc -l
```

Imagine you have the following `numbers.txt` file:

```bash
0
21
123
```

If you sorted it without `-n`, it would be sorted alphabetically:

```bash
sort numbers.txt
# 0 
# 123 
# 21 
```

You want them to be sorted in *the numerical order* instead:

```bash
sort -n numbers.txt
# 0 
# 21 
# 123 
```

`-n`:

```bash
/usr/bin/du -s /usr/share/* | head 
/usr/bin/du -s /usr/share/* | sort -nr | head
```

But what if we want to sort a list based on some value found within the line?
The fifth size value in the output of `ls -l` indicates file size, use `-k` to
sort based on it:

```bash
ls -l /usr/bin | sort -nrk 5 | head
```

Remember that `ls` itself can sort by size, this is just for the sake of
demonstration. `sort` sees whitespace characters (spaces and tabs) as
delimiters. 

You can sort multiple fields, and perform different types of sort on them. For
example, to perform an alphabetic sort on the first field and a numeric sort on
the second:

```bash
sort -k 1,1 -k 2n file.txt
```

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
05/31/2007 
11/08/2007 
05/13/2008 
05/11/2006 
12/07/2006 
10/04/2007 
10/18/2007 
04/24/2008 
```

You can specify offsets with the key option:

```bash
sort -k 1.7nbr -k 1.1nbr -k 1.4nbr dates.txt
```

Say you wanted to sort a non-standard file, e.g., `/etc/passwd`. Its fields are
delimited with `:`, you can specify the field separator character with `-t`:

```bash
sort -t ":" -k 7 /etc/passwd | head
```

By specifying `:` as the field separator, we can sort on the 7th field.

The command support a great many options:

```bash
sort -t $'\t' -k 3,3rn -k 2,2 -k 1,1 -s --debug books.txt
```

- `-t $'\t'` - custom column delimiter
- `-k 3,3rn -k 2,2 -k 1,1` - column based sorting
- `-s` - sorting stability control, "stabilize sort by disabling last-resort
  comparison"
- `--debug` - the debugging option

It's extremely useful when used in a pipe with other commands, especially `head` and `tail`.

```bash
sort -t $'\t' -k 3,3rn -k 2,2 -k 1,1 -s --debug books.txt | head -n 1 # output the first entry
sort -t $'\t' -k 3,3rn -k 2,2 -k 1,1 -s --debug books.txt | tail -n 1 # output the last entry
```
