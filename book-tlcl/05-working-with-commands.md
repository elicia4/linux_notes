# Working with Commands

---
***[Contents](00-intro.md)***
---

- `type` – Indicate how a command name is interpreted
- `which` – Display which executable program will be executed
- `help` – Get help for shell builtins
- `man` – Display a command's manual page
- `apropos` – Display a list of appropriate commands
- `info` – Display a command's info entry
- `whatis` – Display one-line manual page descriptions
- `alias` – Create an alias for a command

What are the types of commands?

1. An executable program like all those files we saw in /usr/bin. Within this
   category, programs can be compiled binaries such as programs written in C
   and C++, or programs written in scripting languages such as the shell, Perl,
   Python, Ruby, and so on.
2. A command built into the shell itself. bash supports a number of commands
   internally called shell builtins. The cd command, for example, is a shell
   builtin.
3. A shell function. Shell functions are miniature shell scripts incorporated
   into the environment. We will cover configuring the environment and writing
   shell functions in later chapters, but for now, just be aware that they
   exist.
4. An alias. Aliases are commands that we can define ourselves, built from
   other commands.

The `type` command is a shell builtin that displays the kind of command the
shell will execute, given a particular command name:

    type command

To determine the exact location of a given executable, the
`which` command is used:

    which ls

`which` only works for executable programs, not builtins nor aliases that are
substitutes for actual executable programs.

**A note on notation**: When square brackets appear in the description of a
command's syntax, they indicate optional items. A vertical bar character
indicates mutually exclusive items. In the case of the `cd` command above:

    cd [-L|[-P[-e]]] [dir]

This notation says that the command cd may be followed optionally by either a
`-L` or a `-P` and further, if the `-P` option is specified the `-e` option may
also be included followed by the optional argument `dir`.

### apropos

It is also possible to search the list of man pages for possible matches based
on a search term. It's crude but sometimes helpful. Here is an example of a
search for man pages using the search term "partition":

    apropos partiton

To remove an alias, use `unalias`:

    unalias <your-alias>
