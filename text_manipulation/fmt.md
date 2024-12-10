# `fmt`

[***Table of Contents***](/README.md)

It can be used to format the spaces and lines in text files:

```bash
echo "The     quick       brown        fox." | fmt -u
# The quick brown fox.
```

It accepts files and STDIN. 

Say you have a file that has lines that are way too long, `fmt` can format the
file so that its lines have a maximum width of 75:

```bash
cat file.txt | fmt
# or just simply 'fmt file.txt'
```

You can also specify the column width with `-w`:

```bash
fmt -w 60 file.txt
```

`-u` enforces uniform spacing:

```bash
fmt -u file.txt
```

You can get a slightly more compact result by specifying the goal width instead
of a fixed width with `-g`:

```bash
fmt -g 60 -u file.txt
```

With `-g GOAL` `fmt` initially tries to make lines 'GOAL' characters wide. By
default, this is 7% shorter than WIDTH.

`-w WIDTH` makes `fmt` fill output lines up to 'WIDTH' characters (default 75
or 'GOAL' plus 10, if 'GOAL' is provided).

From `info`:

> By default, blank lines, spaces between words, and indentation are preserved
> in the output; successive input lines with different indentation are not
> joined; tabs are expanded on input and introduced on output.

To fix the weird alignment, use `-c`:

```bash
fmt -cw 50 fmt_info.txt
```

`fmt` options:
- `-c` - preserve the indentation of the first two lines of a paragraph.
  Subsequent lines are aligned with the indentation of the second line. 
- `-p STRING` - format only those lines beginning with STRING. After
  formatting, the contents of STRING are prefixed to each reformatted line.
  This option can be used to format text in source code comments. For example,
  any programming language or configuration file that uses a `#` character to
  delineate a comment could be formatted by specifying `-p '# '` so that only
  the comments will be formatted. E.g.:

  ```bash
  echo "# This file contains code with comments.
  # This line is a comment. 
  # Followed by another comment line. 
  # And another. 
  This, on the other hand, is a line of code. 
  And another line of code. 
  And another." > fmt_code.txt
  cat fmt_code # cat the origin version out
  fmt -w 50 -p '# ' fmt-code.txt # format the comments, leave code untouched
  ```

- `-s` - split-only mode. In this mode, lines will only be split to fit the
  specified column width. Short lines will not be joined to fill lines. This
  mode is useful when formatting text such as code where joining is not
  desired.
- `-u` - perform uniform spacing. This will apply traditional "typewriter-
  style" formatting to the text. This means a single space between words and
  two spaces between sentences. This mode is useful for removing
  "justification," that is, text that has been padded with spaces to force
  alignment on both the left and right margins.
- `-w width` - format text to fit within a column width characters wide. The
  default is 75 characters. Note: `fmt` actually formats lines slightly shorter
  than the specified width to allow for line balancing.
