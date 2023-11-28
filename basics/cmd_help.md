# Command help

[***go back to README***](/README.md)

This note explains various commands that help you interact with commands and
find information about them.

There are four 'types' of commands:

1. An executable program
1. A command built into the shell itself
1. A shell function
1. An alias

To show a commands type:

    type <command>

To display an executable's location:

    which <command>

`bash` has built-in documentation for each shell built-in:

    help cd

**A note on notation:** When square brackets appear in the description of a
command's syntax, they indicate optional items. A vertical bar character
indicates mutually exclusive items. In the case of the `cd` command above:

    cd [-L|[-P[-e]]] [dir]

This notation says that the command `cd` may be followed optionally by either a
"-L" or a "-P" and further, if the "-P" option is specified the "-e" option may
also be included followed by the optional argument "dir".

Some commands support a built-in `--help` parameter:

    mkdir --help

To show a program's man page:

    man <command>

Man pages are usually intended as a reference, not a tutorial. More on man
pages [here](./man.md).

To display a one-line description of a command:

    whatis <command>

You can search for commands based on search terms:

    apropos partition

A good alternative to man pages are GNU's info pages:

    info ls

Info pages are displayed with an `info` reader program. To display command help
in info, use `?`. Check out:

    info coreutils

There are many types of documentation files. Most of them are stored in the
plain text format and can be viewed with `less`. The `.html` files can be
viewed with a web browser. Files with the `.gz` extension were compressed with
`gzip`, you don't have to decompress them, you can view them as are with:

    zless file
