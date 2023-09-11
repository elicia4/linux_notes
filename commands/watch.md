# The "watch" command

Notes taken on the "Linux Crash Course - The "watch" Command" video by
LearnLinuxTV.

[***go back to README***](/README.md)  

The `watch` command is used to execute a command repeatedly, and monitor the
output in full-screen mode.

Let's imagine somebody has to send you a file to particular directory, for
instance your home directory.

    watch ls

The command above will execute `ls` every two seconds and show the output. If
you create the file inside the home directory, you will see it appear inside
the `watch` output.

To keep an eye on storage:

    watch df -h

To keep an eye on memory:

    watch free -m # results in megabytes

You can highlight changes inside of `watch` by using the `-d` option:

    watch -d free -m

This option draws immediate attention to what's changing, which is why it's
especially useful.

You can change the execution interval with the `-n` option:

    watch -d -n 0.5 free -m

Every time you want to see the status of something change and want to know what
the differences are, use `watch`.

Let's say you want to use `watch` with pipes or redirects:

    watch ls -lh | grep file.txt 

This is going to fail silently. The solution is adding quotes (`'`):

    watch 'ls -lh | grep file.txt'
    
