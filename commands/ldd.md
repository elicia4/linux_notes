# The `ldd` command

[***Table of Contents***](/README.md)

Say you run an executable and it returns an error which states that you don't
have a certain library installed that is required for the program to run.

To find out what libraries (shared libraries/shared objects) a program
requires:

```bash
ldd <file>
```

`ldd` will display a list of dependencies and their locations and addresses (if
they're found).
