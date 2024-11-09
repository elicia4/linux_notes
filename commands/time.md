# `time`

[***Table of Contents***](/README.md)

You can measure how much a command/script/program takes with this command.

`time` runs the specified program command with the given arguments. When it
finishes, `time` writes a message to STDOUT giving timing statistics about the
run.

```bash
time ls
```

You get three lines of output after the result: the time it took to run the
command in `real`, `user` and `sys` modes.

A more useful thing to measure is the time it takes to update your system:

```bash
time sudo apt dist-upgrade
# time sudo dnf update etc.
```

You can time a download:

```bash
time wget \ 
https://fr.mirrors.cicku.me/archlinux/iso/2024.09.01/archlinux-2024.09.01-x86_64.iso
# arch iso from a french mirror
```

Let's explore the output fields:
1. `real` refers to real time. Usually the number you pay attention to.
1. `user`, the time in which the command ran in user mode
1. `sys` or kernel mode, the time in which the command ran in system mode

`-o` allows you to redirect the output to a file. It always overwrites the
file:

```bash
time -o output.txt ls
# OR
# /usr/bin/time -o output.txt ls
```

To append:

```bash
# -a = append mode
/usr/bin/time -o output.txt -a ls
```

Why are there two `time` commands? 
- one is a shell built-in
- the external command

Any time you want time something, `time` is a great way to do it! :)
