# `mkfifo`

[***Table of Contents***](/README.md)

It can be used to create named pipes:

```bash
mkfifo my-first-named-pipe
ls -l
```

A Unix pipe is a feature that allows programs to communicate with each other.
The simplest pipe can be created with `|`:

```bash
echo "Hello World\!" | xxd
```

In this case, the output of `echo` is fed into `xxd`. You could also redirect
the output of `echo` into a temporary file:

```bash
echo "Hello World!" > temp_output
```

However, using a file to store the output could be slow and take up space on
your hard drive. An alternative is to use `mkfifo` to create named pipes that
keep the data in memory and also provide blocking semantics.

Now if you run `echo` to write into the named pipe in the first terminal:

```bash
mkfifo my-hexdump-fifo
ls -l my-hexdump-fifo
echo "Hello World" > my-hexdump-fifo
```

The `echo` statement will block until you run another command to read the data
in the second terminal:

```bash
xxd my-hexdump-fifo
```
