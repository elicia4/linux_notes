# Formatting & Mounting Storage Volumes

These are notes on [this video.](https://www.youtube.com/watch?v=2Z6ouBYfZr8)

[***Table of Contents***](/README.md)  

### Introduction

On desktop Linux, storage is mostly handled automatically, file managers do it 
well.

To list all block devices (storage):

```bash
lsblk
```

A block device is a file that refers to a device. A block special file is
normally distinguished from a character special file by providing access to the
device in a manner such that the hardware characteristics of the device are not
visible[^1].

[^1]:[Source](https://unix.stackexchange.com/a/259200)

`lsblk` gives a list of block devices that are attached to your server. Your
devices' `NAME`s will vary from one system to another. You can take a look at a
particular device file in `/dev`:

```bash
ls -l /dev/sda
```

Every device you connect to your Linux machine will be provided a name by the
kernel. But what are the `sda1`, `sda2` etc. files? They are partitions. When 
you work with storage and you target `sda`, you target the entire disk, but if
you target `sda1`, you target only that partition. 

Note that different types of storage devices have a different naming scheme. An
alternative command to list storage:

```bash
sudo fdisk -l 
```

You can remove a storage volume from your file manager's GUI. There's usually 
an eject button next to the volumes on the left. On a server, that's not an 
option since there's no GUI available.

Start with `lsblk`:

```bash
watch -d -n 5.0 lsblk
```

To list all mounted storage devices:

```bash
mount
```

You can `grep` a particular device you need:

```bash
mount | grep sda
```

To unmount a drive:

```bash
lsblk # list all devices
sudo umount {device|mountpoint} # unmount
mount | grep {device|mountpoint} # check again
```

### Create a Parition Table
    
To create a new partition table on a device:

```bash
sudo fdisk /dev/sdb
```

You will be presented with a command prompt, enter `p` to print the current
partition table, or `m` for help. Enter `g` to make a GPT partition table. Then
enter `n` to create a new partition. The next steps are self-explanatory. Don't
worry about the `Do you want to remove the signature?` prompt, the changes
aren't final. To finalize the changes, issue the `w` (write) command.

### Format a Disk With a Filesystem Type

But you're not done yet. You can't use a storage device unless you make a
filesystem on it. The `mkfs` command allows us to format the partition with 
whatever filesystem you want. The filesystem type you should create depends on
the operating system you plan on using with that storage device. 

If you are using the storage device internally, format it with a Linux file
system type. If it's an external flash drive that will be used with a Windows
machine, use `exFAT`. With Linux:

```bash
sudo mkfs.ext4 {path-to-the-device} # format with ext4 fs
```

For flash drive used with Mac or Windows:

```bash
sudo mkfs.exfat {path-to-the-device} # format with exfat fs
```

exFAT is a proprietary Windows technology, you might not have access to it by
default. To install it on Debian:

```bash
sudo apt install exfat-utils exfat-fuse
```

You can give a label with the `-n` option:

```bash
sudo mkfs.exfat -n "label" {path-to-the-device}
```

To see the amount of space used up on your mounted file systems:

```bash
df -h
```
    
### Mounting

Again, on servers disks *do not* get mounted automatically.

Mounting is the act of attaching a storage volume to a directory on a file
system. What directory should you choose? Any directory you want! Though there
are some "appropriate" places for that:

1. `/mnt` - for permanent file systems;
2. `/media` - for temporary storage volumes, those that are not going to be
   attached all the time.

Let's mount something!
    
```bash
ls -l /mnt
sudo mkdir /mnt/disk1 # create a subdir for a new disk
lsblk # take a look at storage volumes
sudo mount {/dev/disk} /mnt/disk1 # mount the needed to disk1
lsblk # check
df -h # check again
```
    
### Check Disk Space with `ncdu`

Let's take a look at a utility for checking and managing storage space on your
server. To scan your filesystem and check what takes up the most space:

```bash
sudo ncdu
```

Install it if it's not installed already, in case your disk fills up you won't
be able to. This command may take a while to run. By default, it scans your
current directory, if you want to scan the entire filesystem:

```bash
sudo ncdu /
```

`ncdu` has its own hotkeys, use `d` for delete, `j` and `k` for movement, `?`
for help.
    
`-x` allows you to exclude filesystems except for the main one:

```bash
sudo ncdu / -x 
```

It won't show anything that is mounted, only the local options.

### `/etc/fstab`

This is a *very* important file on your system, if you make a mistake here, you
can break everything, it allows you to automatically mount something every time
your machine starts. There's already going to be contents inside `fstab`. The
way to edit is covered [here.](./fstab.md)
