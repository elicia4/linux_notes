# `stat`

[***Table of Contents***](/README.md)

Show file system attributes of files on your system:

```bash
stat file
```

Various pieces of information displayed by `stat` are also shown by `ls`:

```bash
ls -li file
```

The output of `stat` focuses primarily on file system details, like inodes,
block sizes, and verbose descriptions of the file's permissions and timestamp
attributes:


```
  File: file.txt
  Size: 4086            Blocks: 8          IO Block: 4096   regular file
Device: 8,2     Inode: 30000       Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/   user)   Gid: ( 1000/   user)
Access: 2025-01-18 11:20:01.780238733 +0900
Modify: 2025-01-18 11:20:01.780238733 +0900
Change: 2025-01-18 11:20:01.783572128 +0900
 Birth: 2025-01-18 11:20:01.780238733 +0900
```

You can use `-f` to show information about a file's host file system:

```bash
stat -f file
```

It also allows you to specify a format string to selectively output only the
information you need:

```bash
stat -c "'%n' is a %F." file /dev/null /usr /run/initctl # print the file type
stat -c "'%n' has size %s and uses %b blocks." # print size and block number
stat -c "'%n' has access rights: %A (%a in octal)." # print access rights
```
