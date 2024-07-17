# `type`

[***Table of Contents***](/README.md)

`type` shows how each argument would be interpreted if used as a command:

```bash
type ls dir df
```

In particular, it can be used to see what alias is used for a command. 

You can also look up where a particular binary is located on the system (you
can look up binaries that are aliased as well):

```bash
type -a ls
```

To see what type of program is a particular command:

```bash
type -t ls
```
