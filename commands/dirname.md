# `dirname`

[***Table of Contents***](/README.md)

This command can be used to extract the leading path components from a
file/directory path. It can do so from both relative and absolute paths:

```bash
dirname user/dir/dog.jpg
dirname /home/user/dog.jpg
```

If the full path ends with a directory, the command extracts its enclosing
directory:

```bash
dirname /home/user/dog_pictures
dirname /home/user/dog_pictures/
```

You can pass multiple arguments to it:

```bash
dirname /home/josh/dog.jpg /home/jake/cat.jpg /home/john/fish.jpg
```

According to `info dirname`, `dirname` and `basename` are designed so that if:

```bash
ls "/home/$USERNAME/file.txt" # <- if this command succeeds
cd "$(dirname "/home/$USERNAME/file.txt")" # <- both of these commands
ls "$(basename "/home/$USERNAME/file.txt")" # <- should succeed
```

*`dirname` does not make any considerations for sym links or whether or not a
file actually exists or not.*

The coreutils `dirname` simply performs string operations to print the first
part of the file path.
