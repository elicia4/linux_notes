# Storage

[***Table of Contents***](/README.md)

The first step in managing a storage device is attaching it to the file system
tree, this process is called *mounting*. It allows the device to interact with
the OS.

A file named [`/etc/fstab`](./fstab.md) lists the devices that are to be
mounted at boot time.

To display a list of currently mounted file systems:

```bash
mount
```

The format of the listing is: `device` on `mount_point` type `file_system_type`
(`options`).

Let's mount a mounted file system to a *new* mount point.

To unmount a file system:

```bash
umount <mount_point>
```

Note that a device cannot be unmounted if it's in use by some process.
Unmounting devices is very important, since to interact with slower devices
Linux creates `buffers` stored in the RAM, thus speeding up the interactions
with the devices, but if they're not in use RAM is just occupied needlessly.
Linux tries to do as much buffering itself as possible, since it speeds up the
system, if RAM is occupied with a bunch of unused storage devices, it cannot
work as efficiently as possible. Some data destined for a device might still be
in RAM, so by unmounting a device you make sure that all the remaining data for
the device is written. If unmounting isn't done properly, it may lead to *file
system corruption.*

To mount it again, create a mount point:

```bash
mkdir /mnt/cd_rom
```

Mount the file system again specifying the file system type (use the `-t`
option):

```bash
mount -t iso9660 /mnt/cdrom 
```

### Device Names

Device and special files are stored in the `/dev` directory. There are patterns
to the device naming in that directory:
- `/dev/fd*` - floppy disk drives
- `/dev/hd*` - IDE (PATA) disks on older systems. Typical motherboards contain
  two IDE connectors (*channels*), each with a cable with two attachment points
  for drives. The first drive on the cable is called the *master* device, and
  the second is called the *slave* device. The device names are ordered such
  that `/dev/hda` refers to the master device on the first channel, `/dev/hdb`
  is the slave device on the first channel; `/dev/hdc` is the master device on
  the second channel, and so on. A trailing digit indicates the partition
  number on the device. For example, `/dev/hda1` refers to the first partition
  on the first hard drive on the system, while `/dev/hda` refers to the entire
  drive.
- `/dev/lp*` - printers.
- `/dev/sd*` - SCSI disks. On modern Linux systems, the kernel treats all
  disk-like devices (including PATA/SATA hard disks, flash drives, and USB mass
  storage devices such as portable music players and digital cameras) as SCSI
  disks. The naming scheme is similar to that described in the `/dev/hd*`
  section.
- `/dev/sr*` - Optical drives (CD/DVD readers and burners). Symbolic links such
  as `/dev/cdrom`, `/dev/dvd`, and `/dev/floppy`, which point to the actual
  device files.

To determine how a removable device is named when it's attached:

```bash
sudo tail -f /var/log/messages # a relic of ancient times
sudo tail -f /var/log/syslog # a relic of ancient times
```

You can achieve the same result with `lsblk` and `journalctl`:

```bash
journalctl # systemd logs, logging is done through 'journald'
watch -d -n 2 lsblk # another solution, updates lsblk output every 2
                    # seconds and highlights the differences in output
```

You are interested in references to new attached disks:

```bash
journalctl | grep "Attached"
```

When you attach a USB drive, you should expect something like this:

> Dec 03 03:03:03 host kernel: sd 2:0:0:0: [sdb] Attached SCSI removable disk

As you can see, the USB (`SCSI removable disk`) attached to `sdb`.

With the device name, you can mount the flash drive:

```bash
sudo mkdir /mnt/flash
sudo mount /dev/sdb /mnt/flash
df
```

### Create New File Systems

To reformat a device (e.g. a flash drive) to a different file system:

1. (optional) Create a new partition layout if the existing one is not to your
   liking.
1. Create a new, empty file system on the drive.

Note that after you do this, the device will be formatted. Don't leave anything
important on it.

`fdisk` allows you to manipulate a device's partition table. To use it,
unmount the device first and then run `fdisk`:

```bash
sudo umount <device-path>
sudo fdisk <device-path>
```

To print the help menu, use the `m` command. `q` to quit.

Show the partition table (`p`). List know partition types (`l`). 

Some programs will use the partition type to limit the kinds of operations that
can be done to the disk, but most of the time it is not critical to change it.

To change a partition's system ID, use `t`, then choose a partition type from
the `l` output, `83` is for Linux. To write the modified partition table, use
`w`.

To create a new file system, use `mkfs` (make file system). To specify a file
system type, use `-t`:

```bash
sudo mkfs -t ext4 <device-path>
```

To reformat a device to the FAT32 file system type:

```bash
sudo mkfs -t vfat <device-path>
```

The partitioning and formatting is done.

### Test and Repair File Systems

The system automatically checks the integrity of file systems on boot before
mounting them. It's done by the `fsck` (file system check). The last number in
the `/etc/fstab` file specifies the order in which the devices are to be
checked, the devices with `0` as the last digit are not routinely checked.
Usually, the root is checked first, followed by home and boot file systems. 
`fsck` can also repair corrupt file systems. Recovered portions are placed in
the `/lost+found` directory.

To check a file system (unmount it first):

```bash
sudo fsck <device-path> 
```

### Moving Data to and from Devices

A disk drive consists of blocks of data. You can clone devices with `dd`:

```bash
dd if=<input_file> of=<output_file> [bs=<block_size> [count=<blocks>]]
```

**Always double-check your input and output specifications before pressing
enter.** For example, if you have two flash drives, `/dev/sdb` and `/dev/sdc`,
you can copy the first drive to the second with the following command:

```bash
dd if=/dev/sdb of=/dev/sdc 
```

Alternatively, you can copy the contents of a drive to an ordinary file for
later copying:

```bash
dd if=/dev/sdb of=flash_drive.img
```
