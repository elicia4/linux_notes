# `uname`

[***Table of Contents***](/README.md)

This command is used to print basic system information about your OS. By
default, it only prints the kernel name:

```bash
uname
```

Typically it's ran with `-a` to print all information about the system the
command can provide:

```bash
uname -a # there might be duplicate information
```

To print the operating system:

```bash
uname -o
```

To print the kernel version (*release in `uname`'s terms*):

```bash
uname -r
```

To print the kernel version (rarely used):

```bash
uname -v
```

To print the hostname (network node hostname):

```bash
uname -n
```

`hostname` is more standard for that, `hostnamectl` give you even more
information:

```bash
hostname
hostnamectl
```

To find out your CPU architecture (machine hardware name):

```bash
uname -m
```

You can combine options as well, people generally don't do this:

```bash
uname -nr
```

As always, check out the documentation for more info:

```bash
man uname
```
