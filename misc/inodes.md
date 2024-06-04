# Inodes

These notes are on [this video](https://www.youtube.com/watch?v=6KjMlm8hhFA),
various man pages, and Internet resources.

[***Table of Contents***](/README.md)

Files are simple structures that contain no metadata, no information about
themselves. A file is only just a filename and an inode number. Inodes store
metadata for every file on your system in a table-like structure usually
located near the beginning of a partition. They store all the information
except the file name and the data.

Whenever you `ls`, you only look up filenames, but when you `ls -l` you get
additional metadata. You can think of a directory in Linux as something that
contains a table of filename-inode pairings. To see them:

```bash
ls -i
```

What is in each inode? An inode contains: 

- the size of a file in bytes
- the location of the file on a disk
- permissions
- UID 
- GID
- file creation (birth) time
- file modification (modify) time, the last time the contents of the file were
  modified
- file access time, the last time the file was read
- file change time, the last time the metadata of the file was changed
- reference count, that is the number of hard links to the file

Whenever you run `ls -l`, `ls` looks up all the extra information about files
with the help of the inode numbers. It gets the equivalent of:

```bash
stat <filename>
```

`stat` is a syscall (system call) that looks up the metadata of a file. A
system call is something that processes do to ask the kernel to do what *only*
the kernel can do, i.e. read from a disk. It looks up the information from the
file's inode and returns it to the shell.

How does all this inode information practically come into play? At times you
need to look up the number of inodes remaining on your system. You might start
getting various disk errors, even though you have plenty of space left on your
system:

```bash
df -h
```

One thing that can cause that is *inode exhaustion*:

```bash
df -hi
```

You might see that you're using 100% of inodes on your disk, and the errors
happen because a new file requires an inode to be created.

On most filesystems, the size of the inode tables is determined when you create
that filesystem, that happends when you install the operating system and set it
up for the first time. The size of the inode table is usually tied to the size
of the file system. If you have a small disk, especially in the cloud, you
could run out of inodes pretty quickly if you have just a 5 or 10GiB system
especially if you dump a huge number of files there. 

File systems create all the space they're going to have for inodes when the
file system is created *unless* you pass an extra flag during the file system
creation to overwrite that. 

In some filesystems, like *zfs*, you can create inodes on demand. In those
filesystems inodes are created when you create a file, not on file system
creation time. The space for inodes on those filesystems is not fixed and works
in a different way.
