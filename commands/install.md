# `install`

[***Table of Contents***](/README.md)

It can be used to copy and install files:

```bash
install notes.txt notes_copy.txt
ls
```

The simplest use of the command works just like `cp`. All it does is make a
copy of a file.

It also lets you directly set the permissions on the new copied file:

```bash
install --mode='ugo=rwx' notes.txt notes_copy.txt # grant all permissions
install --mode='ugo=-rwx' notes.txt notes_copy.txt # grant no permissions
```

The primary application of the command is for use in makefiles. You can create
variables that reference `install`.

It's used in various places throughout the project's makefiles. Specifically
during the execution of the `make install` rule.

`install` includes many other flags that are useful for installing programs:

```bash
man install
```

E.g., `-s` will strip debug symbols from an executable as it gets copied:

```bash
install -s a.out no-sym.out
# vim -d <(objdump -t a.out) <(objdump -t no-sym.out)
```
