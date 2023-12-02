# Data Streams

Notes on the video "Linux Crash Course - Data Streams (stdin, stdout & stderr)"
by LearnLinuxTV.

[***Table of Contents***](/README.md)  

Data streams is how Linux handles input, output, and errors.

Standard output = `stdout`, standard input = `stdin`, standard error =
`stderr`. 

If you type something with your keyboard, that's an example of standard input,
since your keyboard is an input device. So by typing characters into the
terminal and pressing "Enter", you're sending that command via standard input.

The text you see on your screen after running a command is an example of
standard output.

To see an example of standard error, run a command that doesn't exist on your
system, for instance:

    i-do-not-exist-123

The output of that command will be something along the lines of `bash: command
not found: "i-do-not-exist-123"`. It's not standard output, it's standard
error. When an error is displayed on the screen, it's standard error.

To view the last command's return code:

    echo $?

If it's 0, it means that the last command ran successfully. When an error is
encountered, the output of `echo $?` will be non-zero.

Standard output and standard error can be displayed at the same time:

    find /etc -type f 

It may look like it ran well, but if you look at the output there will be some
lines containing "Permission denied". You can also see if it ran successfully
by checking last command's return code:

    echo $?

That means that you just saw both stdout and stderr.
You split stdout and stderr and handle them differently:

    find /etc -type f 2> /dev/null

The command above will only show you stdout, no stderr. It redirected all your
stderr to a special file `/dev/null`. 

All data streams have designated numbers:
- stdin - 0
- stdout - 1
- stderr - 2

By running `2>`, you redirected all your errors to `/dev/null`, which you can 
imagine as a black hole (it's a device file that discards everything written
to it, it also reports if the operation succeeded). stderr gets deleted.

Let's try something else:

    find /etc -type f > ~/results.txt

`>` means the same thing as `1>`. Standard output is implied, only stdout will
be written to the `results.txt` file.

To redirect stdout and strerr to different places:

    find /etc -type f 1> ~/results.txt 2> ~/errors.txt

To append to the files instead of overwriting them, use `>>`:

    find /etc -type f >> ~/results.txt 2>> ~/errors.txt

To redirect both stdout AND stderr to a file:

    find /etc -type f > ~/combined.txt 2>&1
