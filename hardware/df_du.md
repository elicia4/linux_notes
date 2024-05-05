# The `df` and `du` commands

Notes taken on the "Linux Crash Course - The `df` and `du` Commands" video by
LearnLinuxTV.

[***Table of Contents***](/README.md)

`df` and `du` are used for monitoring storage.

### df

`df` stands for "disk free". It shows you how much disk space you have free. To
show `df` disk sizes in human-readable format:

```bash
df -h
```

The output is broken down into columns, the are self-explanatory:
- Filesystem - the filesystem path
- Size - total size of the disk
- Used - total used size
- Avail - the amount of storage that is available for use
- Use% - the percentage of the disk that is full
- Mounted on - the location where the filesystem is mounted

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

`df` is useful for general information, it doesn't tell you what folders take
up the most amount of space.

### du

To get the full picture, you should use `du`. To show information about a
particular folder:

```bash
du /home/username
```

The output is quite messy by default. To get human-readable numbers:

```bash
du -h /home/username
```

To give `du` a maximum depth, the number of directories deep the `du` command
will go:

```bash
du -h --max-depth 1 /home/username
```

Try using the summary option (`-s`):

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

This will you information about each file/dir in that directory and list the 
total space.

### ncdu

The `ncdu` command give you a breakdown of all the folders you have. It's easy
to use, press `?` for help if you don't understand something.
