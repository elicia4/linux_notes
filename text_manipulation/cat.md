# `cat`

These are notes on [this video](https://www.youtube.com/watch?v=z3nJlyrJYW4),
documentation and various resources on the Internet.

[***Table of Contents***](/README.md)

It stands for "concatenate", you can use it to link files together or show the
contents of one or multiple files at once.

To show the contents of a file:

```bash
cat file
```

To concatenate files together:

```bash
cat file1 file2 ...
```

The contents of those files will be combined into one output. You can redirect
the output to a new file:

```bash
cat file1 file2 > combined.txt
```

If you downloaded a file that was split into multiple parts for some reason,
for example a file called `book.epub` was split into `book.001`, `book.002`
etc., you join it together the same way:

```bash
cat book00* > book.epub
```

To show line numbers, add `-n`:

```bash
cat -n file
```

You can chain the `cat` command with other commands:

```bash
cat file | grep --color cats
```

To alphabetically sort lines from multiple files:

```bash
cat 1.txt 2.txt | sort
```

To show the port number in your SSH config:

```bash
cat /etc/ssh/sshd_config | grep --color Port
```

To see the number of lines in your SSH config:

```bash
cat /etc/ssh/sshd_config | wc -l
```

`cat` without arguments takes input from standard input and prints it to
standard output. To properly quit, use `<CTRL-d>`. Try it out:

```bash
cat > foo.txt
```

Display non-printing characters in the text with `-A`:

```bash
cat -A file.txt
```

Tabs are represented as `<^I>`, the same thing as `<CTRL+i>`.

A great reason to use `cat` is to see non-printing characters. There may be
carriage returns, they come from DOS and Windows. UNIX ends lines with a
linefeed character (ASCII 10) while MS-DOS use the sequence carriage return
(ASCII 13) and linefeed to end each line of text. To convert from DOS to Unix
format, use `dos2unix`, to convert back use `unix2dos`; another way to
accomplish that is just to remove the carriage returns from text.

To suppress the output of blank lines, use `-s`:

```bash
cat "\n\n123" > file.txt
cat -n file.txt # w/o -s
cat -ns file.txt
```
