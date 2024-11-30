# `mknod`

[***Table of Contents***](/README.md)

It's used to create special block, character and pipe files:

```bash
sudo mknod -m 666 my_special_file c 1 8
ls -l my_special_file
```

The file located at `/dev/zero` is a special file that always returns an
infinite number of zeros:

```bash
ls -l /dev/zero
head -c 10 /dev/zero | xxd
head -c 100 /dev/zero | xxd
```

You can use the command to create your own version of `/dev/zero`:

```bash
sudo mknod -m 666 my_custom_dev_zero c 1 5
```

- `-m` sets the permissions for the file
- `c` indicates that this will be a character device
- `1` indicates the major number of the device
- `5` indicates the minor number of the device

Now you can use your custom `/dev/zero` like the real `/dev/zero`:

```bash
ls -l my_custom_dev_zero
head -c 100 my_custom_dev_zero | xxd
```

You can also use it to create a special file that represents a block device
(like a hard drive):

```bash
sudo mknod -m 666 my_custom_block_device
```

If you use `b` and the major and minor number of an existing block device,
you'll get a second block device node that represents the same drive:

```bash
sudo fdisk -l my_custom_block_device
sudo fdisk -l /dev/sdX
```

`mknod` can also create named pipes, just like `mkfifo`:

```bash
mknod other-hexdump-fifo p
ls -l other-hexdump-fifo
```

- `b` - create a block (buffered) special file
- `c`, `u` - create a character (unbuffered) special file
- `p` - create a named pipe (FIFO)
