# What Is the Shell?

The **shell** is a program that takes keyboard commands and passes them to the
operating system to carry out.

When using a graphical user interface (GUI), we need another program called a
**terminal emulator** to interact with the shell, its fundumental function is to
give you access to the shell.

A **shell prompt** is something that appears whenever the shell is ready to
accept input. It looks something like this:

```
[me@linuxbox ~]$
```

It will typically include your `username@machinename`, followed by the current
working directory (more about that in a little bit) and a dollar sign.

If the last character of the prompt is a pound sign (`#`) rather than a dollar,
sign, the terminal session has superuser privileges.

If we press the up-arrow key, we will see that the previous command reappears
after the prompt. This is called command history. Most Linux distributions
remember the last **1000** commands by default.


