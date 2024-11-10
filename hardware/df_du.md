# `df` and `du`

Notes taken on the "Linux Crash Course - The `df` and `du` Commands" video by
LearnLinuxTV.

[***Table of Contents***](/README.md)

`df` and `du` are used for monitoring storage.

### df

`df` stands for "disk free". It shows you how much disk space your filesystems
are using:

```bash
df
```

It shows you a listing of all of your filesystems. Many of these filesystems
such as `loop` and `tmpfs` are used for system purposes.

To show `df` disk sizes in human-readable format:

```bash
df -h
```

A list of partitions can be provided to see usage information for only those
FS's:

```bash
df -h /dev/sda1 /dev/sda5 /dev/sdc1
```

The output is broken down into columns, the are self-explanatory:
- `Filesystem` - the filesystem path
- `Size` - total size of the disk
- `Used` - total used size
- `Avail` - the amount of storage that is available for use
- `Use%`- the percentage of the disk that is full
- `Mounted on` - the location where the filesystem is mounted

Whatever storage you have attached to your system will be shown in the output 
of `df`. 

To add the `Type` column:

```bash
df -h -T
```

It gives the filesystem type of the mount, like `ext4`, `tmpfs`, `vfat` and so
on.

The `-x` option allows you to hide stuff from the output, let's hide `tmpfs`:
    
```bash
df -hT -x tmpfs
```

You can really hide whatever you'd like:

```bash
df -hT -x ext4
```

Combine options together to save space:

```bash
df -hTx tmpfs
```

Combine it with `watch` to see changes:

```bash
watch df -hTx tmpfs
```

If you insert a flash drive into your PC, you will see new output.

To see a total summary of all available space:

```bash
df -h --total
```

You may also be running out of inodes (on most filesystems, they are
preallocated). Use `-i` to see inode usage:

```bash
df -i
```

`df` is useful for general information, it doesn't tell you what directories
take up the most amount of space.

### du

This command is used to show the amount of disk space taken up by parts of your
filesystem.

To show information about a particular file/directory:

```bash
du /home/username
```

By default, the amount of disk space used is printed in KB. To print sizes in
human readable format (Megabytes, Gigabytes etc.):

```bash
du -h /home/username
```

You can specify multiple arguments:

```bash
du -h file1 dir/file2
```

To give `du` a maximum depth, the number of directories deep `du` will go:

```bash
du -h --max-depth 1 /home/username
```

Try using the summary option (`-s`) to omit the printing of subdirectories:

```bash
du -hs /home/username
```

This will get you information about the directory itself. You can list multiple
arguments:

```bash
du -hs /home/username /etc
```
    
To get a total of everything use the `-c` option:

```bash
du -hsc /home/username /etc
```
    
A great variation of the `du` command:

```bash
du -hsc /directory/*
```

For current working directory:

```bash
du -hsc *
```

This will you information about each file/dir in that directory and list the 
total space.

To find the 5 largest files in the current working directory:

```bash
find . -type f -exec du {} \; | sort -n | tail -n 5
```

To list the 5 largest files/directories:

```bash
du -a | sort -n | tail -n 5
```

### ncdu

`ncdu` (NCurses Disk usage) gives you a breakdown of all the directories you
have. It's easy to use, press `?` for help if you don't understand something.

### The Way

Start out with `df -h` and `df -i` to find out which storage volume is having
issues. Then use `du -hsc *` to see which directory is using up the most space.
If you need to dive even deeper, try `ncdu`.
