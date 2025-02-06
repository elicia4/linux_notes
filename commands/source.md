# `source`

[***Table of Contents***](/README.md)

`source` is a shell builtin. It reads and executes commands from 'filename' in
the **current** shell environment and returns the exit status of the last
command executed from 'filename'. Usually it's used with the shell config file,
e.g.:

```bash
# source filename
source .bashrc
```

`.` is the same thing as `source`:

```bash
. .bashrc # is the same thing as
source .bashrc # this
```

Again, when you `source` a script you are executing the commands in your
current shell. *Any changes to the environment will take effect and stay in
your current shell.*

When you execute a script, commands are executed in a new shell, the output is
printed back in your current shell, and the new shell is closed. *Any changes
to the environment will take effect only in the new shell and will be lost once
the shell is closed.*
