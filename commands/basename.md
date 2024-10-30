# `basename`

[***Table of Contents***](/README.md)

The command removes the leading path components from a file/directory name.
E.g.:

```bash
basename /home/username/.bashrc # you only get the file name
```

`basename` is commonly used together with `dirname` as a method of parsing file
paths in shell scripts.

Imagine you have a script that takes an argument. It's expected to be any
relative/absolute path to a file that will be modified and saved with a
different name:

```bash
#!/bin/bash
FILE_PATH=${1}
FILE_NAME=$(basename "${FILE_PATH}")
DIR_NAME=$(dirname "${FILE_PATH}")
# >> something is done to a file <<
NEW_FILE_NAME="${DIR_NAME}/modified-${FILE_NAME}" # prefix is added to the name
echo "$NEW_FILE_NAME"
```
