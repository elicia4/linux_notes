# `dd`

[***Table of Contents***](/README.md)

**!!! WARNING !!!**
**!!! THIS COMMAND IS DESTRUCTIVE !!!**

It's used to copy large blocks of data.

It can be used to copy ordinary files:

```bash
dd if=example.txt of=my_copy.txt
```

But it's mostly used to create back up images of hard drives:

```bash
sudo dd if=/dev/sdX of=my-image.img status=progress
# this will create a disk image 'my-image.img' of the '/dev/sdc' block device
# 'status=progress' shows transfer statistics
```

The image file can be copied back to the hard disk to exactly restore the
previous state by swapping the order of the input and output files:

```bash
# BE CAREFUL
sudo dd if=my-image.img of=/dev/sdX status=progress
```

It can also be used to create large files for testing purposes:

```bash
dd if=/dev/zero of=file-with-zeros bs=1M count=1
# this will create a 1M file filled with zeros
```

To create a 10G file filled with random data:

```bash
dd if=/dev/urandom of=random-data.dat bs=1M count=10240 status=progress
ls -l random-data.dat
head -c 256 random-data.dat | xxd
```

There's a lot you can do with it:
- securely wipe a drive
- back up and restore a disk/partition
- create a compressed disk image
- create a bootable USB drive
- file carving

`dd` has an unusual syntax. It uses `key=value` syntax. 

To overwrite a file/disk/partition with all random data:

```bash
# if = input file
# of = output file
# bs = block size
# conv=noerror - if an error is encountered, the command does not stop
sudo dd if=/dev/urandom of=/dev/sdX bs=1M conv=noerror
```

By default, `dd` uses a block size of 512 bytes. That's slow, to speed it up,
increase the block size to 1M (I'm not sure about this lol).

`conv=noerror` is especially useful while overwriting an old or faulty drive.

You can overwrite a file with random data X times with a script like this:

```bash
for i in {1..7}; 
do 
    sudo dd if=/dev/urandom of=/dev/sdX bs=1M conv=notrunc,noerror;
done
# notrunc = don't truncate the output
```

To back up an entire disk/partition:

```bash
dd if=/dev/sdX of=/dev/sdY bs=1M conv=noerror
```

To restore it, just do the reverse later :)

```bash
dd if=/dev/sdY of=/dev/sdX bs=1M conv=noerror
```

A better idea is to compress the backup:

```bash
dd if=/dev/sdX | gzip -c > /tmp/test.img.gz
```

**The `-c` option in `gzip` is mandatory, by default `gzip` compresses and
deletes the original file. You don't want that.**

You can also back up things to a remote server:

```bash
dd if=/dev/sdX | gzip -c - | ssh user@local dd of=image.gz
# this will save the compressed file to the /home/user directory of the server
```

Once you have the compressed file, you can restore it:

```bash
gzip -dc /tmp/testdisk.img.gz | dd of=/dev/sdb
```

To create a bootable USB drive with `dd`:

```bash
dd if=~/Downloads/image.iso of=/dev/sdUSB bs=1M
```

Once this completes, you have a bootable drive.

You can also do file carving with `dd`. Say you have two ASCII files:

```bash
cat test1.txt
# This is a file.
cat test2.txt
# Another file.
```

To only copy the word 'file' from the second file:

```bash
dd if=test2.txt of=test3.txt bs=1 skip=8 count=4
# bs=1 - 1 byte, in ASCII it's one character
# skip=8 - skip 8 bytes, i.e. 8 characters
# count=4 - use 4 bytes, i.e. 4 characters
# cat test3.txt
# file
```

To get everything from skip+1 to end of file:

```bash
dd if=test2.txt of=test3.txt bs=1 skip=8
# cat test3.txt
# file.
```
