# The `/etc/fstab` file

Notes taken on "Linux Crash Course - The /etc/fstab file" video by LearnLinuxTV

[***go back to README***](/README.md)

How does one mount their volumes on system startup?

Be very careful when working with storage. If you enter some commands
incorrectly, you may accidentally wipe the wrong device and break your system,
be VERY careful.

In case you want to follow along, practice on an external storage volume, make 
sure you don't care about the contents BEFORE you play around with it. I
personally played around with a USB. You can list your volumes:

    lsblk


