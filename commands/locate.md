# The `locate` command

[***Table of Contents***](/README.md)

`locate` allows you to find files by name, it does it by searching databases
prepared by `updatedb`. It outputs paths to the files:

```bash
locate zip
locate bin/zip
```

There are several variants of the `locate` command, the most common ones are:

- `slocate` 
- `mlocate` 

Recently created files might not be shown by `locate`. To fix that:

```bash
updatedb
```

That command provides databases needed for `locate`.

`locate` supports both BRE (`--regexp`) and ERE (`--regex`), e.g.:

```bash
cd /usr
locate --regex 'bin/(bz|gz|zip)'
```
