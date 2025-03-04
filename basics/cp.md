# `cp`

[***Table of Contents***](/README.md)

The `cp` command is used to copy files and directories. It can be used in two
ways. The following copies `item1` to `item2`:

```bash
cp item1 item2
```

The following copies multiple items into a directory:

```bash
cp item ... directory
```

`-r` to copy directories:

```bash
cp -r dir1 dir2
```

`-p` to preserve permission and ownership information:

```bash
cp -p fayle1.txt fayle2.txt
```

`-n` to NOT overwrite existing files while copying:

```bash
cp -n new_file.txt existing_file.txt
```

The `cp` command has the following options:

- `-a` copies the files and directories and all of their attributes, including
  ownerships and permissions. Normally, copies take on the default attributes
  of the user performing the copy. Includes the functionality of the `-r`
  option.
- `-i`  prompts the user for confirmation before overwriting an existing file.
  If this option is not specified, `cp` will silently overwrite files. 
- `-r` recursively copies directories and their contents. This option (or the
  `-a` option) is required when copying directories.
- `-u` only copies files that either don't exist or are newer than the existing
  corresponding files, in the destination directory. This is useful when
  copying large numbers of files as it skips files that don't need to be
  copied.
- `-v` displays informative messages as the copy is performed.
