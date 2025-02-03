# `arch`

[***Table of Contents***](/README.md)

Print out the current machine hardware name:

```bash
arch
```

The output of `arch` is identical to the output of `uname -m`:

```bash
uname -m
```

That's all the command does. It only has two flags, `--help` and `--version`.
It's the same executable as `uname`. The only difference is a hard-coded global
variable that identifies what `uname` should output:

```bash
#define UNAME_ARCH 2
```
