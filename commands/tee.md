# The `tee` command

[***Table of Contents***](/README.md)

`tee` reads from standard input and writes to standard output and files, this
is useful for capturing a pipeline's contents at an intermediate stage of
processing:

    ls /usr/bin | tee ls-contents.txt | grep -i .sh

`tee` will redirect the output of `ls /usr/bin` to `ls-contents.txt` and pass
standard output along to `grep`.
