# `tty`

[***Table of Contents***](/README.md)

It's used to identify the terminal file that's connected to STDIN:

```bash
tty
```

If you run the command on your desktop graphical terminal, you'll get the
following output (or something similar to it):

```
/dev/pts/0
```

It indicates a pseudo terminal. If you open a terminal emulator like `screen`
or `tmux`, you'll see another pseudo-terminal reference:

```
/dev/pts/1
```

If you switch out of a graphical environment into a console, you'll see a
terminal file that looks similar to the following:

```
/dev/tty3
```

The return code from `tty` also provides meaningful information:
- `0` - standard input is a terminal
- `1` - standard input is a non-terminal file
- `2` - given incorrect arguments
- `3` - a write error occurred

A write error can be simulated by using the `>&-` special syntax that closes
standard output (so that write operations fail):

```bash
tty >&-
```
