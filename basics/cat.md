# The `cat` command

Notes taken on the "The cat Command in Linux (Featuring Real Cats) - Linux
Crash Course Series" video by Learn Linux TV.

[***Table of Contents***](/README.md)

It stands for "concatenate", you can use it to link files together or show the
contents of a text file. 

To show the contents of a file:

    cat file

To concatenate files together:

    cat file1 file2 ...

The contents of those files will be combined into one output. You can redirect
the output to a new file:

    cat file1 file2 > combined.txt

If you downloaded a file that was split into multiple parts for some reason,
for example a file called `book.epub` was split into `book.001`, `book.002`
etc., you join it together the same way:

    cat book00* > book.epub

To show line numbers, add `-n`:

    cat -n file

You can chain the `cat` command with other commands:

    cat file | grep --color cats

To show the port number in your SSH config:

    cat /etc/ssh/sshd_config | grep --color Port

To see the number of lines in your SSH config:

    cat /etc/ssh/sshd_config | wc -l
