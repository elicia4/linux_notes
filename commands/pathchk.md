# `pathchk`

[***Table of Contents***](/README.md)

It's used to check if a path name is portable:

```bash
pathchk -P -p my-example-path#1
```

It can check for a number of different portability issues with file an path
names:

```bash
info pathchk
```

This command will check for path names that are too long to be POSIX-compliant:

```bash
pathchk -P -p aaaaaaaaaaaaaaaaaaaaaaaaaaaa
```

And this will check for an empty name:

```bash
pathchk -P -p ''
```

It can also check for file names that contain a leading `-` character:

```bash
pathchk -P -p -foo # <- won't work
pathchk -P -p '-foo' # <- won't work
pathchk -P -p "-foo" # <- won't work
pathchk -P -p -- -foo # <- works
```

`--` is a special argument that indicates the end of optional arguments as
described in the POSIX specification.

You can also check for directory permission issues:

```bash
pathchk foo/boo
```

And issues with file name constraints that are based on OS limits instead of
POSIX limits:

```bash
pathchk aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
```

The GNU coreutils implementation of `pathchk` also supports the `--portability`
flag that can be used in place of `-p -P`:

```bash
man pathchk
```
