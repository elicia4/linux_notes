# `chown`

[***Table of Contents***](/README.md)

It can be used to change the user/group ownership of files/directories:

```bash
sudo chown root file1.txt
```

These commands create a temporary file in the home directory, change the file's
ownership to another user, delete the file:

```bash
FILE=$(mktemp -p $HOME)
ls -l $FILE # its user owner should be $USER
sudo chown mike $FILE
ls -l $FILE # now it's mike
rm $FILE
```

`chown` can perform the functions of `chgrp` as well:

```bash
sudo chown mike:mike file.txt # this command will change user & group ownership
                              # at the same time
```

The file permissions associated with the user are located in the first set of
permission bits, the group permissions are in the second set.

You can use `-R` to recursively change the ownership of all items in a
directory:

```bash
sudo chown -R mike:mike docs
```
