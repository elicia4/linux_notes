# The `df` and `du` commands

Notes taken on the "Linux Crash Course - The `df` and `du` Commands" video by
LearnLinuxTV.

[***go back to README***](/README.md)

`df` and `du` are used for monitoring storage.

### df

`df` stands for "disk free". It shows you how much disk space you have free. To
show `df` disk sizes in human-readable format:

    df -h

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

    df -h -T

It gives the filesystem type of the mount, like `ext4`, `tmpfs`, `vfat` and so
on.

The `-x` option allows you to hide stuff from the output, let's hide `tmpfs`:
    
    df -hT -x tmpfs

You can really hide whatever you'd like:

    df -hT -x ext4

Combine options together to save space:

    df -hTx tmpfs

Combine it with `watch` to see changes:

    watch df -hTx tmpfs

If you insert a flash drive into your PC, you will see new output.

`df` is useful for general information, it doesn't tell you what folders take
up the most amount of space.

### du

To get the full picture, you should use `du`. To show information about a
particular folder:

    du /home/username

The output is quite messy by default. To get human-readable numbers:

    du -h /home/username

To give `du` a maximum depth, the number of directories deep the `du` command
will go:

    du -h --max-depth 1 /home/username

Try using the summary option (`-s`):

    du -hs /home/username

This will get you information about the directory itself. You can list multiple
arguments:

    du -hs /home/username /etc
    
To get a total of everything use the `-c` option:

    du -hsc /home/username /etc
    
A great variation of the `du` command:

    du -hsc /directory/*

This will you information about each file/dir in that directory and list the 
total space.

### ncdu

The `ncdu` command give you a breakdown of all the folders you have. It's easy
to use, press `?` for help if you don't understand something.
