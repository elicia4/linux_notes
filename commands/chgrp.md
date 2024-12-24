# `chgrp`

[***Table of Contents***](/README.md)

It's used to change the group ownership of files and directories:

```bash
chgrp user file.txt # will change the group ownership to 'user'
```

You can see which groups the current user belongs to with `groups`:

```bash
groups
```

If the current user is not the owner of the file but belongs to a group that
owns the file, then the group file permissions will apply.

To add a permission to the group, e.g., the execute permission:

```bash
chmod g+x file.txt
```

Or take away all of them:

```bash
chmod g+x file.txt
```
