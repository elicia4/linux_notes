# `chmod`

[***Table of Contents***](/README.md)

It can be used to change the permission attributes of files and directories:

```bash
chmod ugo+rwx file.txt
```

- `ugo` - user, group, other (everyone else)
- `rwx` - read, write, execute

Say you have a script `script.sh` with the following permissions:

```bash
-rw-rw-rw-
```

If you try to run it, you will get `Permission denied.` To give the file's user
permission to execute the file:

```bash
chmod u+x script.sh
```

Now it should run successfully. To grant the execute permission to user, group,
and others:

```bash
chmod ugo+x script.sh
```

With this command, you can selectively grant read, write, and execute
permissions to the user, group, and others.

Some people like to use the octal notation to set the permissions:

```bash
touch file_no_perm.txt
ls -l file_no_perm.txt
chmod 750 file_no_perm.txt
ls -l file_no_perm.txt
```

Each bit in the octal number corresponds to the individual permission:

- `7` - `rwx`,
- `6` - `rw-`,
- `5` - `r-x`,
- `4` - `r--`,
- `0` - `---`,
- et cetera.

Read more about this in [the permissions note.](../misc/permissions.md)
