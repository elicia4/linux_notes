# `yes`

[***Table of Contents***](/README.md)

It's used to print 'y' as fast as possible:

```bash
yes
```

You can exit it by pressing `^C`. The purpose of this command is to spam 'y'
repeatedly as a way of answering 'yes' to applications that ask for
confirmation.

E.g., imagine you have a file that doesn't have its write permission set:

```bash
ls -l main.c
```

```
-r--rw-r-- ...
```

If you try to delete it, you'll be prompted asking for input:

```bash
rm main.c
```

If you run `yes` and pipe its output into the command, the file will be deleted
without asking first:

```bash
yes | rm main.c
```

This is especially useful for writing automated scripts. In the case of piping, `yes` knows to exit automatically once it receives the SIGPIPE signal:

```
man 7 signal
# SIGPIPE      P1990      Term    Broken pipe: write to pipe with no
#                                readers; see pipe(7)
```

Another application of `yes` is to trigger high CPU load for testing purposes:

```bash
htop
```
