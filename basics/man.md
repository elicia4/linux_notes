# `man`

Notes taken on the "Linux Crash Course - Learn The `man` Command" video by
Learn Linux TV.

[***Table of Contents***](/README.md)

`man` allows you to view manual pages, they describe Linux commands and their
arguments, usage examples etc.

To see the manual page for `ls`:

```bash
man ls
```

To scroll down and up, use the `Up` and `Down` arrows. `PgUp` and `PgDn`
buttons can be used for faster navigation as well. `q` to quit.

The man pages are quite extensive. People don't usually memorize all the
options of the commands they use, they use man pages and the Internet. When you
can't remember some command option, use `man`. 

`rsync` has a lot of options:

```bash
man rsync
```

It's a big man page. `h` for help. 
- to search for information, use `/<pattern>`
- to go to the beginning of a man page, use `g` (or `gg`)
- to go to the end, use `G`

There are multiple sections within the man pages. Each section goes over very
specific category of information.

Let's look at `passwd`:

```bash
man passwd
```

In the corners at the top of the page, there are numbers, `1`s. `1` represents
section 1. Section 1 is for executable programs or shell commands, `passwd` is
a shell command, so it's described in section 1 of the man pages.

If you're looking for a specific section, type the section number right after
`man`:

```bash
man 5 passwd
```

Now you see that it's section 5, the page itself is about the `passwd` file.

You can look up man pages based on search terms with the `-k` option:

```bash
man -k partition
```

It performs the same function as `apropos`.

There are 9 sections:
1. Command info
2. System calls
3. Library calls
4. Special files
5. File formats and conventions
6. Games
7. Misc
8. System administration commands
9. Kernel routines

Some commands don't exist in these sections.

There are built-in commands, they don't have their own man pages. E.g, `cd`:

```bash
man cd
```

There is a workaround, though:

```bash
man builtins
# man zshbuiltins # if you use zsh
```

`cd` is a built-in command. In case you try to look up a command and you can't
do it with `man`, try looking for it in the `builtins` page. Alternatively, you
can just go to `man bash` and navigate to the "SHELL BUILTIN COMMANDS" section.

To view a brief summary of a built-in command:

```bash
help read
```
