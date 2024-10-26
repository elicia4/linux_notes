# `mktemp`

[***Table of Contents***](/README.md)

The command is used to create temporary files:

```bash
mktemp # file path will appear
```

The command created a temporary file and printed out its location:

```bash
ls -l $(mktemp)
```

By default, it's created in the '/tmp' directory. Use `-p` to specify another
directory:

```bash
mktemp -p $HOME
```

It's particularly useful in scripts. Some actions are done with the help of a
temp file, which is then deleted.
