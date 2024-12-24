# `truncate`

[***Table of Contents***](/README.md)

Used to truncate or extend a file to a given size:

```bash
truncate -s 0 foo.txt # set it to size 0
```

You can truncate files to 0 with `-s`:

```bash
cat README.md
# 123123
truncate -s 0 README.md # set it to size 0
cat README.md
```

If you specify a different value, e.g. 12, the size of the file will be
explicitly changed to 12:

```bash
truncate -s 12 file
ls -l file
```

If the file was previously larger than 12 bytes, the extra data will be
discarded, but the first part of the file will remain unchanged.

Size units can also be provided, like KiloBytes (KB, 1000), KibiBytes (K, 1024)
etc.

It also supports modifiers:
- `+` extend by
- `-` reduce by
- `<` at most
- `>` at least
- `/` round down to multiple of
- `%` round up to multiple of

E.g.:

```bash
truncate -s +10 file.txt # extend 
truncate -s -10 file.txt # reduce
```

The `%` will round the file size up to the nearest multiple, so if the
operation is `%13` and a file is 16 bytes long, it will be rounded up to 26.
