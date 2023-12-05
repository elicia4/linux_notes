# The `stat` command

[***Table of Contents***](/README.md)

The `stat` command is used to display detailed information about a file and its
attributes:

    touch most-random-filename
    stat most-random-filename

You get the following result:

      File: most-random-filename
      Size: 0               Blocks: 0          IO Block: 4096   regular empty file
    Device: 0,0     Inode: 1234123     Links: 1
    Access: (0644/-rw-r--r--)  Uid: ( 1001/   user)   Gid: ( 1001/   user)
    Access: 2003-11-15 13:00:12.454545451 +0100
    Modify: 2003-11-15 13:00:12.454545451 +0100
    Change: 2003-11-15 13:00:12.454545451 +0100
     Birth: 2003-11-15 13:00:12.454545451 +0100

If you use `touch` on it, the file's times will be updated:

    touch most-random-filename
    stat most-random-filename
