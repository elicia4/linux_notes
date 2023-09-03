# Redirection

- `cat` – Concatenate files
- `sort` – Sort lines of text
- `uniq` – Report or omit repeated lines
- `grep` – Print lines matching a pattern
- `wc` – Print newline, word, and byte counts for each file
- `head` – Output the first part of a file
- `tail` – Output the last part of a file
- `tee` – Read from standard input and write to standard output and files# Redirection

The "I/O" stands for input/output and with this facility we can redirect the
input and output of commands to and from files, as well as connect multiple
commands together into powerful command *pipelines*.

Programs actually send their results to a special file called "standard output"
(often expressed as `stdout`) and their status messages to another file called
"standard error" (`stderr`).

To redirect standard error we must refer to its **file descriptor**. A program
can produce output on any of several numbered file streams. While we have
referred to the first three of these file streams as standard input, output and
error, the shell references them internally as file descriptors *0, 1, and 2*,
respectively. Since standard error is the same as file descriptor number 2, we
can redirect standard error with this notation:

    ls -l /bin/usr 2> ls-error.txt 

To redirect both SO and SE to one file:

    ls -l /bin/usr > ls-output.txt 2>&1

The order matters, the redirection of standard error must always occur after
redirecting standard output or it doesn't work.

A more streamlined method for performing this combined redirection shown here:

    ls -l /bin/usr &> ls-output.txt

You can also append both SO and SE like so:

    ls -l /bin/usr &>> ls-output.txt

`/dev/null` is a system device often referred to as a *bit bucket*, which
accepts input and does nothing with it. To suppress error messages from a
command, we do this:

    ls -l /bin/usr 2> /dev/null
    
If the files were named:

    movie.mpeg.001 movie.mpeg.002 ... movie.mpeg.099

We could join them back together with this command as follows:

    cat movie.mpeg.0* > movie.mpeg

If cat is not given any arguments, it reads from standard input and since
standard input is, by default, attached to the keyboard, it's waiting for us to
type something:

    cat

Now that we know how cat accepts standard input, in addition to filename
arguments, let's try redirecting standard input:

    cat < lazy_dog.txt

Using the `<` redirection operator, we change the source of standard input from
the keyboard to the file `lazy_dog.txt`.
