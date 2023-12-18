# The `fold` command

[***Table of Contents***](/README.md)

`fold` is used to wrap each input line to fit in specified width. It accepts
multiple files and STDIN:

    echo "The quick brown fox jumped over the lazy dog." | fold -w 12

The text is broken into segments specified by `-w`, which specifies a line
width. If not specified, the default is 80 chars. The `-s` options causes
`fold` to break at the last available space:

    echo "The quick brown fox jumped over the lazy dog." | fold -w 12 -s
