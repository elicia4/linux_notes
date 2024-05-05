# The `man` command

Notes taken on the "Linux Crash Course - Learn The `man` Command" video by
Learn Linux TV.

[***Table of Contents***](/README.md)

`man` allows you to view manual pages, they contain a lot of information on
various Linux commands and more, like command line arguments, usage examples
and more.

Most Linux distributions come with the `man` command by default. In case it's
not, install it.

To see the manual page for `ls`:

```bash
man ls
```

To scroll down and up, use the `Up` and `Down` arrows. `PgUp` and `PgDn`
buttons are supported as well. The man pages are quite extensive.

People don't usually memorize all the options of the commands they use, they
use man pages and the Internet. When you can't remember some command option,
use `man`. Press `q` to quit.

The `rsync` utility has a lot of options:

```bash
man rsync
```

It's a big man page. Press `h` for help. 
- to search for information, use `/pattern`
- to go to the beginning of a man page, use `g` (or `gg`)
- to go to the end, use `G`

There are multiple sections within the `man` pages. Each section goes over very
specific category of information.

Let's look at the `passwd` command:

```bash
man passwd
```

In the top corners, there are numbers, `1`s. `1` represents section 1. Section
1 is for executable programs or shell commands, `passwd` is a shell command, so
it has info in section 1 of the man pages.

If you're looking for a specific section, type the number of the section right
after the `man` command:

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
1. System calls
1. Library calls
1. Special files
1. File formats and conventions
1. Games
1. Misc
1. System administration commands
1. Kernel routines

Some commands don't exist in these sections.

There are built-in commands, they don't have their own man pages. For example,
`cd`:

```bash
man cd
```

There is a workaround, though:

```bash
man builtins
```

`cd` is a built-in command. In case you try to look up a command and you can't
do it with `man`, try looking for it in the `builtins` page.
