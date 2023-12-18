# The `fmt` command

[***Table of Contents***](/README.md)

`fmt` is a simple text formatter. It accepts files and STDIN. 

Create a simple text file:

    info fmt > fmt_info.txt
    cat fmt_info.txt

To reformat this text to fit into a 50-character-wide column:
    
    fmt -w 50 fmt_info.txt

From the `info` page:

> By default, blank lines, spaces between words, and indentation are
> preserved in the output; successive input lines with different
> indentation are not joined; tabs are expanded on input and introduced on
> output.

To fix the weird alignment, use the `-c` option:

    fmt -cw 50 fmt_info.txt

`fmt` options:
- `-c` - preserve the indentation of the first two lines of a paragraph.
  Subsequent lines are aligned with the indentation of the second line. 
- `-p STRING` - format only those lines beginning with STRING. After
  formatting, the contents of STRING are prefixed to each reformatted line.
  This option can be used to format text in source code comments. For example,
  any programming language or configuration file that uses a `#` character to
  delineate a comment could be formatted by specifying `-p '# '` so that only
  the comments will be formatted. For example:
  ```
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
