# The `/etc/fstab` file

Notes taken on "Linux Crash Course - The /etc/fstab file" video by LearnLinuxTV

[***Table of Contents***](/README.md)

How does one mount their volumes on system startup?

Be very careful when working with storage. If you enter some commands
incorrectly, you may accidentally wipe the wrong device and break your system,
be VERY careful.

In case you want to follow along, practice on an external storage volume, make 
sure you don't care about the contents BEFORE you play around with it. I
personally played around with a USB drive. You can list your volumes:

    lsblk

You can check if a drive is mounted with `lsblk` too, if it was, then there
would be a `MOUNTPOINT`. 

Let's say you want to mount an `sdx` partition every time you start up your
machine. List mounted storage first:

    mount | grep sdb # to make sure that it's mounted

You should mount permanent storage to `/mnt`, and temporary storage to
`/media`.

You permanently mount storage with the `/etc/fstab` file:

    sudo vim /etc/fstab

`fstab` file is responsible for automatically mounting storage volumes when you
start up your system. Each line is a different storage volume. You can mount 
disk here, network storage volumes. As you can see, the root file system is
part of your system too. If you make a mistake, your PC will not boot.

Add a line break between the content that already exists and the content you
personally want to add.

1. First enter the storage volume; it can be physical device, a USB; can be a
   text label or a UUID (Universaly Unique Identifier); `<file system>`
1. Location you want it to be mounted to, MAKE SURE IT EXISTS; `<mount point>`
1. File system type; most native Linux systems use `ext4` (Fourth Extended File
   System), many others supported (FAT16(`msdos`), FAT32(`vfat`), NTFS(`ntfs`),
   CD-ROM(`iso9660`), etc.; `<type>`
1. File systems can be mounted with various options, for example read-only.
   Enter `defaults`, they will add the default options, they are:
   `rw,suid,dev,exec,auto,nouser,async`. If you don't have specific
   preferences, just use `defaults`; `<options>`
1. The first number refers to "dump", it's a number if and when a file system
   has to be backed up with the `dump` command. It's almost always set to `0`;
   `<dump>`
1. The last digit refers to the order of filesystem integrity checking. The
   ones with `0` won't be checked at all. The root filesystem should arguably
   be first; `<pass>`

For example:

    /dev/sdb1 /mnt/mydisk ext4 defaults 0 0

Make sure you create the "mount point" first.

You can from now on mount your `/dev/sdb1` to `/mnt/mydisk` implicitly like so:

    sudo mount /mnt/mydisk

That will work since the directory is matched to `/mnt/mydisk` in the `fstab`
file:

    cat /etc/fstab | grep mydisk

To unmount:

    sudo umount /mnt/mydisk

To test the `fstab` file (it's not 100% foolproof, you should check the file by
yourself too, but it's good):

    sudo mount -a

If there are errors, something's wrong.

There's a problem with what we've done though. The `sdX` partitions are not
static, their numbers and names can change. So what to you do? Use `UUID`'s.
`UUID`'s never change. To check UUID's of your storage volumes:

    sudo blkid

Compare it with the output of:

    lsblk

Change `fstab` to contain UUID. For example:

    UUID=your-uuid /mnt/mydisk ext4 defaults 0 0

There's an option called `noauto`, you can add it after `defaults` like so:

    UUID=your-uuid /mnt/mydisk ext4 defaults,noauto 0 0
    
`noauto` means that the filesystem won't be automatically mounted. It's the
opposite of auto. 

Another option is `ro`, which means "read-only". You should default everything
to "read-only", unless you have a very specific reason to allow write access to
that particular volume.
